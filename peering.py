#! /usr/bin/env python3

###############################################################################
#
# Copyright 2019-present PEERING POLICY MANGER project (Frederic LOUI)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed On an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
###############################################################################

from threading import Thread
import argparse, glob,os, sys,logging,  re, linecache, json
from time import sleep

from ciscoconfparse import CiscoConfParse

# set our lib path
sys.path.append(
    os.path.join(os.path.dirname(os.path.abspath(__file__)), "./")
)

PROGRAM_NAME = os.path.basename(sys.argv[0])
CONFIG_TYPE_JUNOS=0
CONFIG_TYPE_IOSXR=1
CONFIG_TYPE_IOSXE_=2
CONFIG_TYPE_IOS=3
CONFIG_TYPE_FOS=4

log_level = logging.WARNING

logger = logging.getLogger(PROGRAM_NAME)
if not len(logger.handlers):
    logger.addHandler(logging.StreamHandler())
    logger.setLevel(log_level)

def _Exception():
    exc_type, exc_obj, tb = sys.exc_info()
    f = tb.tb_frame
    lineno = tb.tb_lineno
    filename = f.f_code.co_filename
    linecache.checkcache(filename)
    line = linecache.getline(filename, lineno, f.f_globals)
    return 'EXCEPTION IN ({}, LINE {} "{}"): {}'.format(filename, lineno, line.strip(), exc_obj)

def _getClassName(instance):
    return instance.__class__.__name__



class PPM(Thread):
    def __init__(self, threadID, cfg_dir, json_dir):
        Thread.__init__(self)
        self.threadID = threadID
        self.name = _getClassName(self)
        logger.warning("%s - _init_" % PROGRAM_NAME)
        self.die=False
        self.cfg = ""
        self.cfg_dir = cfg_dir
        self.json_dir = json_dir
        self.cfg_type = CONFIG_TYPE_IOSXR

    def run(self):
        logger.warning("%s - Main" % (self.name))
        logger.warning("%s - Entering message loop" % (self.name))
        while not self.die:
            self.getAsnPeerListFromAllRouters()
            exit(0)
    def getAsnPeerListFromAllRouters(self,):
        os.chdir(self.cfg_dir)
        logger.warning("CFG_DIR: %s" % self.cfg_dir)
        cfg_iosxr_regexp = "00309[1-9]"
        cfg_junos_regexp = "00313[1-9]"

        for file in glob.glob("*.cfg"):
            logger.warning("CFG_FILE: %s" % file)
            if re.search(cfg_junos_regexp,file):
                self.getAsnPeerList(file, CONFIG_TYPE_JUNOS)
            elif re.search(cfg_iosxr_regexp,file):
                self.getAsnPeerList(file, CONFIG_TYPE_IOSXR)
            ACTIVE_PEERS=[]

    def getAsnPeerList(self, cfg, cfg_type):
        if cfg_type==CONFIG_TYPE_JUNOS:
            self.getAsnPeerListFromJunos(cfg)
        if cfg_type==CONFIG_TYPE_IOSXR:
            self.getAsnPeerListFromIosXR(cfg)

    def getAsnPeerListFromJunos(self, cfg):
        parse = CiscoConfParse("%s" % cfg, syntax='junos', comment='#!')
        peer_list_obj=parse.find_objects(" peer-as")
        peer_list=[]
        logger.warning("CFG_JUNOS: %s" % cfg)
        for peer in peer_list_obj:
            if not peer.text in peer_list:
                peer_list.append(peer.text)
        for peer in peer_list:
            PEER = {}
            PEER["asn"] = ""
            PEER["remote_neighbors"] = []
            remote_neighbors = parse.find_parents_w_child(r"  neighbor ", peer)

            for neighbor in remote_neighbors:
                PEER["remote_neighbors"].append(re.sub(r"\s+|neighbor", "", neighbor))

            if len(PEER["remote_neighbors"]) == 0:
                peer_as_parents=parse.find_parents_w_child(r"group", peer)
                for parent in peer_as_parents:
                    remote_neighbors = parse.find_children_w_parents(parent, r"  neighbor ")
                    for neighbor in remote_neighbors:
                        PEER["remote_neighbors"].append(re.sub(r"\s+|neighbor", "", neighbor))

            if not len(PEER["remote_neighbors"]) == 0:
                PEER["asn"] = re.sub(r"\s+|peer-as","",peer)
                ACTIVE_PEERS.append(PEER)

        logger.warning("%s" % (ACTIVE_PEERS))
        with open("%s/%s.json" % (self.json_dir,re.sub(r".cfg$","",cfg)), 'w') as outjsonfile:
            json.dump(ACTIVE_PEERS, outjsonfile)

    def getAsnPeerListFromIosXR(self,cfg):
        parse = CiscoConfParse("%s" % cfg, syntax='ios', comment='!')
        peer_list_obj=parse.find_objects("^  remote-as")
        peer_list=[]
        logger.warning("CFG_IOSXR: %s" % cfg)
        for peer in peer_list_obj:
            if not peer.text in peer_list:
                peer_list.append(peer.text)

        logger.warning("%s" % peer_list)

        for peer in peer_list:
            PEER = {}
            PEER["asn"] = ""
            PEER["remote_neighbors"] = []
            remote_neighbors = parse.find_parents_w_child(r"^ neighbor ", peer)
            logger.warning("REMOTE_NEIGHBORS=%s" % remote_neighbors)

            for neighbor in remote_neighbors:
                PEER["remote_neighbors"].append(re.sub(r"\s+|neighbor", "", neighbor))

            if not len(PEER["remote_neighbors"]) == 0:
                PEER["asn"] = re.sub(r"\s+|remote-as","",peer)
                ACTIVE_PEERS.append(PEER)

        logger.warning("%s" % (ACTIVE_PEERS))
        with open("%s/%s.json" % (self.json_dir,re.sub(r".cfg$","",cfg)), 'w') as outjsonfile:
            json.dump(ACTIVE_PEERS, outjsonfile)

