#!/bin/bash
# Nothing to see here. Move along.
# You break it, you fix it.
YOURTRAINSTRATIONID="$1"
DESTINATIONSTATION="$2"
NOW=$(date +%Y-%m-%dT%X);
AFTER=$(date -d '+1 hour' +%Y-%m-%dT%X);

curl 'http://infraestruturasdeportugal.pt/negocios-e-servicos/horarios/partidas/'"$YOURTRAINSTRATIONID"'/'"$NOW"'+'"$AFTER"'' | jq -c '.[]|.[]|.[]' | grep -B0 -A3 "$DESTINATIONSTATION" | head -3 | awk 'NR % 3 == 0' | sed 's/.*\"Descricao\"://' | sed 's/}//'