# ivankiselev320_infra

ivankiselev320 Infra repository

### ДЗ №2

Исправлена ошибка

```
    def test_equal(self):


self.assertEqual(1 + 1, 2)
```

### ДЗ №3

Содержимое ssh config

```
cat .\config
Host someinternalhost
HostName 10.128.0.18
User appuser
IdentityFile ~/.ssh/appuser
ForwardAgent yes

Host bastion
HostName 158.160.32.136
User appuser
IdentityFile ~/.ssh/appuser
ForwardAgent yes
```

Данные для подключения

bastion_IP = 158.160.32.136

someinternalhost_IP = 10.128.0.18

### ДЗ №4

Создаем инстанс командой

```
yc compute instance create \
--name reddit-app \
--hostname reddit-app \
--platform-id "standard-v3" \
--cores 2 \
--memory 2G \
--create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
--network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
--metadata serial-port-enable=1 \
--zone ru-central1-a \
--metadata-from-file user-data=./metadata.yml
```

testapp_IP = 158.160.105.103

testapp_port = 9292

### ДЗ №5

- Подготовлен [образ для packer](/packer/ubuntu16.json) с необходимыми зависимостями и
  скриптами [install_ruby.sh](/packer/scripts/install_ruby.sh)
  и [install_mongodb.sh](/packer/scripts/install_mongodb.sh). [Файл](/packer/service-account-key.json.example) для
  авторизации невалидный, создан для примера и прохождения валидации теста.
- Создан [variables.json.example](/packer/variables.json.example) для параметризации.
- Для ручного деплоя запускаем следующие команды:

```
sudo apt install -y git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
```

- Подготовлен второй [образ для packer](/packer/immutable.json) со
  скриптами [install_ruby.sh](/packer/scripts/install_ruby.sh), [install_mongodb.sh](/packer/scripts/install_mongodb.sh)
  , [deploy.sh](/packer/scripts/deploy.sh). Само приложение запускается как [служба](/packer/files/reddit.service) при
  загрузке ОС.
- [Скрипт](/config-scripts/create-reddit-vm.sh) для создания инстанса с помощью yc.

### ДЗ №6

- Создан main.tf где описано создание виртуальной машины с добавление скрипта deploy.sh и службы puma.service
- Параметризованы переменные, для примера добавлен файл terraform.tfvars.example
- Создан lb.tf для создания балансировщика

### ДЗ №7

- Созданы два образа для packer: [app.json](packer/app.json), [db.json](packer/db.json)
- Предыщущий проект разбит на модули: [vpc](terraform/modules/vpc/main.tf), [app](terraform/modules/app/main.tf)
  , [db](terraform/modules/db/main.tf)
- Созданы каталоги stage и prod с описанной инфраструктурой, файлы из ./terraform удалены
- Настроен remote backends, описано в файле [storage-bucket.tf](terraform/storage-bucket.tf) и протестирован
- Добавлены provisioners в модули для деплоя приложения, файлы находятся в каталоге модулей

### ДЗ №8

- Установлен ansible
- Создано окружение из предыдущей домашней работы с помощью terraform
- Создан [inventory](ansible/old/inventory) в текстовом формате
- Создан [inventory.yml](ansible/inventory.yml) в .yml формате
- Создан [ansible-playbook](ansible/old/clone.yml)
- Создан [скрипт](ansible/old/inventory.py) на python для создания файла [inventory.json](ansible/old/inventory.json)

### ДЗ #9

- Создан плейбук с тегами [reddit_app_one_play.yml](ansible/old/reddit_app_one_play.yml)
- Создан плейбук с несколькими сценариями [reddit_app_multiple_plays.yml](ansible/old/reddit_app_multiple_plays.yml)
- Разбит на несколько плейбуков [app.yml](ansible/playbooks/app.yml), [db.yml](ansible/playbooks/db.yml)
  , [deploy.yml](ansible/playbooks/deploy.yml). Включены в один плейбук [site.yml](ansible/playbooks/site.yml)
- Изменены образы packer для приложения [app.json](packer/app.json) и базы данных [db.json](packer/db.json) собираются с
  помощью [packer_app.yml](packer/ansible/packer_app.yml) и [packer_db.yml](packer/ansible/packer_db.yml) соответственно
- На основе новых образов с помощью terraform и плейбука [site.yml](ansible/playbooks/site.yml) созданы инстаны и деплой
  приложения

### ДЗ #10

- Созданные плейбуки перенесены в отдельные роли [app](ansible/roles/app) и [db](ansible/roles/db)
- Описаны два окружения [prod](ansible/environments/prod) и [stage](ansible/environments/stage)
- Использована комьюнити роль для обратного прокси, в методичке указано что необходимо внести данную роль в .gitignore,
  но тогда коммит не проходит тесты
- Написан плейбук [users.yml](ansible/playbooks/users.yml) для создания пользователей
- Зашифрованы данные о учетных записях в окружении с помощью Ansible Vault

### ДЗ #11

- Установлен Vagrant и зависимости
- Создан [Vagrant](ansible/Vagrantfile) файл описывающий инфраструктуру, так же добавлен провижинер ансибл
- добавлен плейбук [base.yml](ansible/playbooks/base.yml)
- Переделаны плейбук [site.yml](ansible/playbooks/site.yml) и роли [db.yml](ansible/roles/db/tasks/main.yml), [app.yml](ansible/roles/app/tasks/main.yml)
- Описан тест db для проверки запущен ли сервис, есть ли конфиг файл, так же добавлен тест доступности по порту [test_default.py](ansible/roles/db/molecule/default/tests/test_default.py)

### ДЗ #16

- Создана машина в YC, поднят Gitlab и настроен Runner
- Создан файл [.gitlab-ci.yml](.gitlab-ci.yml) в нем описан pipeline c несколькими stages для сборки, тестов и деплоя приложения
- Созданы задачи для деплоя приложения по тегу и в ручном режиме
- Добавлено динамическое окружение