def str2bool(v):
    if isinstance(v, bool):
       return v
    if v.lower() in ('yes', 'true', 't', 'y', '1'):
        return True
    elif v.lower() in ('no', 'false', 'f', 'n', '0'):
        return False
    else:
        raise argparse.ArgumentTypeError('Boolean value expected.')

def is_any_thread_alive(threads):
    return True in [t.isAlive() for t in threads]

def graceful_exit(cfg_fh):
    #t.interface._tear_down_stream()
    cfg_fh.close()
    sys.exit(0)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Peering Policy Manager")

    parser.add_argument(
        "--oxidized-address",
        help="freerouter address",
        type=str,
        action="store",
        required=False,
        default="127.0.0.1",
    )
    parser.add_argument(
        "--oxidized-port",
        help="freerouter port",
        type=int,
        action="store",
        required=False,
        default=9080,
    )
    parser.add_argument(
        "--equipment-config-dir",
        help="Path to the directory where the configs are stored",
        type=str,
        action="store",
        required=False,
        default="%s/ppm-run/cfg" % os.getenv("HOME"),
    )
    parser.add_argument(
        "--equipment-json-dir",
        help="Path to the directory where the configs are stored",
        type=str,
        action="store",
        required=False,
        default="%s/ppm-run/json" % os.getenv("HOME"),
    )
    parser.add_argument(
        "--parsing-interval",
        help="Interval in seconds between updates of the MIB objects",
        type=int,
        action="store",
        required=False,
        default=60,
    )

    args = parser.parse_args()

    try:
        ACTIVE_PEERS = []

        #cfg = "tour-rtr-091"

        ppm = PPM(1,args.equipment_config_dir,
                    args.equipment_json_dir,)

        ppm.daemon=True
        ppm.start()

        ALL_THREADS = [ppm]

        while is_any_thread_alive(ALL_THREADS):
            [t.join(1) for t in ALL_THREADS
                         if t is not None and t.isAlive()]

    except KeyboardInterrupt:
        logger.warning("\n%s - Received signal 2 ..." % PROGRAM_NAME)
        for t in ALL_THREADS:
            t.die = True
        logger.warning("%s - Quitting !" % PROGRAM_NAME)
        graceful_exit()
