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
Д.з.№4
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

========
Д.з. №5
##
1. Создана новая ветка packer-base (git checkout -b packer-base).
##
2. Установлен Packer версии 1.9.4
##
3. В YC создана сервисная учетая запись для работы с packer'ом.
##
4. В каталоге packer создан файл конфигурации (ubuntu16.json) для сборки базового
   baked-образа.
##
5. Переопределены переменнные в блоке {"variables"} в файле variables.json
##
6. variables.json добавлен в .gitignore для исключения обработки git'ом
##
7. Иные опции билдера опробованы в файле variables.json.examples 
##
8.1* Решена задача с full-образом (immutable.json). "Запечены" зависимости приложения 
   и сам код приложения с автоматическим запуском через systemd unit:
   Файл puma.service расположен в каталоге packer/files. В образ попадает через 
   блок "provisioners" "type": "file" ыо временную папку /tmp/, далее, в секции
   "type": "shell" блока provisioners выполняется перенос файла puma.service
   в каталог /lib/systemd/system

--------
"sudo mv /tmp/puma.service /lib/systemd/system/puma.service",
"sudo systemctl enable puma.service",
"sudo systemctl start puma.service"
--------

8.2* Создан скрипт для запуска ВМ из full-baked-образа (create-reddit-vm.sh)
В результате запуска скрипта будет создана ВМ с запущенным приложением.
Проверка: дождаться раскатки ВМ (порядка 5 минут) и перейти по адресу:
http://Внещний_IP:9292
