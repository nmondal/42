MATCH (n {urn: '${urn}'})-[r]-(b)
RETURN type(r) as name, b.urn as other, (startNode(r) = n) as is_start

