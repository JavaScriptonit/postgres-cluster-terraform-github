# postgres-cluster-terraform-github

```
git add .
git commit -m "add terraform and ansible files"
git push -u origin main
```


## 1. Инициализация Terraform:
cd terraform
terraform init

## 2. Создание серверов:
terraform apply

## 3. Получение IP-адресов серверов:
terraform output server_ips

## 4. Обновление inventory.ini:
- Замените <IP_MASTER>, <IP_REPLICA1>, <IP_REPLICA2> на IP-адреса серверов.

## 5. Запуск Ansible:
cd ../ansible
ansible-playbook -i inventory.ini playbook.yml

