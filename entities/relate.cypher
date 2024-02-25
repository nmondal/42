MATCH (a:Entity), (b:Entity) WHERE a.urn = '${1}' AND b.urn = '${2}' 
CREATE (a)-[r:%s { startTime: datetime(), endTime: null } ]->(b)  
RETURN a,b 
