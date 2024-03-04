MATCH (n {urn: '${urn}'})-[r]-(b)
RETURN type(r) as name, b.urn as other, (r.endDate is not null) as active, (startNode(r) = n) as is_start

