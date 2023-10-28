# headsinjars_infra
headsinjars Infra repository
==============================
Подключение в одну команду через Jump-server (в нашем случае bastion) к внутренним хостам VPC:
ssh -i ~/.ssh/appuser -J appuser@51.250.14.93 appuser@10.128.0.8

==============================
Подключение по имени внутреннего хоста:
В файл ~/.ssh/config добавить строки в начале (выше "Host *"):

Host bastion
    hostname 51.250.14.93
    User appuser
    IdentityFile ~/.ssh/appuser

Host someinternalhost
    Hostname 10.128.0.8
    User appuser
    IdentityFile ~/.ssh/appuser
    ProxyJump bastion

===============================

bastion_IP = 51.250.14.93
someinternalhost_IP = 10.128.0.8


=======
Д.з.№6
1. Созданы bash-скрипты:
   install_ruby.sh - установка Ruby
   install_mongodb.sh - установка БД MongoDB
   deploy.sh - деплой Reddit
2. Доп. задание:
Разработан startup скрипт для создания/запуска инстанса и автоматического деплоя приложения Reddit:

yc compute instance create   --name reddit-app   --hostname reddit-app   --memory=4   --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB   --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4   --metadata serial-port-enable=1   --metadata-from-file user-data=metadata.yaml   --zone ru-central1-a

Скрипт используется пользовательские метаданные user-data, описанные в файле metadata.yaml

testapp_IP = 62.84.125.125
testapp_port = 9292
