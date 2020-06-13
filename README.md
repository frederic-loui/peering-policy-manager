# Peering Policy Manager
A comprehensive set of peering policy tools for ASN/BGP peering management.

Made by Peering Managers

# Data source
* [PeeringDB](https://www.peeringdb.com/) ASN record
* Internet Network router configuration retrieved by a CMDB software such as [Oxidized](https://github.com/ytti/oxidized) or [Rancid](https://shrubbery.net/rancid/)
* Network accounting data collected via Netflow/IPFIX/Sflow
* Network Cost parameter (IXP OTC/MRC, Transit OTC/MRC, PNI OTC/NRC)
* 95th percentile is used to expressed Bandwidth consumption 
* network accounting data reflect the actual traffic level

Vizualization unit: Monthly / Weekly / Daily

# Peering Policy Manager (PPM) Tool set
## List of peers 
* from network configuration
* From CRM software for customer peer

`==> Comparison of the 2 lists above`

4 categories: 
* Customer relationship BGP Peering 
(might not come all from [PeeringDB](https://www.peeringdb.com/) as come customer can have RFC1918 ASN)
* Peering relationship BGP Peering
* Private Peering relationship
* Transit peering relationship

By location: 
* with data coming from [PeeringDB](https://www.peeringdb.com/)
* with data coming from [DCIM](https://en.wikipedia.org/wiki/Data_center_management#Data_center_infrastructure_management) system

With information
* IPv4/IPv6 interconnect/remote-peer
* remote ASN

## Network metrology per peer
* From netflow/IPFIX/Sflow accounting system (or raw data)
* real traffic with automatic 95th percentile computation

## Top <x> ASN (<x> to be configurable)
* dashboard in list form
* dashboard in graphical form such as PIE, [Radial Stacked bar](https://observablehq.com/@d3/radial-stacked-bar-chart), [SANKEY DIAGRAM](https://observablehq.com/@d3/sankey-diagram)
* dahsboard per category (Peer, Transit, PNI)

## Geographic vizualization
* geo-map ([OpenStreetMap](https://www.openstreetmap.org/) like vizualization of peerings)
* [Geo-map traffic concentration](https://observablehq.com/@d3/bubble-map)
* [Geo map traffic level quantization](https://observablehq.com/@d3/choropleth)

## Accounting/Finance vizualization
* Cost per peer category: Transit/IXP/PNI
* Aggregated cost per week / month / year of the whole peering activity: Transit/IXP/PNI
 
## A looking glass dashboard (use of [FreeRouter](http://freerouter.nop.hu/))
* Provide local looking glass server
* Provide a list of SP looking glass ([Peeringdb](https://www.peeringdb.com/)?)

## A BMP server (use of [FreeRouter](http://freerouter.nop.hu/))
* ebgp session
* ibgp session monitoring(?)
* BGP hijack detection (?)

## ROA/RPKI (use of [FreeRouter](http://freerouter.nop.hu/))
* ROA/RPKI passive check for notification to an active system
* RIR integration (?)

# Authentication
* OAUTH
* OpenIdConnect
* SAML
* local

# Authorization
* Adminitsrator: R/W
* User: R/O

# Implementation platform/framework
* Web application
* All client type mobile/tablet/laptop/desktop

`=> [FLUTTER](https://flutter.dev/) ?`
