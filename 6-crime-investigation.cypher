MATCH (o:Officer {badge_no: "26-5234182"})<-[:INVESTIGATED_BY]-(c:Crime {last_outcome: "Under investigation"})
RETURN o,c;

MATCH (o:Officer {badge_no: "26-5234182"})<-[:INVESTIGATED_BY]-(c:Crime {last_outcome: "Under investigation", type: "Drugs"})
RETURN o,c;

MATCH (c:Crime {last_outcome: 'Under investigation', type: 'Drugs'})-[:INVESTIGATED_BY]->(:Officer {badge_no: '26-5234182'}),
(c)<-[:PARTY_TO]-(p:Person)
WITH COLLECT(p) AS persons
UNWIND persons AS p1
UNWIND persons AS p2
WITH * WHERE id(p1) < id(p2)
MATCH path = allshortestpaths((p1)-[:KNOWS|KNOWS_LW|KNOWS_SN|FAMILY_REL|KNOWS_PHONE*..3]-(p2))
RETURN path;