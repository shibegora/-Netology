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

5. Зайдите в интерактивный терминал контейнера "custom-nginx-t2" с оболочкой bash.
6. Установите любимый текстовый редактор(vim, nano итд) с помощью apt-get.
```
apt-get update && apt-get install -y vim
vim /etc/nginx/conf.d/default.conf
```

7. Отредактируйте файл "/etc/nginx/conf.d/default.conf", заменив порт "listen 80" на "listen 81".
8. Запомните(!) и выполните команду ```nginx -s reload```, а затем внутри контейнера ```curl http://127.0.0.1:80 ; curl http://127.0.0.1:81```.
```
root@b9ac18555e38:/usr/share/nginx/html# nginx -s reload
2024/11/01 11:13:11 [notice] 2025#2025: signal process started
root@b9ac18555e38:/usr/share/nginx/html# `curl http://127.0.0.1:80
>
>
> ^C
root@b9ac18555e38:/usr/share/nginx/html# `curl http://127.0.0.1:81
> ^C
root@b9ac18555e38:/usr/share/nginx/html#
root@b9ac18555e38:/usr/share/nginx/html# curl http://127.0.0.1:80
curl: (7) Failed to connect to 127.0.0.1 port 80: Connection refused
root@b9ac18555e38:/usr/share/nginx/html# curl http://127.0.0.1:81
<!-- index.html -->
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I will be DevOps Engineer!</h1>
</body>
```

10. Проверьте вывод команд: ```ss -tlpn | grep 127.0.0.1:8080``` , ```docker port custom-nginx-t2```, ```curl http://127.0.0.1:8080```. Кратко объясните суть возникшей проблемы.
```
netstat -ano | findstr "127.0.0.1:8080"
  TCP    127.0.0.1:8080         0.0.0.0:0              LISTENING       26024
docker port eg_custom-nginx-t2
80/tcp -> 127.0.0.1:8080
curl http://127.0.0.1:8080
Базовое соединение закрыто: Соединение было неожиданно закрыто.
```
По умолчанию http трафик идет по 80 порту. Мы изменили порт, который читает контейнер на 81, который по умолчанию закрыт.
Для того что бы обратиться по 81 порту к контейнеру, нужно запустит ьпринудительное использование данного порта на нашем пк при обращении к контейнеру. 
Командой ``` docker run -d -p 81:80 --name eg_custom-nginx-t2 ``` мы делаем натирование портов, что при обращении к 81 порту нас переводило на 80ый, таким образом "прикрывая" настоящий используемый порт контейнера. 
Для решения данной задачи воспользовался данной инструкцией: https://ru.hexlet.io/blog/posts/mapping-docker#kak-naznachit-mapping-rabotayuschemu-docker-konteyner
Т.К. контейнер нельзя удалять и прописать маппинг портов по новой при запуске RUN, изменяем конфигурацию конфиг файла существующего контейнера:
- ```docker inspect --format="{{.Id}}" eg_custom-nginx-t2 ``` - получаем 64 значный id контейнера
- ``` systemctl stop docker ``` - останавливаем службу docker на время проведения изменения конфигурации.
Т.К. на винде невозможно найти файл по id, я воспользовался docker desktop и


