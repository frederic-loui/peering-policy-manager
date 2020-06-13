from ppm import ppm
import os,glob,re,json

@ppm.route('/')
@ppm.route('/index')

def index():
    return "Peering Policy Manager"

@ppm.route('/api/routers')
def routers():
    json_dir="%s/ppm-run/json" % os.getenv("HOME")
    os.chdir(json_dir)
    out = "{'routers':["
    out = ""

    for router in glob.glob("*.json"):
        if out is  "":
            out = "\'%s\'" % re.sub(r".json","",router)
        else:
            out = "%s,\'%s\'" % (out,re.sub(r".json","",router))

    out = "{'routers':[%s]}" % out

    return out

@ppm.route('/api/peers/<router>')
def peers(router):
    abs_path="%s/ppm-run/json" % os.getenv("HOME")
    with open("%s/%s.json" % (abs_path,router)) as json_file:
        return json_file.read()
