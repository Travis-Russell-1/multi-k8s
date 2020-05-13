docker build -t deedsgrom48/multi-client:latest -t deedsgrom48/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t deedsgrom48/multi-server:latest -t deedsgrom48/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t deedsgrom48/multi-worker:latest -t deedsgrom48/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push deedsgrom48/multi-client:latest
docker push deedsgrom48/multi-server:latest
docker push deedsgrom48/multi-worker:latest

docker push deedsgrom48/multi-client:$SHA
docker push deedsgrom48/multi-server:$SHA
docker push deedsgrom48/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=deedsgrom48/multi-server:$SHA
kubectl set image deployments/client-deployment client=deedsgrom48/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=deedsgrom48/multi-worker:$SHA