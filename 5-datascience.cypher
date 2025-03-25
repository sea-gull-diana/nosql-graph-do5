CALL db.schema.visualization;

/*
╒══════════════════════════════════════════════════════════════════════╤══════════════════════════════════════════════════════════════════════╕
│nodes                                                                 │relationships                                                         │
╞══════════════════════════════════════════════════════════════════════╪══════════════════════════════════════════════════════════════════════╡
│[(:Continent {name: "Continent",indexes: [],constraints: ["Constraint(│[[:IN_COUNTRY {name: "IN_COUNTRY"}], [:IN_COUNTRY {name: "IN_COUNTRY"}│
│ id=22, name='continents', type='NODE PROPERTY UNIQUENESS', schema=(:C│], [:IN_COUNTRY {name: "IN_COUNTRY"}], [:HAS_ROUTE {name: "HAS_ROUTE"}│
│ontinent {code}), ownedIndex=21 )"]}), (:Airport {name: "Airport",inde│], [:IN_REGION {name: "IN_REGION"}], [:IN_REGION {name: "IN_REGION"}],│
│xes: ["location"],constraints: ["Constraint( id=24, name='airports', t│ [:ON_CONTINENT {name: "ON_CONTINENT"}], [:ON_CONTINENT {name: "ON_CON│
│ype='NODE PROPERTY UNIQUENESS', schema=(:Airport {iata}), ownedIndex=2│TINENT"}], [:ON_CONTINENT {name: "ON_CONTINENT"}], [:ON_CONTINENT {nam│
│3 )"]}), (:Region {name: "Region",indexes: [],constraints: ["Constrain│e: "ON_CONTINENT"}], [:IN_CITY {name: "IN_CITY"}]]                    │
│t( id=20, name='regions', type='NODE PROPERTY UNIQUENESS', schema=(:Re│                                                                      │
│gion {name}), ownedIndex=19 )"]}), (:Country {name: "Country",indexes:│                                                                      │
│ [],constraints: ["Constraint( id=18, name='countries', type='NODE PRO│                                                                      │
│PERTY UNIQUENESS', schema=(:Country {code}), ownedIndex=17 )"]}), (:Ci│                                                                      │
│ty {name: "City",indexes: [],constraints: ["Constraint( id=16, name='c│                                                                      │
│ities', type='NODE PROPERTY UNIQUENESS', schema=(:City {name}), ownedI│                                                                      │
│ndex=15 )"]})]                                                        │                                                                      │
└──────────────────────────────────────────────────────────────────────┴──────────────────────────────────────────────────────────────────────┘
*/

MATCH(n) RETURN COUNT(n);

// Total nb of nodes: 8627

MATCH(n:Country) RETURN COUNT(n);

// 232

MATCH(n:City) RETURN COUNT(n);

// 3359

MATCH(n:Continent) RETURN COUNT(n);

// 6

MATCH(n:Region) RETURN COUNT(n);

// 1527

MATCH(n:Airport) RETURN COUNT(n);

// 3503

MATCH (a:Airport) RETURN a LIMIT 1;

/*
╒══════════════════════════════════════════════════════════════════════╕
│a                                                                     │
╞══════════════════════════════════════════════════════════════════════╡
│(:Airport {descr: "Hartsfield - Jackson Atlanta International Airport"│
│,altitude: 1026,longest: 12390,iata: "ATL",city: "Atlanta",icao: "KATL│
│",location: point({srid:4326, x:-84.4281005859375, y:33.6366996765137}│
│),id: "1",pagerank: 10.389948350302957,runways: 5})                   │
└──────────────────────────────────────────────────────────────────────┘
*/

MATCH (:Airport)-[:ON_CONTINENT]->(c:Continent)
RETURN c.name AS continentName, count(*) AS numAirports ORDER BY numAirports DESC;

/*
╒═════════════╤═══════════╕
│continentName│numAirports│
╞═════════════╪═══════════╡
│"NA"         │989        │
├─────────────┼───────────┤
│"AS"         │971        │
├─────────────┼───────────┤
│"EU"         │605        │
├─────────────┼───────────┤
│"AF"         │321        │
├─────────────┼───────────┤
│"SA"         │313        │
├─────────────┼───────────┤
│"OC"         │304        │
└─────────────┴───────────┘
*/

CALL gds.graph.project(
    'routes',
    'Airport',
    'HAS_ROUTE'
)
YIELD
    graphName, nodeProjection, nodeCount, relationshipProjection, relationshipCount;

/*
╒═════════╤═════════════════════════════════════════════╤═════════╤══════════════════════════════════════════════════════════════════════╤═════════════════╕
│graphName│nodeProjection                               │nodeCount│relationshipProjection                                                │relationshipCount│
╞═════════╪═════════════════════════════════════════════╪═════════╪══════════════════════════════════════════════════════════════════════╪═════════════════╡
│"routes" │{Airport: {label: "Airport", properties: {}}}│3503     │{HAS_ROUTE: {aggregation: "DEFAULT", orientation: "NATURAL", indexInve│46389            │
│         │                                             │         │rse: false, properties: {}, type: "HAS_ROUTE"}}                       │                 │
└─────────┴─────────────────────────────────────────────┴─────────┴──────────────────────────────────────────────────────────────────────┴─────────────────┘
*/

MATCH (:Airport)-[:HAS_ROUTE]->(:Airport)
RETURN COUNT(*) AS routesNumber;

/*
╒════════════╕
│routesNumber│
╞════════════╡
│46389       │
└────────────┘
*/

CALL gds.pageRank.stream('routes')
YIELD nodeId, score
WITH gds.util.asNode(nodeId) AS n, score AS pageRank
RETURN n.iata AS iata, n.descr AS description, pageRank
ORDER BY pageRank DESC, iata ASC;

