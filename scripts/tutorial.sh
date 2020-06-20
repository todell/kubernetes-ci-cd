# spin up a proxy for the docker registry push command
docker stop socat-registry; docker rm socat-registry; docker run -d -e "REG_IP=`minikube ip`" -e "REG_PORT=30400" --name socat-registry -p 30400:5000 socat-registry
# push the long time support image to the local repository
docker push 127.0.0.1:30400/jenkins:lts

# open registry ui
minikube service registry-ui

#deploy jenkins to kubernetes
kubectl apply -f manifests/jenkins.yaml; kubectl rollout status deployment/jenkins

# get the admin password
kubectl exec -it `kubectl get pods --selector=app=jenkins --output=jsonpath={.items..metadata.name}` cat /var/jenkins_home/secrets/initialAdminPassword


# get the jenknis ui
kubectl service jenkins

