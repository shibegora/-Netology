## Убедитесь что у вас НЕ(!) установлен docker-compose, для этого получите следующую ошибку от команды docker-compose --version
```
PS C:\Windows\system32> docker-compose --version
docker-compose : Имя "docker-compose" не распознано как имя командлета, функции, файла сценария или выполняемой програм
мы. Проверьте правильность написания имени, а также наличие и правильность пути, после чего повторите попытку.
строка:1 знак:1
+ docker-compose --version
+ ~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (docker-compose:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException

PS C:\Windows\system32>
```
## Убедитесь что у вас УСТАНОВЛЕН docker compose(без тире) версии не менее v2.24.X, для это выполните команду docker compose version
Если ставить docker compose на windows, то при вводе docker compose/docker-compose команда обращается к Docker Compose version v2.29.2-desktop.2
```
PS C:\Windows\system32> docker compose version
Docker Compose version v2.29.2-desktop.2
PS C:\Windows\system32> docker-compose version
Docker Compose version v2.29.2-desktop.2
```
