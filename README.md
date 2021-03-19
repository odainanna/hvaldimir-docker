# hvaldimir-docker

A docker image for running Jupyter Lab remotely on janus@uib.no

## Alt 1: Build and start the base image (no Jupyter)
```bash
make 
```

## Alt 2: Use Jupyter Lab remotely
1. In the remote terminal
```bash
make lab
```
This command re-builds the images and starts a container with Jupyter Lab. The output should look something like this.
```
[I 2021-03-18 18:49:28.351 ServerApp] http://ii0230970:8891/lab?token=60877e5eaeb55cc64305b0ea10a09e1e60f4985eebda2a0f
[I 2021-03-18 18:49:28.351 ServerApp]  or http://127.0.0.1:8891/lab?token=60877e5eaeb55cc64305b0ea10a09e1e60f4985eebda2a0f
[I 2021-03-18 18:49:28.351 ServerApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 2021-03-18 18:49:28.354 ServerApp] 
    
    To access the server, open this file in a browser:
        file:///home/username/.local/share/jupyter/runtime/jpserver-1-open.html
    Or copy and paste one of these URLs:
        http://ii0230970:8891/lab?token=60877e5eaeb55cc64305b0ea10a09e1e60f4985eebda2a0f
     or http://127.0.0.1:8891/lab?token=60877e5eaeb55cc64305b0ea10a09e1e60f4985eebda2a0f
```

2. Identify the port, here `8891`

3. In your local terminal
````bash
ssh username@janus.uib.no -N -f -L 8891:localhost:8891
````

4. Click one of the URLs

5. Profit?

![hvaldimir.png](hvaldimir.png)