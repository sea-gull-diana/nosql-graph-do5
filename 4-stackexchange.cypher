CALL apoc.load.json("file:///stackexchange-questions.json") YIELD value
UNWIND value.items AS item
MERGE (q:Question {title: item.title, content: item.body_markdown})
MERGE (owner:User {user_id: item.owner.user_id, name: item.owner.display_name})
MERGE (owner)-[:ASKED]->(q)

WITH q, item.tags AS tags, item.answers AS answers
UNWIND tags AS tagName
MERGE (t:Tag {name: tagName})
MERGE (q)-[:TAGGED]->(t)

WITH q, answers
UNWIND answers AS answer
MERGE (a:Answer { score: answer.score, title: answer.title, content: answer.body_markdown})
MERGE (a)-[:ANSWERS]->(q)

WITH a, answer
MERGE (answerOwner:User {user_id: answer.owner.user_id, name: answer.owner.display_name})
MERGE (answerOwner)-[:PROVIDED]->(a);
