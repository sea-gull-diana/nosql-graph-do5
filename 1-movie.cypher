MATCH(n) DETACH DELETE n;

// Deleted 6 nodes, deleted 5 relationships, completed after 36 ms.

CALL db.schema.visualization;

/*
╒══════════════════════════════════════════════════════════════════════╤══════════════════════════════════════════════════════════════════════╕
│nodes                                                                 │relationships                                                         │
╞══════════════════════════════════════════════════════════════════════╪══════════════════════════════════════════════════════════════════════╡
│[(:Movie {name: "Movie",indexes: [],constraints: []}), (:Person {name:│[[:ACTED_IN {name: "ACTED_IN"}], [:REVIEWED {name: "REVIEWED"}], [:WRO│
│ "Person",indexes: [],constraints: []})]                              │TE {name: "WROTE"}], [:PRODUCED {name: "PRODUCED"}], [:FOLLOWS {name: │
│                                                                      │"FOLLOWS"}], [:DIRECTED {name: "DIRECTED"}]]                          │
└──────────────────────────────────────────────────────────────────────┴──────────────────────────────────────────────────────────────────────┘
*/

MATCH (m:Movie)
RETURN m.title, m.released;

/*
╒═════════════════════════════════╤══════════╕
│m.title                          │m.released│
╞═════════════════════════════════╪══════════╡
│"The Matrix"                     │1999      │
├─────────────────────────────────┼──────────┤
│"The Matrix Reloaded"            │2003      │
├─────────────────────────────────┼──────────┤
│"The Matrix Revolutions"         │2003      │
├─────────────────────────────────┼──────────┤
│"The Devil's Advocate"           │1997      │
├─────────────────────────────────┼──────────┤
│"A Few Good Men"                 │1992      │
├─────────────────────────────────┼──────────┤
│"Top Gun"                        │1986      │
├─────────────────────────────────┼──────────┤
│"Jerry Maguire"                  │2000      │
├─────────────────────────────────┼──────────┤
│"Stand By Me"                    │1986      │
├─────────────────────────────────┼──────────┤
│"As Good as It Gets"             │1997      │
├─────────────────────────────────┼──────────┤
│"What Dreams May Come"           │1998      │
├─────────────────────────────────┼──────────┤
│"Snow Falling on Cedars"         │1999      │
├─────────────────────────────────┼──────────┤
│"You've Got Mail"                │1998      │
├─────────────────────────────────┼──────────┤
│"Sleepless in Seattle"           │1993      │
├─────────────────────────────────┼──────────┤
│"Joe Versus the Volcano"         │1990      │
├─────────────────────────────────┼──────────┤
│"When Harry Met Sally"           │1998      │
├─────────────────────────────────┼──────────┤
│"That Thing You Do"              │1996      │
├─────────────────────────────────┼──────────┤
│"The Replacements"               │2000      │
├─────────────────────────────────┼──────────┤
│"RescueDawn"                     │2006      │
├─────────────────────────────────┼──────────┤
│"The Birdcage"                   │1996      │
├─────────────────────────────────┼──────────┤
│"Unforgiven"                     │1992      │
├─────────────────────────────────┼──────────┤
│"Johnny Mnemonic"                │1995      │
├─────────────────────────────────┼──────────┤
│"Cloud Atlas"                    │2012      │
├─────────────────────────────────┼──────────┤
│"The Da Vinci Code"              │2006      │
├─────────────────────────────────┼──────────┤
│"V for Vendetta"                 │2006      │
├─────────────────────────────────┼──────────┤
│"Speed Racer"                    │2008      │
├─────────────────────────────────┼──────────┤
│"Ninja Assassin"                 │2009      │
├─────────────────────────────────┼──────────┤
│"The Green Mile"                 │1999      │
├─────────────────────────────────┼──────────┤
│"Frost/Nixon"                    │2008      │
├─────────────────────────────────┼──────────┤
│"Hoffa"                          │1992      │
├─────────────────────────────────┼──────────┤
│"Apollo 13"                      │1995      │
├─────────────────────────────────┼──────────┤
│"Twister"                        │1996      │
├─────────────────────────────────┼──────────┤
│"Cast Away"                      │2000      │
├─────────────────────────────────┼──────────┤
│"One Flew Over the Cuckoo's Nest"│1975      │
├─────────────────────────────────┼──────────┤
│"Something's Gotta Give"         │2003      │
├─────────────────────────────────┼──────────┤
│"Bicentennial Man"               │1999      │
├─────────────────────────────────┼──────────┤
│"Charlie Wilson's War"           │2007      │
├─────────────────────────────────┼──────────┤
│"The Polar Express"              │2004      │
├─────────────────────────────────┼──────────┤
│"A League of Their Own"          │1992      │
└─────────────────────────────────┴──────────┘
*/

MATCH(m:Movie)
WHERE m.released > 2005
RETURN m.title, m.released;

