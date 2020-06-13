# Peering Policy Manager
A comprehensive peering policy tools/dashboard for ASN/BGP peering management tool set
95th percentile is used to expressed Bandwidth consumption even though network accounting data reflect the actual traffic level

# Data source
* [PeeringDB](https://www.peeringdb.com/) ASN record
* Internet Network router configuration retrieved by a CMDB software such as [Oxidized](https://github.com/ytti/oxidized) or [Rancid](https://shrubbery.net/rancid/)
* Network accounting data collected via Netflow/IPFIX/Sflow
* Network Cost parameter (IXP OTC/MRC, Transit OTC/MRC, PNI OTC/NRC)

Vizualization unit: Monthly / Weekly / Daily

# Peering Policy Manager (PPM) Tools set
## List of peers 
* from network configuration)
* From CRM software for customer peer
`==> Comparison of the 2 lists above`

4 categories: 
Customer relationship BGP Peering (might not come all from PeeringDB as come customer can have RFC1918 ASN)
Peering relationship BGP Peering
Private Peering relationship
Transit peering relationship

By location: 
* with data coming from PeeringDB
* with data coming from DCIM system 

With information
IPv4/IPv6 interconnect
remote ASN

## Network metrology per peer
* From netflow/IPFIX/Sflow accounting system (or raw data)
* real traffic with automatic 95th percentile computation

## Top <x> ASN (<x> to be configurable)
dashboard in list form
dashboard in graphical form such as PIE, [Radial Stacked bar](https://observablehq.com/@d3/radial-stacked-bar-chart), [SANKEY DIAGRAM](https://observablehq.com/@d3/sankey-diagram)
dahsboard per category (Peer, Transit, PNI)

## Geographic vizualization
* geo-map (OpenStreetMap like vizualization of peerings)
* Geo-map concentration
* Geo map traffic level quantization

## Accounting/Finance vizualization
* Cost per peer category: Transit/IXP/PNI
* Aggregated cost per week / month / year of the whole peering activity: Transit/IXP/PNI

# Authentication
OAUTH/OpenIdConnect/SAML/local
# Authorization
Adminitsrator: R/W
User: R/O

# Implementation platform/framework
* Web application
* All client type mobile/tablet/laptop/desktop
`=> [FLUTTER](https://flutter.dev/) ?`
