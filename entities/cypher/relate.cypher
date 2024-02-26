MATCH (a), (b) WHERE a.urn = '${e1}' AND b.urn = '${e2}'
CREATE (a)-[r:${relation_name} { startTime: datetime(), endTime: null } ]->(b)
RETURN a,b 
