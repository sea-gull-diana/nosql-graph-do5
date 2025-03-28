CALL db.schema.visualization;

/*
╒══════════════════════════════════════════════════════════════════════╤══════════════════════════════════════════════════════════════════════╕
│nodes                                                                 │relationships                                                         │
╞══════════════════════════════════════════════════════════════════════╪══════════════════════════════════════════════════════════════════════╡
│[(:Debit {name: "Debit",indexes: ["globalStep"],constraints: ["Constra│[[:HAS_SSN {name: "HAS_SSN"}], [:HAS_SSN {name: "HAS_SSN"}], [:LAST_TX│
│int( id=31, name='constraint_182b7cf9', type='NODE PROPERTY UNIQUENESS│ {name: "LAST_TX"}], [:LAST_TX {name: "LAST_TX"}], [:LAST_TX {name: "L│
│', schema=(:Debit {id}), ownedIndex=10 )"]}), (:Bank {name: "Bank",ind│AST_TX"}], [:LAST_TX {name: "LAST_TX"}], [:LAST_TX {name: "LAST_TX"}],│
│exes: [],constraints: ["Constraint( id=33, name='constraint_329984c3',│ [:LAST_TX {name: "LAST_TX"}], [:LAST_TX {name: "LAST_TX"}], [:LAST_TX│
│ type='NODE PROPERTY UNIQUENESS', schema=(:Bank {id}), ownedIndex=9 )"│ {name: "LAST_TX"}], [:LAST_TX {name: "LAST_TX"}], [:LAST_TX {name: "L│
│]}), (:Email {name: "Email",indexes: [],constraints: ["Constraint( id=│AST_TX"}], [:LAST_TX {name: "LAST_TX"}], [:LAST_TX {name: "LAST_TX"}],│
│42, name='constraint_2b944eb8', type='NODE PROPERTY UNIQUENESS', schem│ [:PERFORMED {name: "PERFORMED"}], [:PERFORMED {name: "PERFORMED"}], [│
│a=(:Email {email}), ownedIndex=7 )"]}), (:Mule {name: "Mule",indexes: │:PERFORMED {name: "PERFORMED"}], [:PERFORMED {name: "PERFORMED"}], [:P│
│[],constraints: ["Constraint( id=38, name='constraint_5d4fabb7', type=│ERFORMED {name: "PERFORMED"}], [:PERFORMED {name: "PERFORMED"}], [:PER│
│'NODE PROPERTY UNIQUENESS', schema=(:Mule {id}), ownedIndex=17 )"]}), │FORMED {name: "PERFORMED"}], [:PERFORMED {name: "PERFORMED"}], [:PERFO│
│(:SSN {name: "SSN",indexes: [],constraints: ["Constraint( id=41, name=│RMED {name: "PERFORMED"}], [:PERFORMED {name: "PERFORMED"}], [:PERFORM│
│'constraint_2e3b4d82', type='NODE PROPERTY UNIQUENESS', schema=(:SSN {│ED {name: "PERFORMED"}], [:PERFORMED {name: "PERFORMED"}], [:NEXT {nam│
│ssn}), ownedIndex=12 )"]}), (:Payment {name: "Payment",indexes: ["glob│e: "NEXT"}], [:NEXT {name: "NEXT"}], [:NEXT {name: "NEXT"}], [:NEXT {n│
│alStep"],constraints: ["Constraint( id=30, name='constraint_80d41635',│ame: "NEXT"}], [:NEXT {name: "NEXT"}], [:NEXT {name: "NEXT"}], [:NEXT │
│ type='NODE PROPERTY UNIQUENESS', schema=(:Payment {id}), ownedIndex=1│{name: "NEXT"}], [:NEXT {name: "NEXT"}], [:NEXT {name: "NEXT"}], [:NEX│
│4 )"]}), (:Merchant {name: "Merchant",indexes: [],constraints: ["Const│T {name: "NEXT"}], [:NEXT {name: "NEXT"}], [:NEXT {name: "NEXT"}], [:N│
│raint( id=40, name='constraint_ee8a7860', type='NODE PROPERTY UNIQUENE│EXT {name: "NEXT"}], [:NEXT {name: "NEXT"}], [:NEXT {name: "NEXT"}], [│
│SS', schema=(:Merchant {id}), ownedIndex=13 )"]}), (:Transaction {name│:NEXT {name: "NEXT"}], [:NEXT {name: "NEXT"}], [:NEXT {name: "NEXT"}],│
│: "Transaction",indexes: ["globalStep"],constraints: ["Constraint( id=│ [:NEXT {name: "NEXT"}], [:NEXT {name: "NEXT"}], [:NEXT {name: "NEXT"}│
│45, name='constraint_18f03457', type='NODE PROPERTY UNIQUENESS', schem│], [:NEXT {name: "NEXT"}], [:NEXT {name: "NEXT"}], [:NEXT {name: "NEXT│
│a=(:Transaction {id}), ownedIndex=2 )"]}), (:Phone {name: "Phone",inde│"}], [:NEXT {name: "NEXT"}], [:NEXT {name: "NEXT"}], [:NEXT {name: "NE│
│xes: [],constraints: ["Constraint( id=44, name='constraint_c1956d6c', │XT"}], [:NEXT {name: "NEXT"}], [:NEXT {name: "NEXT"}], [:NEXT {name: "│
│type='NODE PROPERTY UNIQUENESS', schema=(:Phone {phoneNumber}), ownedI│NEXT"}], [:NEXT {name: "NEXT"}], [:NEXT {name: "NEXT"}], [:NEXT {name:│
│ndex=16 )"]}), (:CashOut {name: "CashOut",indexes: ["globalStep"],cons│ "NEXT"}], [:NEXT {name: "NEXT"}], [:NEXT {name: "NEXT"}], [:NEXT {nam│
│traints: ["Constraint( id=35, name='constraint_b8ae65f9', type='NODE P│e: "NEXT"}], [:HAS_EMAIL {name: "HAS_EMAIL"}], [:HAS_EMAIL {name: "HAS│
│ROPERTY UNIQUENESS', schema=(:CashOut {id}), ownedIndex=6 )"]}), (:Tra│_EMAIL"}], [:TO {name: "TO"}], [:TO {name: "TO"}], [:TO {name: "TO"}],│
│nsfer {name: "Transfer",indexes: ["globalStep"],constraints: ["Constra│ [:TO {name: "TO"}], [:TO {name: "TO"}], [:TO {name: "TO"}], [:TO {nam│
│int( id=47, name='constraint_ac5c1389', type='NODE PROPERTY UNIQUENESS│e: "TO"}], [:TO {name: "TO"}], [:TO {name: "TO"}], [:TO {name: "TO"}],│
│', schema=(:Transfer {id}), ownedIndex=19 )"]}), (:CashIn {name: "Cash│ [:TO {name: "TO"}], [:TO {name: "TO"}], [:TO {name: "TO"}], [:TO {nam│
│In",indexes: ["globalStep"],constraints: ["Constraint( id=37, name='co│e: "TO"}], [:TO {name: "TO"}], [:TO {name: "TO"}], [:TO {name: "TO"}],│
│nstraint_3aa7172a', type='NODE PROPERTY UNIQUENESS', schema=(:CashIn {│ [:TO {name: "TO"}], [:TO {name: "TO"}], [:TO {name: "TO"}], [:TO {nam│
│id}), ownedIndex=20 )"]}), (:Client {name: "Client",indexes: [],constr│e: "TO"}], [:TO {name: "TO"}], [:TO {name: "TO"}], [:TO {name: "TO"}],│
│aints: ["Constraint( id=34, name='constraint_fcf6553a', type='NODE PRO│ [:FIRST_TX {name: "FIRST_TX"}], [:FIRST_TX {name: "FIRST_TX"}], [:FIR│
│PERTY UNIQUENESS', schema=(:Client {id}), ownedIndex=5 )"]})]         │ST_TX {name: "FIRST_TX"}], [:FIRST_TX {name: "FIRST_TX"}], [:FIRST_TX │
│                                                                      │{name: "FIRST_TX"}], [:FIRST_TX {name: "FIRST_TX"}], [:FIRST_TX {name:│
│                                                                      │ "FIRST_TX"}], [:FIRST_TX {name: "FIRST_TX"}], [:FIRST_TX {name: "FIRS│
│                                                                      │T_TX"}], [:FIRST_TX {name: "FIRST_TX"}], [:FIRST_TX {name: "FIRST_TX"}│
│                                                                      │], [:FIRST_TX {name: "FIRST_TX"}], [:HAS_PHONE {name: "HAS_PHONE"}], [│
│                                                                      │:HAS_PHONE {name: "HAS_PHONE"}]]                                      │
└──────────────────────────────────────────────────────────────────────┴──────────────────────────────────────────────────────────────────────┘
*/

