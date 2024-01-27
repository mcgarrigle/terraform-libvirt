
Instructions:
```
wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip
unzip terraform_1.6.6_linux_amd64.zip
rm terraform_1.6.6_linux_amd64.zip

./terraform init
./terraform apply -auto-approve

virsh console foo
virsh net-dhcp-leases --network default

./terraform destroy -auto-approve
```
