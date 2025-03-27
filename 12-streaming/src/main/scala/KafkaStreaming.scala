import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.functions._

object KafkaStreamReader {
  def main(args: Array[String]): Unit = {

    val spark = SparkSession.builder
      .appName("KafkaStreamReader")
      .master("local[*]")
      .getOrCreate()

    // Read stream from Kafka
    val kafkaDf = spark.readStream
      .format("kafka")
      .option("kafka.bootstrap.servers", "my-cluster-kafka-bootstrap.default.svc:9092")
      .option("subscribe", "inputStream.test.newApplication")
      .option("startingOffsets", "earliest")
      .load()
    
    import spark.implicits._

    // Convert binary Kafka message to string
    val messages = kafkaDf.selectExpr("CAST(value AS STRING)").as[String]

    // Print to console
    val query = messages.writeStream
      .outputMode("append")
      .format("console")
      .option("truncate", false)
      .start()

    query.awaitTermination()
  }
}