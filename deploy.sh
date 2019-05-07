docker build -t brhamill/multi-client:latest -t brhamill/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t brhamill/multi-server:latest -t brhamill/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t brhamill/multi-worker:latest -t brhamill/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push brhamill/multi-client:latest
docker push brhamill/multi-server:latest
docker push brhamill/multi-worker:latest

docker push brhamill/multi-client:$SHA
docker push brhamill/multi-server:$SHA
docker push brhamill/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=brhamill/multi-client:$SHA
kubectl set image deployments/server-deployment server=brhamill/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=brhamill/multi-worker:$SHA
