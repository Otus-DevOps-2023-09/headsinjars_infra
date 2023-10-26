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
