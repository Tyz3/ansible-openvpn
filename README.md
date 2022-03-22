# Установка Ansible

Оффициальное руководство по установке для вашего дистрибутива:
https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-specific-operating-systems

Дополнительные пакеты для работы Ansible: **python3**, **sshpass**.

# Подготовка удалённого сервера

1.  Установить и включить ssh
_(debian) Во время установки ОС нужно поставит галочку напротив пакета OpenSSH_
2.  (опционально) Разрешить подключаться по ssh с помощью учётной записи **root**
_Руководство: https://www.dmosk.ru/miniinstruktions.php?mini=ubuntu-ssh-root_

# Запуск Playbook
```ansible-playbook deploy_config.yml -i inventories/inv.yml```

# Примеры простых Ad-Hoc команд из консоли
1.  Пользовательская команд
```ansible all -a "command arg1 arg2 ..."```
2.	Пинг
```ansible all -m ping```
3.	Информация об архитектуре процессора
```ansible all -m shell -a "uname -a"```
4.	Использование пакетного менеджера
```ansible all -m (apt|yum|...) -a "name=exemple_pkg_name"```
5.	Расход ОЗУ
```ansible all -m shell -a "free -m -h"```
6.	Расход физической памяти
```ansible all -m shell -a "df -h"```
7.	Передача файлов на хост-машины
```ansible all -m copy -a "src=/root/f1 dest=/home/kali"```
