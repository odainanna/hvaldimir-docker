# hvaldimir

![hvaldimir.png](hvaldimir.png)

A template docker image that plays nicely with janus.uib.no. 

## Start a container
```bash
make 
```
 
## Start a container and run Jupyter Lab
```bash
make lab
```

## Start a remote container with Jupyter Lab and access it from your local machine
1. In the remote terminal. This will (re-)build and start a container that runs Jupyter Lab.
```bash
make host
```

The output should look something like this.
```
[I 2021-03-18 18:49:28.351 ServerApp] http://ii0230970:8891/lab?token=...
[I 2021-03-18 18:49:28.351 ServerApp]  or http://127.0.0.1:8891/lab?token=...
[I 2021-03-18 18:49:28.351 ServerApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 2021-03-18 18:49:28.354 ServerApp] 
    
    To access the server, open this file in a browser:
        file:///home/username/.local/share/jupyter/runtime/jpserver-1-open.html
    Or copy and paste one of these URLs:
        http://ii0230970:8891/lab?token=...
     or http://127.0.0.1:8891/lab?token=...
```

2. Identify the remote port, here `8891`

3. In your local terminal: do this, but with your own username and the port from step 2
```bash
ssh usr012@janus.uib.no -N -f -L 8891:localhost:8891
```
(If the local port is busy just use another one. In that case you have to change the port in step 4 as well.)

4. In the remote terminal: click one of the urls from step 1. (Something like `http://127.0.0.1:8891/lab?token=...`). 

5. Profit?

## Notes
You might see this message if you don't install nodejs.
`[W 2021-07-27 14:25:42.438 LabApp] Could not determine jupyterlab build status without nodejs`


