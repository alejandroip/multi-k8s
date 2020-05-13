docker build -t alejandroip/multi-client:latest -t alejandroip/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alejandroip/multi-server:latest -t alejandroip/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alejandroip/multi-worker:latest -t alejandroip/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alejandroip/multi-client:latest
docker push alejandroip/multi-server:latest
docker push alejandroip/multi-worker:latest

docker push alejandroip/multi-client:$SHA
docker push alejandroip/multi-server:$SHA
docker push alejandroip/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alejandroip/multi-server:$SHA
kubectl set image deployments/client-deployment client=alejandroip/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alejandroip/multi-worker:$SHA

