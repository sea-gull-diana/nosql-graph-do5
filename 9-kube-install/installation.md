### Installing MinIO Operator:

```
kubectl apply -k "github.com/minio/operator?ref=v7.0.0"
```

### Deploy MinIO

Get sample file for minio tenant (or just use the one in this folder):
```
kubectl kustomize https://github.com/minio/operator/examples/kustomization/base/ > tenant-base.yaml
```

I modified `servers` count to 1 and set storage class name to "local-path" (the default storage class in k3d). I have also desactivated tls by setting `requestAutoCert` to false.

```
kubectl apply -f tenant-base.yaml
```

To access the MinIO UI:
```
kubectl port-forward svc/myminio-console 9090 -n minio-tenant
```

Connect to minio on https://localhost:9090

Default login is "minio" and default password is "minio123" (can be changed in tenant-base.yaml).

Create a bucket (named "spark") and upload the jar file for spark application to the bucket. As well as the csv files.

To build a jar file, go to *8-spark* directory and execute `sbt package`. The jar file can be found in *target/scala-2.12* folder afterwards. You can also find a ready-made jar file in the *9-kube-install/jars* folder.

### Installing Spark Operator

```
helm repo add spark-operator https://kubeflow.github.io/spark-operator
helm repo update

# Install the operator into the spark-operator namespace and wait for deployments to be ready
helm install spark-operator spark-operator/spark-operator \
    --namespace spark-operator --create-namespace --wait
```

### Running Spark applications

Build a custom spark image that contains jars for s3a connection:

```
docker build -t my-spark-with-s3a:s3 .
```

Import image to my local cluster to avoid pushing it to a remote registry:

```
k3d image import my-spark-with-s3a:s3 -c nosql
```

Set minio credentials for spark apps (there are 3 yaml manifests in the *sparkapps* folder), change these lines:

```
    "spark.hadoop.fs.s3a.access.key": "<your access key>"
    "spark.hadoop.fs.s3a.secret.key": "<your secret key>"
```

To get the access key and secret key, go to *Administrator -> Identity -> Users* on MinIO UI and click on your user. Add a "readwrite" policy to the user and create an access key in *Service Accounts* tab.

Execute the apps (there are 3 yaml manifests in the *sparkapps* folder):

```
kubectl apply -f sparkapps/
```