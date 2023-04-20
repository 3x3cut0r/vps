#!/bin/bash
# synapse
# cp -Lr /opt/certs/fullchain.pem /opt/docker/volumes/synapse-data/_data/3x3cut0r.de.tls.crt
# cp -Lr /opt/certs/privkey.pem /opt/docker/volumes/synapse-data/_data/3x3cut0r.de.tls.key
# cp -Lr /opt/certs/dhparam.pem /opt/docker/volumes/synapse-data/_data/dhparam.pem
# chown 166526:166526 /opt/docker/volumes/synapse-data/_data/3x3cut0r.de.tls*

# mailu
# cp -Lr /opt/certs/fullchain.pem /opt/docker/config-files/mailu/certs/cert.pem
# cp -Lr /opt/certs/privkey.pem   /opt/docker/config-files/mailu/certs/key.pem
# cp -Lr /opt/certs/dhparam.pem   /opt/docker/config-files/mailu/certs/dhparam.pem
# chown docker:docker /opt/docker/config-files/mailu/certs/*.pem
#
# cp -Lr /opt/certs/fullchain.pem /opt/docker/volumes/mailu-certs/_data/cert.pem
# cp -Lr /opt/certs/privkey.pem   /opt/docker/volumes/mailu-certs/_data/key.pem
# cp -Lr /opt/certs/dhparam.pem   /opt/docker/volumes/mailu-certs/_data/dhparam.pem
# chown docker:docker /opt/docker/volumes/mailu-certs/_data/*.pem

# coturn
# cp -Lr /opt/certs/fullchain.pem /opt/docker/config-files/coturn/turn_server_cert.pem
# cp -Lr /opt/certs/privkey.pem   /opt/docker/config-files/coturn/turn_server_pkey.pem
# cp -Lr /opt/certs/dhparam.pem   /opt/docker/config-files/coturn/turn_server_dhparam.pem
# chown docker:docker /opt/docker/config-files/coturn/*.pem
# chmod 644 /opt/docker/config-files/coturn/*.pem