MATCH (a {urn:'${e1}'})-[r:${relation_name}]->(b {urn:'${e2}'})
SET r.endTime = datetime()
