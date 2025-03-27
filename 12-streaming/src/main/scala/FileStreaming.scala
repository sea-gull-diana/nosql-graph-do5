import org.apache.spark._
import org.apache.spark.sql.{SparkSession, Dataset}
import org.apache.spark.streaming._
import org.apache.spark.sql.types._

object FileStreaming extends App {

  val spark = SparkSession.builder()
    .appName("FileStreamingExample")
    .master("local[*]")
    .getOrCreate()

  spark.sparkContext.setLogLevel("ERROR")

  val schema = new StructType()
    .add("id", StringType)
    .add("treatment", StringType)
    .add("location", StringType)


  val streamingDF = spark.readStream
    .option("header", "false")
    .schema(schema)
    .csv("s3a://spark-stream/")

  val consoleQuery = streamingDF.writeStream
    .format("console")
    .outputMode("append") // each new file’s rows will appear in the console
    .start()

  val csvQuery = streamingDF.writeStream
    .format("csv")
    .outputMode("append")
    .option("path", "output/") // <--- Where final CSV files will be saved
    .option("checkpointLocation", "chkpoint/") // <--- Directory for checkpointing
    .start()

  spark.streams.awaitAnyTermination()
}