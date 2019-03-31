docker build -t justinxcguo/multi-client:latest -t justinxcguo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t justinxcguo/multi-server:latest -t justinxcguo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t justinxcguo/worker:latest -t justinxcguo/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push justinxcguo/multi-client:latest
docker push justinxcguo/multi-client:$SHA
docker push justinxcguo/multi-server:latest
docker push justinxcguo/multi-server:$SHA
docker push justinxcguo/multi-worker:latest
docker push justinxcguo/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=justinxcguo/multi-server:$SHA
kubectl set image deployments/client-deployment client=justinxcguo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=justinxcguo/multi-worker:$SHA