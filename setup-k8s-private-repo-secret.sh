export AZURE_CONTAINER_REGISTRY_NAME=branch
export DOCKER_REGISTRY_SERVER=$AZURE_CONTAINER_REGISTRY_NAME.azurecr.io
export DOCKER_EMAIL=brandon.chow@slalom.com
export DOCKER_SECRET_NAME=regsecret

DOCKER_USERNAME=$(az acr credential show -n branch --query username --output tsv)
DOCKER_PASSWORD=$(az acr credential show -n branch --query passwords[0].value --output tsv)

docker login $DOCKER_REGISTRY_SERVER -u $DOCKER_USERNAME -p $DOCKER_PASSWORD

: $(kubectl delete secret $DOCKER_SECRET_NAME)
kubectl create secret docker-registry $DOCKER_SECRET_NAME \
  --docker-server=$DOCKER_REGISTRY_SERVER \
  --docker-username=$DOCKER_USERNAME \
  --docker-password=$DOCKER_PASSWORD \
  --docker-email=$DOCKER_EMAIL