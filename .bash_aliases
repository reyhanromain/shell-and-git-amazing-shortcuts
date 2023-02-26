if [ -z "${SAGAS+x}" ]; then
    echo "ERROR: Couldn't find the general path aka SAGAS"
    return
fi

if [ ! -f "$SAGAS.env" ]; then
    echo "ERROR: Couldn't find the env file, please create one from env.example file"
    return
fi

set -a
source <(cat $SAGAS.env | \
    sed -e '/^#/d;/^\s*$/d' -e "s/'/'\\\''/g" -e "s/=\(.*\)/='\1'/g")
set +a

if [ -z "${ALIAS_RESOURCES+x}" ]; then
    echo "ERROR: Couldn't find the ALIAS_RESOURCES key, please check your env file"
    return
fi

IFS=',' read -r -a ALIAS_RESOURCES_ARR <<< "$ALIAS_RESOURCES"

for ALIAS_RESOURCE in "${ALIAS_RESOURCES_ARR[@]}"; do
    if [ -f "$SAGAS""rsc/aliases/""$ALIAS_RESOURCE.bash_aliases" ]; then
        . "$SAGAS""rsc/aliases/""$ALIAS_RESOURCE.bash_aliases"
    fi
done