This repo contains Terraform code to create AKS and Specification file to deploy example application AKS.

#AKS Monitroing Accessibility

az login --use-device-code
az aks get-credentials --resource-group "" --name ""
kubectl --namespace monitoring get pods -l "release=prometheus"
kubectl port-forward --namespace monitoring svc/prometheus-kube-prometheus-prometheus 9090
kubectl port-forward --namespace monitoring svc/prometheus-grafana 8080:80
grafan user name : "admin" , password : "prom-operator"
