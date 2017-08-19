#! /bin/sh

ENV="${ENV:-local}"
MULE_EXTERNAL_IP="${MULE_EXTERNAL_IP:-127.0.0.1}"

sed -i -e"s|Djava.rmi.server.hostname=.*|Djava.rmi.server.hostname=${MULE_EXTERNAL_IP}|g" ${MULE_HOME}/conf/wrapper.conf

echo "starting mule: ENV[$ENV] "

$MULE_HOME/bin/mule console -M-Dmule_env=$ENV

exec "$@"