// Write pageRank property 

CALL gds.pageRank.write('routes',
    {
        writeProperty: 'pageRank'
    }
)
YIELD nodePropertiesWritten, ranIterations;

/*
╒═════════════════════╤═════════════╕
│nodePropertiesWritten│ranIterations│
╞═════════════════════╪═════════════╡
│3503                 │20           │
└─────────────────────┴─────────────┘
*/

MATCH (a:Airport)
RETURN a.iata AS iata, a.descr AS description, a.pageRank AS pageRank
ORDER BY a.pageRank DESC, a.iata ASC;

// Louvain: community detection

CALL gds.louvain.stream('routes')
YIELD nodeId, communityId
WITH gds.util.asNode(nodeId) AS n, communityId
RETURN
	communityId,
    SIZE(COLLECT(n)) AS numberOfAirports,
	COLLECT(DISTINCT n.city) AS cities
ORDER BY numberOfAirports DESC, communityId;

CALL gds.nodeSimilarity.stream('routes')
YIELD node1, node2, similarity
WITH gds.util.asNode(node1) AS n1, gds.util.asNode(node2) AS n2, similarity
RETURN
    n1.iata AS iata,
    n1.city AS city,
    COLLECT({iata:n2.iata, city:n2.city, similarityScore: similarity}) AS similarAirports
ORDER BY city LIMIT 20;

CALL gds.graph.project(
    'routes-weighted',
    'Airport',
    'HAS_ROUTE',
    {
        relationshipProperties: 'distance'
    }
) YIELD
    graphName, nodeProjection, nodeCount, relationshipProjection, relationshipCount

MATCH (source:Airport {iata: 'DEN'}), (target:Airport {iata: 'MLE'})
CALL gds.shortestPath.dijkstra.stream('routes-weighted', {
    sourceNode: source,
    targetNode: target,
    relationshipWeightProperty: 'distance'
})
YIELD index, sourceNode, targetNode, totalCost, nodeIds, costs, path
RETURN
    index,
    gds.util.asNode(sourceNode).iata AS sourceNodeName,
    gds.util.asNode(targetNode).iata AS targetNodeName,
    totalCost,
    [nodeId IN nodeIds | gds.util.asNode(nodeId).iata] AS nodeNames,
    costs,
    nodes(path) as path
ORDER BY index

/*
╒═════╤══════════════╤══════════════╤═════════╤═══════════════════════════════════╤═════════════════════════════════════╤══════════════════════════════════════════════════════════════════════╕
│index│sourceNodeName│targetNodeName│totalCost│nodeNames                          │costs                                │path                                                                  │
╞═════╪══════════════╪══════════════╪═════════╪═══════════════════════════════════╪═════════════════════════════════════╪══════════════════════════════════════════════════════════════════════╡
│0    │"DEN"         │"MLE"         │9704.0   │["DEN", "KEF", "HEL", "VKO", "MLE"]│[0.0, 3556.0, 5074.0, 5629.0, 9704.0]│[(:Airport {altitude: 5433,descr: "Denver International Airport",pageR│
│     │              │              │         │                                   │                                     │ank: 10.997299338126384,longest: 16000,iata: "DEN",city: "Denver",icao│
│     │              │              │         │                                   │                                     │: "KDEN",location: point({srid:4326, x:-104.672996520996, y:39.8616981│
│     │              │              │         │                                   │                                     │506348}),id: "31",pagerank: 10.997299338126387,runways: 6}), (:Airport│
│     │              │              │         │                                   │                                     │ {descr: "Reykjavik, Keflavik International Airport",altitude: 171,pag│
│     │              │              │         │                                   │                                     │eRank: 2.4095328113872316,longest: 10056,iata: "KEF",city: "Reykjavik"│
│     │              │              │         │                                   │                                     │,icao: "BIKF",location: point({srid:4326, x:-22.6056003570557, y:63.98│
│     │              │              │         │                                   │                                     │50006103516}),id: "217",pagerank: 2.4095328113872316,runways: 2}), (:A│
│     │              │              │         │                                   │                                     │irport {altitude: 179,descr: "Helsinki Ventaa",pageRank: 4.18583598716│
│     │              │              │         │                                   │                                     │3839,longest: 11286,iata: "HEL",city: "Helsinki",icao: "EFHK",location│
│     │              │              │         │                                   │                                     │: point({srid:4326, x:24.9633007049561, y:60.3171997070312}),id: "53",│
│     │              │              │         │                                   │                                     │pagerank: 4.185835987163839,runways: 3}), (:Airport {altitude: 685,des│
│     │              │              │         │                                   │                                     │cr: "Vnukovo International Airport",pageRank: 1.9498329248231105,longe│
│     │              │              │         │                                   │                                     │st: 10039,iata: "VKO",city: "Moscow",icao: "UUWW",location: point({sri│
│     │              │              │         │                                   │                                     │d:4326, x:37.2615013123, y:55.5914993286}),id: "318",pagerank: 1.94983│
│     │              │              │         │                                   │                                     │29248231108,runways: 2}), (:Airport {altitude: 6,descr: "Malé Internat│
│     │              │              │         │                                   │                                     │ional Airport",pageRank: 0.7543631236774755,longest: 10499,iata: "MLE"│
│     │              │              │         │                                   │                                     │,city: "Malé",icao: "VRMM",location: point({srid:4326, x:73.5290985107│
│     │              │              │         │                                   │                                     │422, y:4.19183015823364}),id: "523",pagerank: 0.7543631236774754,runwa│
│     │              │              │         │                                   │                                     │ys: 1})]                                                              │
└─────┴──────────────┴──────────────┴─────────┴───────────────────────────────────┴─────────────────────────────────────┴──────────────────────────────────────────────────────────────────────┘
*/