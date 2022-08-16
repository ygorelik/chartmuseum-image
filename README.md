## Simple docker image to run ChartMuseum helm chart repository

This docker image is based on Ubuntu Bionic (18.04 LTS).

### Command To build the image 

This is the command to build the chartmuseum image from this repository and create a local docker image named
**chartmuseum-image**:
```commandline
git clone https://github.com/ygorelik/chartmuseum-image
cd chartmuseum-image
docker build --no-cache -t chartmuseum-image .
```

The helm repository configured for local file system storage inside the container in the directory
/chartmuseum/storage.
The container exposes TCP port 8080 for external access.
This port should be explicitly mapped to some external port on the platform when container is created.

The chartmuseum process produces log, which is written to the file /chartmuseum/cm.log. The default level of
logging is WARNING, but it can be changed to DEBUG to see more information (see below).

### Command to run the container

To run a container exposing the services in the default TCP port 8080 to external port 8443:
```commandline
docker run -td --name chartmuseum -p 8443:8080 chartmuseum-image
```

### Debug option for logging

The logging level is defined by the environment variable DEBUG_OPTION. To enable the DEBUG logging modify the 
container run command:
```commandline
docker run -td --name chartmuseum -p 8443:8080 \
       -e DEBUG_OPTION="--debug" \
       chartmuseum-image
```

### Binding storage

The user might decide not to store the chart files and logs inside the container.
In this case the user should provide bindings to the storage directory and the log file:
```commandline
docker run -td --name chartmuseum -p 8443:8080 \
       -v /my-sorage-directory:/chartmuseum/storage \
       -v /my-log-file:/chartmuseum/cm.log \
       chartmuseum-image
```

### References

More info about chartmuseum and various available options to run it see
[documentation](https://github.com/helm/chartmuseum#readme).