## Задача 4
Запустите первый контейнер из образа ***centos*** c любым тегом в фоновом режиме, подключив папку  текущий рабочий каталог ```$(pwd)``` на хостовой машине в ```/data``` контейнера, используя ключ -v.
```
PS C:\Users\shibe\Desktop\docker_test> docker run -d --name centos-container -v ${PWD}:/data centos
Unable to find image 'centos:latest' locally
latest: Pulling from library/centos
a1d0c7532777: Download complete
Digest: sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177
Status: Downloaded newer image for centos:latest
faee682fa4ae8322290410fb8312fec972006f13b4444c3ac530cabd800ec8e7
```
апустите второй контейнер из образа ***debian*** в фоновом режиме, подключив текущий рабочий каталог ```$(pwd)``` в ```/data``` контейнера.
```
PS C:\Users\shibe\Desktop\docker_test> docker run -d --name debian-container -v ${PWD}:/data debian
Unable to find image 'debian:latest' locally
latest: Pulling from library/debian
7d98d813d54f: Download complete
Digest: sha256:e11072c1614c08bf88b543fcfe09d75a0426d90896408e926454e88078274fcb
Status: Downloaded newer image for debian:latest
35e09c1b04d15430fc27df2cbf6e8625d9c59a1b15aca751607161683104ccc4
```
Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```.



## Задача 5
Выполните команду "docker compose up -d". Какой из файлов был запущен и почему?
Команда docker-compose up (на windows требуется тире) обращается напрямую к файлу compose из-за приоритетности. 
Файл compose.yaml я указал следующий:
```
version: '3'
services:
  portainer:
    image: portainer/portainer-ce:latest
    container_name: portainer
    ports:
      - 8000:8000
      - 9443:9443
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock



  registry:
    image: registry:2
    container_name: registry
    depends_on:
      - portainer
    ports:
    - "5000:5000"
```
После чего 2 контейнера запустились. 
```
PS C:\Users\shibe\Desktop\docker_test\task5> docker compose up -d
time="2024-11-01T17:01:23+03:00" level=warning msg="Found multiple config files with supported names: C:\\Users\\shibe\\Desktop\\docker_test\\task5\\compose.yaml, C:\\Users\\shibe\\Desktop\\docker_test\\task5\\docker-compose.yaml"
time="2024-11-01T17:01:23+03:00" level=warning msg="Using C:\\Users\\shibe\\Desktop\\docker_test\\task5\\compose.yaml"
time="2024-11-01T17:01:23+03:00" level=warning msg="C:\\Users\\shibe\\Desktop\\docker_test\\task5\\compose.yaml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion"
[+] Running 18/18
 ✔ registry Pulled                                                                                                                                                                                        5.5s
   ✔ 85ab09421e5a Download complete                                                                                                                                                                       0.4s
   ✔ 1cc3d825d8b2 Download complete                                                                                                                                                                       2.0s
   ✔ e7bb1dbb377e Download complete                                                                                                                                                                       0.9s
   ✔ a538cc9b1ae3 Download complete                                                                                                                                                                       0.8s
   ✔ 40960af72c1c Download complete                                                                                                                                                                       1.3s
 ✔ portainer Pulled                                                                                                                                                                                       9.8s
   ✔ 542669febe7c Download complete                                                                                                                                                                       3.3s
   ✔ 846480e9f8b0 Download complete                                                                                                                                                                       4.4s
   ✔ d40df14c1d7a Download complete                                                                                                                                                                       2.1s
   ✔ 070d3bf2528e Download complete                                                                                                                                                                       0.9s
   ✔ 6c27c7f45b54 Download complete                                                                                                                                                                       6.1s
   ✔ 8215717c7c10 Download complete                                                                                                                                                                       3.5s
   ✔ c7053d7d4c2a Download complete                                                                                                                                                                       3.1s
   ✔ a2ed6de7fb5f Download complete                                                                                                                                                                       1.0s
   ✔ 2a8c27161aa3 Download complete                                                                                                                                                                       1.1s
   ✔ 679061c2c821 Download complete                                                                                                                                                                       1.0s
   ✔ 4f4fb700ef54 Already exists                                                                                                                                                                          0.1s
[+] Running 3/3
 ✔ Network task5_default  Created                                                                                                                                                                         0.0s
 ✔ Container portainer    Started                                                                                                                                                                         0.7s
 ✔ Container registry     Started                                                                                                                                                                         0.7s
