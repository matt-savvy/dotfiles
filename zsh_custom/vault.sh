service=concierge
env=ps

jurisdiction=us-nc
vault kv get -mount=scorebet -format json $service/$env/$jurisdiction | jq .data.data > $jurisdiction-vault.txt

jurisdiction=us-ny
vault kv get -mount=scorebet -format json $service/$env/$jurisdiction | jq .data.data > $jurisdiction-vault.txt

