# Домашнее задание к занятию 4 

## Задача 1
1. Установите docker и docker compose plugin на свою linux рабочую станцию или ВМ.
Установил на личный ПК
```
PS C:\Users\shibe> docker --version
Docker version 27.2.0, build 3ab4256
```

```
PS C:\Users\shibe> docker-compose --version
Docker Compose version v2.29.2-desktop.2
PS C:\Users\shibe>
```
2. Docker-hub доступен, есть ВПН и pull происходил корректно.
3. ![image](https://github.com/user-attachments/assets/08a0cc82-3f61-4f1d-bed8-cb6539b36112)
4. Создан файл index.html, в котором прописано:
 ```
<!-- index.html -->
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I will be DevOps Engineer!</h1>
</body>
</html>
```

а так же сам dockerfile с содержимым:

```
FROM nginx:1.21.1
WORKDIR /usr/share/nginx/html
RUN rm -f index.html
COPY index.html /usr/share/nginx/html
```

https://hub.docker.com/r/shibegora/custom-nginx/tags


## Задача 2
