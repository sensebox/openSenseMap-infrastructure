# opensensemap.org

opensensemap.org besteht aus mehreren services auf mehreren hosts

- [Services](#services)
- [Hosts](#hosts)
- [Domains](#domains)

## Services
#### Webserver
- Repository: https://github.com/sensebox/osem-caddy

#### Frontend
- Repository: https://github.com/sensebox/OpenSenseMap

#### API
- Repository: https://github.com/sensebox/OpenSenseMap-API

#### Mailer
- Repository: https://github.com/sensebox/sensebox-mailer

#### Datenbank (MongoDB)
- Standard MongoDB als Replicatset mit 1 Master 1 Slave 1 Arbiter auf 3 Hosts

## Hosts
opensensemap.org läuft komplett auf AWS in mehreren EC2 Instanzen

#### web-api-other
- Ip 52.57.90.92 Elastic IP (172.31.20.169)
- External Ports: 80, 443, 8000
- ssh, dockermachine from 128.176.0.0
- AWS t2.large
- 20 GiB EBS
- Services:
  - Webserver (Caddy)
    - opensensemap.org, www.opensensemap.org (root directive)
    - api.opensensemap.org (proxy directive)
    - sensebox.de, www.sensebox.de (proxy directive)
    - docs.opensensemap.org (git directive)
    - books.sensebox.de, www.books.sensebox.de (git directive)
    - archive.opensensemap.org (git directive)
  - Api
  - Mailer
  - Archiver
  - MongoDB Arbiter
  
#### mongo1
- Ip 52.59.27.213 (172.31.22.218)
- External Ports: none (not reachable from Internet)
- ssh, dockermachine from 128.176.0.0
- AWS t2.medium
- 20 GiB EBS
- Services:
  - MongoDB 

#### mongo2
- Ip 52.59.43.198 (172.31.16.62)
- External Ports: none (not reachable from Internet)
- ssh, dockermachine from 128.176.0.0
- AWS t2.medium
- 20 GiB EBS
- Services:
  - MongoDB

## Domains
#### opensensemap.org
- Registriert über Sergey, liegt beim Webteam
- DNS über Route53 bei AWS

##### A Records
- opensensemap.org -> 52.57.90.92
- www.opensensemap.org -> 52.57.90.92
- api.opensensemap.org -> 52.57.90.92
- archive.opensensemap.org -> 52.57.90.92
- docs.opensensemap.org -> 52.57.90.92
- mobile.opensensemap.org - > 35.156.39.83 // bachelorarbeit norwin
- api.mobile.opensensemap.org -> 35.156.39.83 // bachelorarbeit norwin
- www.mobile.opensensemap.org -> 35.156.39.83 // bachelorarbeit norwin
