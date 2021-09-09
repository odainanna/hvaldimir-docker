# hvaldimir

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
1. In the remote terminal. This will (re-)build and start a container with Jupyter Lab.
```bash
make lab
```

The output should look something like this.
```
[I 2021-03-18 18:49:28.351 ServerApp] http://iixxxxxx:8850/lab?token=...
[I 2021-03-18 18:49:28.351 ServerApp]  or http://127.0.0.1:8850/lab?token=...
[I 2021-03-18 18:49:28.351 ServerApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 2021-03-18 18:49:28.354 ServerApp] 
    
    To access the server, open this file in a browser:
        file:///home/username/.local/share/jupyter/runtime/jpserver-1-open.html
    Or copy and paste one of these URLs:
        http://iixxxxxxx:8850/lab?token=...
     or http://127.0.0.1:8850/lab?token=...
```

2. Identify the remote port, here `8850`

3. In your local terminal: do this, but with your own username and the port from step 2
```bash
ssh kuv009@janus.uib.no -NfL 8850:localhost:8850
```
(The ports local and remote ports don't have to match of course. If one port is busy just use another one and change the url below to match.)

4. In the remote terminal: click one of the urls from step 1. (Something like `http://127.0.0.1:8850/lab?token=...`). 

5. Profit?

## Notes
You might see this message if you don't install `nodejs`. `nodejs` is  not strictly necessary and takes a while to build.
`[W 2021-07-27 14:25:42.438 LabApp] Could not determine jupyterlab build status without nodejs`
