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
