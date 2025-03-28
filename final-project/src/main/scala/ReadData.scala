package fr.umontpellier.polytech

import org.apache.spark.sql.{SparkSession, Dataset}

object ReadData {
  def main(args: Array[String]): Unit = {
    
    // Replace with the actual connection URI and credentials
    //val url = "neo4j://localhost:7687"
    //val username = "neo4j"
    //val password = "testtest"
    //val dbname = "neo4j"
    val url = "bolt://13.218.205.43"
    val username = "neo4j"
    val password = "senses-supplies-success"
    val dbname = "neo4j"

    val spark = SparkSession.builder
        .config("neo4j.url", url)
        .config("neo4j.authentication.basic.username", username)
        .config("neo4j.authentication.basic.password", password)
        .config("neo4j.database", dbname)
        .master("local[*]")
        .getOrCreate()
    
    spark.sparkContext.setLogLevel("ERROR")

    val readQuery1 =

      """
      MATCH (:Client:FirstPartyFraudster)-[]-(txn:Transaction)-[]-(c:Client)
      WHERE NOT c:FirstPartyFraudster
      UNWIND labels(txn) AS transactionType
      RETURN DISTINCT transactionType
      """

      val readQuery2 =

      """
      MATCH (c:Client)
      WITH c.firstPartyFraudGroup AS fpGroupID, collect(c.id) AS fGroup
      WITH *, size(fGroup) AS groupSize WHERE groupSize > 9
      WITH collect(fpGroupID) AS fraudRings
      RETURN SIZE(fraudRings) AS fraudRingsGreaterThan9
      """

    val readQuery3 =

      """
      MATCH (c:Client)
      WITH c.firstPartyFraudGroup AS fpGroupID, collect(c.id) AS fGroup
      WITH *, size(fGroup) AS groupSize WHERE groupSize > 10
      WITH collect(fpGroupID) AS fraudRings
      RETURN SIZE(fraudRings) AS fraudRingsGreaterThan10
      """

    val df1 = spark.read
      .format("org.neo4j.spark.DataSource")
      .option("query", readQuery1)
      .load()

    df1.show()

    val df2 = spark.read
      .format("org.neo4j.spark.DataSource")
      .option("query", readQuery2)
      .load()

    df2.show()

    val df3 = spark.read
      .format("org.neo4j.spark.DataSource")
      .option("query", readQuery3)
      .load()

    df3.show()

    spark.stop()
  }
}