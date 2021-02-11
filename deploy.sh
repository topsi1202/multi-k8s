docker build -t maorizio1202/multi-client:latest -t maorizio1202/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t maorizio1202/multi-server:latest -t maorizio1202/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t maorizio1202/multi-worker:latest -t maorizio1202/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push maorizio1202/multi-client:latest
docker push maorizio1202/multi-server:latest
docker push maorizio1202/multi-worker:latest

docker push maorizio1202/multi-client:$SHA
docker push maorizio1202/multi-server:$SHA
docker push maorizio1202/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=maorizio1202/multi-server:$SHA
kubectl set image deployments/client-deployment client=maorizio1202/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=maorizio1202/multi-worker:$SHA
