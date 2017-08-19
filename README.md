# Mule ESB Community Edition Docker Image
Docker image with Mule ESB on Alpine Linux and Oracle Java 8.


## Volumes
- /opt/mule-standalone/logs       - Log output directory.
- /opt/mule-standalone/config     - Directory containing configuration for applications, domains etc.
- /opt/mule-standalone/apps       - Deployment directory for Mule applications.
- /opt/mule-standalone/domains    - Deployment directory for Mule domains.

## Exposed ports
- 8081  - Default HTTP port.
- 8082  - Default HTTPS port.