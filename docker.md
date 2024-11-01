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

Ссылка на выгруженный images: https://hub.docker.com/r/shibegora/custom-nginx/tags

## Задача 2

```
 PS C:\Users\shibe\Desktop\docker_test> Get-Date -Format "dd-MM-yyyy HH:mm:ss.ffff K"
01-11-2024 13:03:50.2863 +03:00

PS C:\Users\shibe\Desktop\docker_test> Start-Sleep -Milliseconds 150

PS C:\Users\shibe\Desktop\docker_test> docker ps
CONTAINER ID   IMAGE                COMMAND                  CREATED          STATUS         PORTS                    NAMES
b9ac18555e38   custom-nginx:1.0.0   "/docker-entrypoint.…"   12 minutes ago   Up 2 minutes   127.0.0.1:8080->80/tcp   eg_custom-nginx-t2

PS C:\Users\shibe\Desktop\docker_test> netstat -an | Select-String "127.0.0.1:8080"

  TCP    127.0.0.1:8080         0.0.0.0:0              LISTENING

PS C:\Users\shibe\Desktop\docker_test> docker logs eg_custom-nginx-t2 -n 1
2024/11/01 10:01:45 [notice] 1#1: start worker process 39

PS C:\Users\shibe\Desktop\docker_test> docker exec -it eg_custom-nginx-t2 base64 /usr/share/nginx/html/index.html
PCEtLSBpbmRleC5odG1sIC0tPg0KPGh0bWw+DQo8aGVhZD4NCkhleSwgTmV0b2xvZ3kNCjwvaGVh
ZD4NCjxib2R5Pg0KPGgxPkkgd2lsbCBiZSBEZXZPcHMgRW5naW5lZXIhPC9oMT4NCjwvYm9keT4N
CjwvaHRtbD4=

What's next:
    Try Docker Debug for seamless, persistent debugging tools in any container or image → docker debug eg_custom-nginx-t2
    Learn more at https://docs.docker.com/go/debug-cli/

# PS C:\Users\shibe\Desktop\docker_test> curl http://127.0.0.1:8080
StatusCode        : 200
StatusDescription : OK
Content           : <!-- index.html -->
                    <html>
                    <head>
                    Hey, Netology
                    </head>
                    <body>
                    <h1>I will be DevOps Engineer!</h1>
                    </body>
                    </html>
RawContent        : HTTP/1.1 200 OK
                    Connection: keep-alive
                    Accept-Ranges: bytes
                    Content-Length: 122
                    Content-Type: text/html
                    Date: Fri, 01 Nov 2024 10:04:08 GMT
                    ETag: "672131c9-7a"
                    Last-Modified: Tue, 29 Oct 2024 1...
Forms             : {}
Headers           : {[Connection, keep-alive], [Accept-Ranges, bytes], [Content-Length, 122], [Content-Type, text/html]...}
Images            : {}
InputFields       : {}
Links             : {}
ParsedHtml        : System.__ComObject
RawContentLength  : 122
```
## Задача 3
Воспользуйтесь docker help или google, чтобы узнать как подключиться к стандартному потоку ввода/вывода/ошибок контейнера "custom-nginx-t2".

```
docker exec -it eg_custom-nginx-t2 bash
```

2. Подключитесь к контейнеру и нажмите комбинацию Ctrl-C.
3. Выполните ```docker ps -a``` и объясните своими словами почему контейнер остановился.
Мы можем подключиться по факту двумя командами, attach и exec. В случае подключения exec, мы подключаемся внутрь контейнера и его процессам, которые запушены внутри. В таком случае команда cntrl+c отменит выполняемую команду внутри контейнера, но сам контейнер продолжит работу.
В случае attach, мы цепляемся как бы к сущности самого конейнера на уровень выше, и при выполнении команды cntrl+c мы останавливаем сам процесс, который идет постоянно для выполнения работы самого контейнера.
Если провести аналогию: exec - подключаемся к ОС, attach - подключаемся к БИОС (если такое сравнение конечно допустимо). 

Зайдите в интерактивный терминал контейнера "custom-nginx-t2" с оболочкой bash.
6. Установите любимый текстовый редактор(vim, nano итд) с помощью apt-get.
```
apt-get update && apt-get install -y vim
vim /etc/nginx/conf.d/default.conf
```
