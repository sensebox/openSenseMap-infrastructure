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
- Ip 52.57.90.92
- Services:
  - Webserver
    - opensensemap.org, www.opensensemap.org
    - sensebox.de, www.sensebox.de
    - docs.opensensemap.org
    - books.sensebox.de, www.books.sensebox.de
    - archive.opensensemap.org
    
    
## Domains
#### opensensemap.org
- Registriert über Sergey, liegt beim Webteam
- DNS über Route53 bei AWS

##### A Records
opensensemap
