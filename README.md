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

