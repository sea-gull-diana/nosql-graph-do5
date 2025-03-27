### Install Kafka operator

```
helm repo add strimzi https://strimzi.io/charts/
	
helm install my-strimzi-kafka-operator strimzi/strimzi-kafka-operator --version 0.45.0
```

### Deploy Kafka

```
kubectl apply -f kafka.yaml
```

### Create topic and launch consumer

```
kubectl --namespace default exec -it my-cluster-kafka-0 -c kafka -- bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic  inputStream.test.newApplication
```

**To list topics:**

```
kubectl --namespace default exec -it my-cluster-kafka-0 -c kafka -- bin/kafka-topics.sh --bootstrap-server my-cluster-kafka-bootstrap:9092 --list
```

### Launch producer

```
kubectl --namespace default exec -it my-cluster-kafka-0 -c kafka -- bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic  inputStream.test.newApplication
```

### Prepare spark image

Build image that contains jars for kafka and minio connection (make sure you're in the *12-streaming/kafka/* folder):

```
docker build -t spark-s3a-kafka:v1 .
```

Import image to k3d cluster (my cluster is named "nosql"):

```
k3d image import spark-s3a-kafka:v1 -c nosql
```

### Prepare jar file

Make sure you have executed `sbt package` in *12-streaming* folder and moved the created jar file to a bucket named "spark" on your minio. You can also use a premade jar in the *jars* folder.

### Launch SparkApplication

Modify the sparkConf in the *kafka-stream-app.yaml* as needed:

```
    "spark.hadoop.fs.s3a.endpoint": "<minio url>"
    "spark.hadoop.fs.s3a.access.key": "<minio acces key>"
    "spark.hadoop.fs.s3a.secret.key": "<minio secret key>"
```

Apply yaml:

```
kubectl apply -f kafka/kafka-stream-app.yaml
```

Type something in the producer window and view logs:

```
kubectl logs spark-kafka-driver
```