/*
╒══════════════════════╤══════════╕
│m.title               │m.released│
╞══════════════════════╪══════════╡
│"RescueDawn"          │2006      │
├──────────────────────┼──────────┤
│"Cloud Atlas"         │2012      │
├──────────────────────┼──────────┤
│"The Da Vinci Code"   │2006      │
├──────────────────────┼──────────┤
│"V for Vendetta"      │2006      │
├──────────────────────┼──────────┤
│"Speed Racer"         │2008      │
├──────────────────────┼──────────┤
│"Ninja Assassin"      │2009      │
├──────────────────────┼──────────┤
│"Frost/Nixon"         │2008      │
├──────────────────────┼──────────┤
│"Charlie Wilson's War"│2007      │
└──────────────────────┴──────────┘
*/

MATCH(m:Movie)
RETURN COUNT(m) AS NumberOfMovies;

/*
╒══════════════╕
│NumberOfMovies│
╞══════════════╡
│38            │
└──────────────┘
*/

MATCH(n:Person)
RETURN n LIMIT 25;

MATCH(n:Person {name: 'Tom Hanks'}) RETURN n;

MATCH(n:Person)
WHERE n.name = 'Taylor Hackford'
RETURN n;

MATCH(m:Movie)
WHERE m.released > 2005 AND m.released < 2010
RETURN m.title, m.released;

/*
╒══════════════════════╤══════════╕
│m.title               │m.released│
╞══════════════════════╪══════════╡
│"RescueDawn"          │2006      │
├──────────────────────┼──────────┤
│"The Da Vinci Code"   │2006      │
├──────────────────────┼──────────┤
│"V for Vendetta"      │2006      │
├──────────────────────┼──────────┤
│"Speed Racer"         │2008      │
├──────────────────────┼──────────┤
│"Ninja Assassin"      │2009      │
├──────────────────────┼──────────┤
│"Frost/Nixon"         │2008      │
├──────────────────────┼──────────┤
│"Charlie Wilson's War"│2007      │
└──────────────────────┴──────────┘
*/

MATCH(m:Movie)
WHERE m.released > 2005 AND m.released < 2010
RETURN COUNT(m);

/*
╒════════╕
│COUNT(m)│
╞════════╡
│7       │
└────────┘
*/

MATCH(m:Movie)<-[r:ACTED_IN]-(a:Person)
WITH m, collect(a) AS Actors
WHERE size(Actors) > 2
RETURN m.title, size(Actors) AS NbOfActors;

/*
╒════════════════════════╤══════════╕
│m.title                 │NbOfActors│
╞════════════════════════╪══════════╡
│"The Matrix"            │5         │
├────────────────────────┼──────────┤
│"The Matrix Reloaded"   │4         │
├────────────────────────┼──────────┤
│"The Matrix Revolutions"│4         │
├────────────────────────┼──────────┤
│"The Devil's Advocate"  │3         │
├────────────────────────┼──────────┤
│"A Few Good Men"        │12        │
├────────────────────────┼──────────┤
│"Top Gun"               │6         │
├────────────────────────┼──────────┤
│"Jerry Maguire"         │9         │
├────────────────────────┼──────────┤
...
*/

MATCH(m:Movie)
RETURN MIN(m.released), MAX(m.released);

/*
╒═══════════════╤═══════════════╕
│MIN(m.released)│MAX(m.released)│
╞═══════════════╪═══════════════╡
│1975           │2012           │
└───────────────┴───────────────┘
*/

// Create all with 1 command
CREATE (:Movie {title: "Genshin Impact", released: "2025"})<-[:ACTED_IN]-(:Person {name: "Dziyana", born: 1999});

// OR

CREATE (m:Movie {title: "Genshin Impact", released: "2025"})
CREATE (p:Person {name: "Dziyana", born: 1999})
CREATE (p)-[:ACTED_IN]->(m);

// Create with separate commands
CREATE (:Movie {title: "Genshin Impact 2", released: "2030"});
CREATE (:Person {name: "Muriel", born: 2001});

MATCH (p:Person {name: "Muriel"}), (m:Movie)
WHERE m.title = "Genshin Impact" OR m.title = "Genshin Impact 2"
CREATE (p)-[:ACTED_IN]->(m);

MATCH (p:Person {name: "Dziyana"}), (m:Movie {title: "Genshin Impact 2"})
CREATE (p)-[:ACTED_IN]->(m);

MATCH (m:Movie{title: "Genshin Impact"})
SET m.genre = "adventure fantasy"
RETURN m;

/*
╒══════════════════════════════════════════════════════════════════════╕
│m                                                                     │
╞══════════════════════════════════════════════════════════════════════╡
│(:Movie {genre: "adventure fantasy",title: "Genshin Impact",released: │
│"2025"})                                                              │
└──────────────────────────────────────────────────────────────────────┘
*/

MATCH(m:Movie)
WHERE m.title = "Genshin Impact" OR m.title = "Genshin Impact 2"
RETURN m;

MATCH(p:Person{name: "Muriel"})
DETACH DELETE p;

MATCH(p:Person{name: "Dziyana"})
DETACH DELETE p;