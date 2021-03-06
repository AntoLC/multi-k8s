docker build -t antoto/multi-client:latest -t antoto/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t antoto/multi-server:latest -t antoto/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t antoto/multi-worker:latest -t antoto/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push antoto/multi-client:latest
docker push antoto/multi-server:latest
docker push antoto/multi-worker:latest

docker push antoto/multi-client:$SHA
docker push antoto/multi-server:$SHA
docker push antoto/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=antoto/multi-server:$SHA
kubectl set image deployments/client-deployment client=antoto/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=antoto/multi-worker:$SHA