MATCH(n) RETURN COUNT(n);

/*
╒════════╕
│COUNT(n)│
╞════════╡
│332973  │
└────────┘
*/

MATCH ()-[r]->() RETURN COUNT(r);

/*
╒════════╕
│COUNT(r)│
╞════════╡
│980098  │
└────────┘
*/

CALL db.labels() YIELD label
CALL apoc.cypher.run(
  'MATCH (n:`' + label + '`) RETURN count(n) AS count', 
  {}
) YIELD value
RETURN label, value.count AS count
ORDER BY count DESC;

/*
╒═════════════╤══════╕
│label        │count │
╞═════════════╪══════╡
│"Transaction"│323489│
├─────────────┼──────┤
│"CashIn"     │149037│
├─────────────┼──────┤
│"CashOut"    │76023 │
├─────────────┼──────┤
│"Payment"    │74577 │
├─────────────┼──────┤
│"Transfer"   │19460 │
├─────────────┼──────┤
│"Debit"      │4392  │
├─────────────┼──────┤
│"Client"     │2433  │
├─────────────┼──────┤
│"SSN"        │2238  │
├─────────────┼──────┤
│"Phone"      │2234  │
├─────────────┼──────┤
│"Email"      │2229  │
├─────────────┼──────┤
│"Mule"       │433   │
├─────────────┼──────┤
│"Merchant"   │347   │
├─────────────┼──────┤
│"Bank"       │3     │
└─────────────┴──────┘
*/

