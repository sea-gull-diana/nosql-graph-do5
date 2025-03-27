name := "Spark Stream App"

version := "1.0"

scalaVersion := "2.12.18"

libraryDependencies += "org.apache.spark" % "spark-streaming_2.12" % "3.5.5" % "provided"
libraryDependencies += "org.apache.spark" %% "spark-sql" % "3.5.5"
libraryDependencies ++= Seq(
  "org.apache.spark" %% "spark-sql-kafka-0-10" % "3.5.5",
  "org.apache.kafka" % "kafka-clients" % "3.5.1"
)