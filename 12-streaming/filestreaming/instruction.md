### Prepare app jar

The app will read files from the "spark-stream" bucket and write data to *output* folder locally. You can modify this line in the code to output data to a minio bucket instead of a local folder:

```
    .option("path", "output/") 
```

Go to *12-streaming* and execute `sbt package`. You can also use ready-made jar in the *jars* folder.

Move the jar to a bucket named "spark" on your minio.

### Launch SparkApplication

Modify the sparkConf in the *spark-stream-app.yaml* as needed:

```
    "spark.hadoop.fs.s3a.endpoint": "<minio url>"
    "spark.hadoop.fs.s3a.access.key": "<minio acces key>"
    "spark.hadoop.fs.s3a.secret.key": "<minio secret key>"
```

Apply the yaml:

```
kubectl apply -f spark-stream-app.yaml
```

### Add files

Make sure you have a bucket named "spark-stream" on your minio. Upload a new csv file to this bucket and see it appear in the pod log:

```
kubectl logs spark-filestream-driver
```