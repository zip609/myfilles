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
    echo "Файл /root/.ssh/authorized_keys не существует"
    echo "Создаем файл /root/.ssh/authorized_keys"
    touch /root/.ssh/authorized_keys
    echo "Добавляем ключ"
    echo "$files" >> /root/.ssh/authorized_keys
fi
#установить права на файл /root/.ssh/authorized_keys
chmod 644 /root/.ssh/authorized_keys
#установить права на директорию /root/.ssh/
chmod 700 /root/.ssh/
#перезаупустить сервис sshd
systemctl restart sshd