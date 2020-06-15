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
import argparse, glob,os, sys,logging,  re, linecache, json,ipaddress
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
        parse = CiscoConfParse("%s" % cfg, syntax='junos', comment='#')
        intf_data = self.getInterfaceListFromJunos(parse,cfg)
        #logger.warning("INTF_DATA:%s" % intf_data)
        peer_list_obj=parse.find_objects(" peer-as")
        peer_list=[]
        logger.warning("CFG_JUNOS: %s" % cfg)
        for peer in peer_list_obj:
            if not peer.text in peer_list:
                peer_list.append(peer.text)
        #logger.warning("PEER_LIST:%s" % peer_list)
        for peer in peer_list:
            PEER = {}
            PEER["asn"] = ""
            PEER["remote_neighbors"] = []
            peer_ip=""
            remote_neighbors = parse.find_parents_w_child(r"  neighbor ", peer)
            #intf_data = {}
            for neighbor in remote_neighbors:
                peer_ip=re.sub(r"\s+|neighbor", "", neighbor)
                peer_info = self.getPeerInterfaceSubnetJunos(intf_data,peer_ip)
                #logger.warning("PEER_INFO_1:%s" % peer_info)
                if intf_data is not None:
                    PEER["remote_neighbors"].append(peer_info)

            if len(PEER["remote_neighbors"]) == 0:
            #if PEER["remote_neighbors"] is None:
                peer_as_parents=parse.find_parents_w_child(r"group", peer)
                for parent in peer_as_parents:
                    remote_neighbors = parse.find_children_w_parents(parent, r"  neighbor ")
                    for neighbor in remote_neighbors:
                        peer_ip=re.sub(r"\s+|neighbor", "", neighbor)
                        peer_info = self.getPeerInterfaceSubnetJunos(intf_data,peer_ip)
                        #logger.warning("PEER_INFO_2:%s" % peer_info)
                        if peer_info is not None:
                        #PEER["remote_neighbors"].append(re.sub(r"\s+|neighbor", "", neighbor))
                            PEER["remote_neighbors"].append(peer_info)

            #if not PEER["remote_neighbors"] is None :
            if not len(PEER["remote_neighbors"]) == 0:
                PEER["asn"] = re.sub(r"\s+|peer-as","",peer)
                ACTIVE_PEERS.append(PEER)

        logger.warning("%s" % (ACTIVE_PEERS))
        with open("%s/%s.json" % (self.json_dir,re.sub(r".cfg$","",cfg)), 'w') as outjsonfile:
            json.dump(ACTIVE_PEERS, outjsonfile)
            ACTIVE_PEERS.clear()

    def getInterfaceListFromIosXR(self,parse,cfg):
        branchspec = (r'^interface', r'address')
        branches = parse.find_object_branches(branchspec=branchspec)
        out={}
        for branch in branches:
            intf =""
            local_ip =""
            for elt in branch:
                if elt is not None:
                    if re.search(r"^interface", elt.text):
                        intf=re.sub(r"\s+|interface","",elt.text)
                    if re.search(r"address", elt.text):
                        local_ip=re.sub(r"^\s+|address|ipv4|ipv6","",elt.text).strip()
                        local_ip=re.sub(r"\s","/",local_ip)
                        ipaddress.ip_network(local_ip,strict=False)
                        out["%s" % local_ip]="%s" % intf
        return out


    def getAsnPeerListFromIosXR(self,cfg):
        parse = CiscoConfParse("%s" % cfg, syntax='ios', comment='!',factory=True)
        intf_data=self.getInterfaceListFromIosXR(parse ,cfg)
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
            peer_ip = ""
            remote_neighbors = parse.find_parents_w_child(r"^ neighbor ", peer)
            logger.warning("REMOTE_NEIGHBORS=%s" % remote_neighbors)

            for neighbor in remote_neighbors:
                peer_ip=re.sub(r"\s+|neighbor", "", neighbor)
                peer_info = self.getPeerInterfaceSubnetIosXR(intf_data,peer_ip)
                if peer_info is not None:
                    PEER["remote_neighbors"].append(peer_info)

            if not len(PEER["remote_neighbors"])==0:
                PEER["asn"] = re.sub("\s+|remote-as","",peer )
                ACTIVE_PEERS.append(PEER)

        logger.warning("%s" % (ACTIVE_PEERS))
        with open("%s/%s.json" % (self.json_dir,re.sub(r".cfg$","",cfg)), 'w') as outjsonfile:
            json.dump(ACTIVE_PEERS, outjsonfile)
            ACTIVE_PEERS.clear()


    def getPeerInterfaceSubnetIosXR(self,subnets_list,peer_ip):
        out={}
        for subnet in subnets_list.keys():
            try:
                intf_ip_subnet = ipaddress.ip_network(subnet,False)
                local_ip = ipaddress.ip_address(peer_ip)
                if local_ip in intf_ip_subnet:
                    #ip_local=re.sub(r"%s"%intf_ip,"",subnet)
                    ip_network=intf_ip_subnet.network_address
                    ip_netmask=intf_ip_subnet.netmask
                    ip_cidr=intf_ip_subnet.prefixlen
                    local_intf=subnets_list[subnet]
                    #logger.warning("LOCAL_IP:%s" % (ip_local))
                    #logger.warning("IP_NETWORK:%s" % (ip_network))
                    #logger.warning("IP_NETMASK:%s" % (ip_netmask))
                    #logger.warning("IP_CIDR:%s" % (ip_cidr))
                    #logger.warning("LOCAL_INTF: %s" % (local_intf) )
                    out["local_ip"]="%s" % local_ip
                    out["peer_ip"]="%s" % peer_ip
                    out["subnet"]="%s" % ip_network
                    out["cidr"]="%s" % ip_cidr
                    out["interface"]="%s" % local_intf
                    return out
            except (ValueError, TypeError):
                logger.warning("%s is not a valid IPv4/IPv6 network:" % (ipaddr))

    def getInterfaceListFromJunos(self,parse,cfg):
        parse_intf=CiscoConfParse(parse.find_all_children("^interface"))
        branchspec = (r'^interface', r'^    [a-z]{2}', r'unit', r'family inet', r'address')
        branches = parse_intf.find_object_branches(branchspec=branchspec)
        subnets_list = {}
        for branch in branches:
            intf =""
            unit =""
            local_ip =""
            intf_data =""
            for elt in branch:
               if elt is not None:
                  if not re.search(r"inactive",elt.text):
                     if re.search(r"^    [a-z]{2}",elt.text):
                        intf=re.sub(r"\s+|{","",elt.text)
                     if re.search(r"unit",elt.text):
                        unit=re.sub(r"\s+|unit|{","",elt.text)
                     if re.search(r"address",elt.text):
                        local_ip=re.sub(r"\s+|address|{","",elt.text)
                        intf_data = "{interface:%s.%s,local_ip:%s}" % (intf,unit,local_ip)
                        subnets_list[local_ip]="%s.%s" % (intf,unit)
        return subnets_list

    def getPeerInterfaceSubnetJunos(self,subnets_list,peer_ip):
        #{local_ip:1.1.1.1,ip_network:1.1.1.0,ip_cidr:24,ip_intf:xe-0/0/0.0}
        out={}
        for subnet in subnets_list.keys():
            try:
                intf_ip_subnet = ipaddress.ip_network(subnet,False)
                intf_ip = ipaddress.ip_address(peer_ip)
                if intf_ip in intf_ip_subnet:
                    ip_local=re.sub(r"\s|/[0-9]+$","",subnet)
                    ip_network=intf_ip_subnet.network_address
                    ip_netmask=intf_ip_subnet.netmask
                    ip_cidr=intf_ip_subnet.prefixlen
                    local_intf=subnets_list[subnet]
                    #logger.warning("LOCAL_IP:%s" % (ip_local))
                    #logger.warning("IP_NETWORK:%s" % (ip_network))
                    #logger.warning("IP_NETMASK:%s" % (ip_netmask))
                    #logger.warning("IP_CIDR:%s" % (ip_cidr))
                    #logger.warning("LOCAL_INTF: %s" % (local_intf) )
                    out["local_ip"]="%s" % ip_local
                    out["peer_ip"]="%s" % peer_ip
                    out["subnet"]="%s" % ip_network
                    out["cidr"]="%s" % ip_cidr
                    out["interface"]="%s" % local_intf
                    return out
            except (ValueError, TypeError):
                logger.warning("%s is not a valid IPv4/IPv6 network:" % (ipaddr))

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
        help="oxidized address",
        type=str,
        action="store",
        required=False,
        default="127.0.0.1",
    )
    parser.add_argument(
        "--oxidized-port",
        help="oxidized port",
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
