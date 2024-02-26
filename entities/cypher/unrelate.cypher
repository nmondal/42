MATCH (a {urn:'${e1}'})-[r:${name}]-(b {urn:'${e2}'})
SET r.endTime = datetime()
