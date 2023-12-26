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
