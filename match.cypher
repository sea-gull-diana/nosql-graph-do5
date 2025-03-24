MATCH (n:Person)
RETURN n;

/*
╒═══════════════════════════════════╕
│n                                  │
╞═══════════════════════════════════╡
│(:Person {name: "Dziyana",age: 25})│
├───────────────────────────────────┤
│(:Person {name: "J. K. Rowling"})  │
└───────────────────────────────────┘
*/

MATCH (a:Person)-[r:LIKES]->(b:Game)
RETURN a,r,b;

/*
╒═══════════════════════════════════╤════════╤════════════════════════════════╕
│a                                  │r       │b                               │
╞═══════════════════════════════════╪════════╪════════════════════════════════╡
│(:Person {name: "Dziyana",age: 25})│[:LIKES]│(:Game {name: "Genshin Impact"})│
└───────────────────────────────────┴────────┴────────────────────────────────┘
*/

MATCH (a:Person)-[r:LIKES]->(b:Game) RETURN a.name,r.since,b.name;

/*
╒═════════╤═══════╤════════════════╕
│a.name   │r.since│b.name          │
╞═════════╪═══════╪════════════════╡
│"Dziyana"│null   │"Genshin Impact"│
└─────────┴───────┴────────────────┘
*/

MATCH (a:Person)-[r:LIKES]->(b)
RETURN a.name,b.name,labels(b) AS type;

/*
╒═════════╤════════════════╤════════╕
│a.name   │b.name          │type    │
╞═════════╪════════════════╪════════╡
│"Dziyana"│"Harry Potter"  │["Book"]│
├─────────┼────────────────┼────────┤
│"Dziyana"│"Genshin Impact"│["Game"]│
└─────────┴────────────────┴────────┘
*/

MATCH (a:Person)-[r:LIKES]->(b)
WHERE b.name="Harry Potter"
RETURN a.name,b.name,b.year,labels(b) AS type

/*
╒═════════╤══════════════╤══════╤════════╕
│a.name   │b.name        │b.year│type    │
╞═════════╪══════════════╪══════╪════════╡
│"Dziyana"│"Harry Potter"│1997  │["Book"]│
└─────────┴──────────────┴──────┴────────┘
*/