MATCH (a {urn:"${1}"})-[r:${3}]-(b {urn:"${2}"})
SET r.endTime = datetime()