PS C:\Users\shibe\Desktop\docker_test\task5> docker ps
CONTAINER ID   IMAGE                           COMMAND                  CREATED         STATUS         PORTS                                                      NAMES
2708c28c9af4   registry:2                      "/entrypoint.sh /etc…"   5 seconds ago   Up 4 seconds   0.0.0.0:5000->5000/tcp                                     registry
0e1760239e74   portainer/portainer-ce:latest   "/portainer"             5 seconds ago   Up 4 seconds   0.0.0.0:8000->8000/tcp, 0.0.0.0:9443->9443/tcp, 9000/tcp   portainer
b9ac18555e38   custom-nginx:1.0.0              "/docker-entrypoint.…"   4 hours ago     Up 2 hours     127.0.0.1:8080->80/tcp                                     eg_custom-nginx-t2
PS C:\Users\shibe\Desktop\docker_test\task5>
```


Перейдите на страницу "http://127.0.0.1:9000/#!/2/docker/containers", выберите контейнер с nginx и нажмите на кнопку "inspect". В представлении <> Tree разверните поле "Config" и сделайте скриншот от поля "AppArmorProfile" до "Driver".
![image](https://github.com/user-attachments/assets/d36b1281-3f7a-46b9-844e-4154d01c90a9)
```
98cbd77bd6d407ad869d2c0ced8921882e675082b6c492d33219e4193ef29bd6
AppArmorProfile
Args
0 nginx
1 -g
2 daemon off;
Config
AttachStderr true
AttachStdin false
AttachStdout true
Cmd [ nginx, -g, daemon off; ]
Domainname
Entrypoint [ /docker-entrypoint.sh ]
Env [ PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin, NGINX_VERSION=1.27.2, NJS_VERSION=0.8.6, NJS_RELEASE=1~bookworm, PKG_RELEASE=1~bookworm, DYNPKG_RELEASE=1~bookworm ]
ExposedPorts { 80/tcp: [object Object] }
Hostname 98cbd77bd6d4
Image 127.0.0.1:5000/custom-nginx
Labels { com.docker.compose.config-hash: 8b9fe9ab3a7934244a4cb3d97ea83abe99d1849b88a7d7931370a021dd008c42, com.docker.compose.container-number: 1, com.docker.compose.depends_on: , com.docker.compose.image: sha256:367678a80c0be120f67f3adfccc2f408bd2c1319ed98c1975ac88e750d0efe26, com.docker.compose.oneoff: False, com.docker.compose.project: custom-nginx, com.docker.compose.project.config_files: /data/compose/4/docker-compose.yml, com.docker.compose.project.working_dir: /data/compose/4, com.docker.compose.service: nginx, com.docker.compose.version: 2.29.2, maintainer: NGINX Docker Maintainers <docker-maint@nginx.com> }
OnBuild
OpenStdin false
StdinOnce false
StopSignal SIGQUIT
Tty false
User
Volumes
WorkingDir
Created 2024-11-01T14:29:53.884136361Z
Driver overlayfs
```
7. Удалите любой из манифестов компоуза(например compose.yaml).  Выполните команду "docker compose up -d". Прочитайте warning, объясните суть предупреждения и выполните предложенное действие. Погасите compose-проект ОДНОЙ(обязательно!!) командой.
```
   PS C:\Users\shibe\Desktop\docker_test\task5> docker compose up -d
time="2024-11-01T17:36:56+03:00" level=warning msg="C:\\Users\\shibe\\Desktop\\docker_test\\task5\\docker-compose.yaml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion"
time="2024-11-01T17:36:56+03:00" level=warning msg="Found orphan containers ([portainer]) for this project. If you removed or renamed this service in your compose file, you can run this command with the --remove-orphans flag to clean it up."
[+] Running 2/2
 ✔ Container registry          Recreated                                                                                                                                                                  0.4s
 ✔ Container task5-registry-1  Started                                                                                                                                                                    0.3s
PS C:\Users\shibe\Desktop\docker_test\task5>
```
Как говорилось ранее, на ОС команда видит 2 файоа сразу, а запуск был по приоритету. После удаления compose, стал запускаться docker-compose, при этом в директории только 1 файл. 
![image](https://github.com/user-attachments/assets/8b58a252-4b75-4bb9-884e-f1133e7717ef)
```
PS C:\Users\shibe\Desktop\docker_test\task5> ls


    Каталог: C:\Users\shibe\Desktop\docker_test\task5


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        01.11.2024     16:55             92 docker-compose.yaml


PS C:\Users\shibe\Desktop\docker_test\task5>
```
