docker build -t jayanthanc/multi-client:latest -t jayanthanc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jayanthanc/multi-server:latest -t jayanthanc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jayanthanc/multi-worker:latest -t jayanthanc/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jayanthanc/multi-client:latest
docker push jayanthanc/multi-server:latest
docker push jayanthanc/multi-worker:latest
docker push jayanthanc/multi-client:$SHA
docker push jayanthanc/multi-server:$SHA
docker push jayanthanc/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jayanthanc/multi-server:$SHA
kubectl set image deployments/client-deployment client=jayanthanc/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jayanthanc/multi-worker:$SHA
