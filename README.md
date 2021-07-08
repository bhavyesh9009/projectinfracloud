1) Run the container image infracloudio/csvserver:latest in background and check if it's running.

$ docker container run -d infracloudio/csvserver:latest

2) It failed due to CMD is set to "/csvserver/csvserver" which needs another arugument which is "inputdata".

3) Script which is created is as below

i=0
: ${limit:=9}
for i in `seq $i $limit`
do
        echo $i, $RANDOM
done >./inputFile

--> In this script by default it will give 0 to 9 random numbers.
--> if need to generate 100000 numbers then I will use $ limit=100000 ./gencsv.sh
--> lastly output will be stored in "inputFile"

4) Run the container again in the background with file generated in (3) available inside the container (remember the reason you found in (2)).

$ docker container run --name c1 -d infracloudio/csvserver:latest
$ docker container cp ./inputFile c1:/csvserver/inputdata
$ docker container start c1

5) Get shell access to the container and find the port on which the application is listening. Once done, stop / delete the running container.

$ docker container exec -it c1 /bin/bash
	$ netstat -tulnap

	tcp6       0      0 :::9300                 :::*                    LISTEN      1/csvserver
$ docker container rm -f c1

6) 

$ docker container run --name c1 -p 9393:9300 --env CSVSERVER_BORDER=Orange -d infracloudio/csvserver:latest
$ docker container cp ./inputFile c1:/csvserver/inputdata
$ docker container start c1
$ docker container ls -a

