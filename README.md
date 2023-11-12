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
http://Внешний_IP:9292

=====
Д.з. №6
Создан каталог terraform и ветка terraform-1.
файл main.tf - основной файл с настройкой провайдера, описанием ресурсов инстанса(ов)
файл variables.tf - объявление переменных terraform.
файл output-vars.tf - объявление выходных данных.
файл terraform.tfvars - инициализация переменных.
файл lb.tf - конфигурация балансировщика нагрузки, целевой группы и обработчика.
для создания нескольких однотипных ресурсов (инстансов) используется мета-аргумент count. Это позволяет сократить объемы кода.
Блок connections использована конструкция host  = self.network_interface.0.nat_ip_address. В противном случае выходила ошибка: Error: Cycle


# Выполнено ДЗ №7

 - [+] Основное ДЗ
 - [+] Задание со *
 - [-] Задание со **

## В процессе сделано:
 - Создана новая ветка terraform-2
 - Определены неявные зависимости ресурсов в порядке примененения (создания)
 - Протестирована работа с мета-аргументом depends_on (явное определение зависимостей)
 - Изменена структура проекта: app и db пересобраны packer'ом в качестве отдельных образов ВМ
 - Создание ресурсов вынесено в отдельные файлы из maim.tf (app.tf, db.tf, vpc.tf)
 - Применен принцип организации кода с модулями: app и db создаются, вызывая соответствующие модули. Это позволяет сократить объемы кода и создавать большое количество повторяющихся инстансов с небольшими изменениями
 - Принцип модульной структуры применен для создания инстансов для prod и stage веток проекта.
 - Реализован удаленный backend для хранения и совместной работы с .state файлом. Состояние инфраструктуры хранится на s3 bucket'e.
 - Реализована совместная работа через state locking (блокировку состояний) для предотвращения одновременного изменения ресурсов разными членами команды. В YC создана таблица Yandex Managed Service for YBD     (аналог DynamoDB в AWS).

## Как запустить проект:
 - Перейти в каталог prod (stage)
   cd ./prod (или cd ./stage)
 - предварительно загрузить в переменные окружения статический ключ и секрет для сервисного аккаунта с доступом к s3 bucket:
   export ACCESS_KEY="<идентификатор_ключа>"
   export SECRET_KEY="<секретный_ключ>"
 - Запустить terraform init -reconfigure -backend-config="access_key=$ACCESS_KEY" -backend-config="secret_key=$SECRET_KEY"
 - Запустить terraform plan для проверки планируемых изменений
 - Запустить terraform apply для применения изменений в инфраструктуре

## Как проверить работоспособность:
 - Проверить значения выходных переменных external_ip_address_app, external_ip_address_db
 - Подключиться к инстансам по адресам переменных.

## PR checklist
 - [+] Выставил label с номером домашнего задания
 - [+] Выставил label с темой домашнего задания

