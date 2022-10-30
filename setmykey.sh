#!/bin/bash
files=$(curl -s https://raw.githubusercontent.com/zip609/myfilles/main/mykey)
#Проверить наличие файл /root/.ssh/authorized_keys
if [ -f /root/.ssh/authorized_keys ]
then
    echo "Файл /root/.ssh/authorized_keys существует"
    #Проверить наличие ключа в файле /root/.ssh/authorized_keys
    grep -q "$files" /root/.ssh/authorized_keys
    if [ $? -eq 0 ]
    then
        echo "Ключ найден"
    else
        echo "Ключ не найден"
        echo "Добавляем ключ"
        echo "$files" >> /root/.ssh/authorized_keys
    fi
else
if [ -d /root/.ssh/ ]
then
    echo "Директория /root/.ssh/ существует"
else
    echo "Директория /root/.ssh/ не существует"
    echo "Создаем директорию /root/.ssh/"
    mkdir -p /root/.ssh/
fi
    echo "Файл /root/.ssh/authorized_keys не существует"
    echo "Создаем файл /root/.ssh/authorized_keys"
    touch /root/.ssh/authorized_keys
    echo "Добавляем ключ"
    echo "$files" >> /root/.ssh/authorized_keys
    chmod 644 /root/.ssh/authorized_keys
    chmod 700 /root/.ssh/
    systemctl restart sshd
fi

