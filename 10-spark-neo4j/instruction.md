### Instructions to execute the app

- Make sure you have Neo4j running.

- Change the connection data in *ReadData.scala* as necessary:

```
    val url = "neo4j://localhost:7687"
    val username = "neo4j"
    val password = "testtest"
    val dbname = "neo4j"
```

- Open VSCode with *10-spark-neo4j* as root folder.

- Open Metals extension on the left and click "Import build".

- Open ReadData.scala and click F5.