import org.apache.spark._
import org.apache.spark.streaming._
import org.apache.spark.streaming.StreamingContext._ // not necessary since Spark 1.3

object StreamingApp {
  def main(args: Array[String]): Unit = {
    // Create a local StreamingContext with two working thread and batch interval of 1 second.
    // The master requires 2 cores to prevent a starvation scenario.

    val conf = new SparkConf().setMaster("local[*]").setAppName("StreamingApp")
    val ssc = new StreamingContext(conf, Seconds(1))

    // Create a file Stream that will connect to minio and read files
    val files = ssc.textFileStream("s3a://spark-stream/")

    files.foreachRDD { rdd =>
      rdd.foreach { line =>
        println(line)
      }
    }

    ssc.start()             // Start the computation
    ssc.awaitTermination()  // Wait for the computation to terminate
  }
}