CALL db.relationshipTypes() YIELD relationshipType
CALL apoc.cypher.run(
  'MATCH ()-[r:`' + relationshipType + '`]->() RETURN count(r) AS count',
  {}
) YIELD value
RETURN relationshipType AS type, value.count AS count
ORDER BY count DESC;

/*
╒═══════════╤══════╕
│type       │count │
╞═══════════╪══════╡
│"PERFORMED"│323489│
├───────────┼──────┤
│"TO"       │323489│
├───────────┼──────┤
│"NEXT"     │321157│
├───────────┼──────┤
│"HAS_SSN"  │2433  │
├───────────┼──────┤
│"HAS_EMAIL"│2433  │
├───────────┼──────┤
│"HAS_PHONE"│2433  │
├───────────┼──────┤
│"FIRST_TX" │2332  │
├───────────┼──────┤
│"LAST_TX"  │2332  │
└───────────┴──────┘
*/

MATCH (:Client:FirstPartyFraudster)-[]-(txn:Transaction)-[]-(c:Client)
WHERE NOT c:FirstPartyFraudster
UNWIND labels(txn) AS transactionType
RETURN DISTINCT transactionType;

/*
╒═══════════════╕
│transactionType│
╞═══════════════╡
│"Transfer"     │
├───────────────┤
│"Transaction"  │
└───────────────┘
*/

MATCH (c:Client)
WITH c.firstPartyFraudGroup AS fpGroupID, collect(c.id) AS fGroup
WITH *, size(fGroup) AS groupSize WHERE groupSize > 9
WITH collect(fpGroupID) AS fraudRings
RETURN SIZE(fraudRings);

// OR

MATCH (c:Client)
WITH c.firstPartyFraudGroup AS fpGroupID, collect(c.id) AS fGroup
WITH fpGroupID, size(fGroup) AS groupSize
WHERE groupSize > 9
RETURN count(fpGroupID);

/*
╒════════════════╕
│SIZE(fraudRings)│
╞════════════════╡
│5               │
└────────────────┘
*/

MATCH (c:Client)
WITH c.firstPartyFraudGroup AS fpGroupID, collect(c.id) AS fGroup
WITH *, size(fGroup) AS groupSize WHERE groupSize > 10
WITH collect(fpGroupID) AS fraudRings
RETURN SIZE(fraudRings);

// OR

MATCH (c:Client)
WITH c.firstPartyFraudGroup AS fpGroupID, collect(c.id) AS fGroup
WITH fpGroupID, size(fGroup) AS groupSize
WHERE groupSize > 10
RETURN count(fpGroupID);

/*
╒════════════════╕
│SIZE(fraudRings)│
╞════════════════╡
│3               │
└────────────────┘
*/