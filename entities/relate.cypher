MATCH (a:Entity), (b:Entity) WHERE a.urn = "%s" AND b.urn = "%s" 
CREATE (a)-[r:%s]->(b)  
RETURN a,b 
