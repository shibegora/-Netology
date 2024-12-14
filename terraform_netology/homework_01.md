## Скачайте и установите Terraform версии >=1.8.4 . Приложите скриншот вывода команды terraform --version

![image](https://github.com/user-attachments/assets/e52b4976-de3e-463c-ba8b-719a23423998)

### Задание 1
Изучите файл .gitignore. В каком terraform-файле, согласно этому .gitignore, допустимо сохранить личную, секретную информацию?(логины,пароли,ключи,токены итд)
  - Судя по файлу, логины, ключи и прочая конфиденциальная информация будет храниться в файле "tfstate".

Выполните код проекта. Найдите в state-файле секретное содержимое созданного ресурса random_password, пришлите в качестве ответа конкретный ключ и его значение.
  - "result": "vVKN03mSN086BDVc"
  - 
Раскомментируйте блок кода, примерно расположенный на строчках 29–42 файла main.tf. Выполните команду terraform validate. Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.
```
egor@egor-HLY-WX9XX:~/Media/vsCode/ter-homeworks/01/src$ terraform validate
Success! The configuration is valid.
```
Использование числа "1nginx" в имени ресурса недопустимо. Имена должны начинаться с буквы и могут включать буквы, цифры, подчеркивания или тире.
Переменная random_password.random_string_FAKE.resulT написана не корреткно, мы не задавали имя random_string_FAKE в resource "random_password", а так-же в переменной resulT допущена синтаксическая ошибка.
resource "docker_container" не сможет найти image, который мы указали ему в качесте переменных из resource "docker_image", ведь мы его не раскомментировали (он выше 29 строки). Плюсом ко всему в resource "docker_image" следует указать имя, которое мы указали в качестве переменной в resource "docker_container"

[Ссылка на исправленный код](https://github.com/gaidarvu/ter-homeworks/blob/main/01/src/main.tf)

Выполните код. В качестве ответа приложите: исправленный фрагмент кода и вывод команды docker ps.
![изображение](https://github.com/user-attachments/assets/9f3b4f75-5cce-4347-9966-f4ac26c1ef4a)


Замените имя docker-контейнера в блоке кода на hello_world
В таком случае я добавли строку name и заккоментировал прошлое значение:
```
resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name = hello_world
  #name  = "example_${random_password.random_string.result}"
```
Вывод команды:
![изображение](https://github.com/user-attachments/assets/ec07c3f2-b16f-4ff7-9f3e-d5b323d2e8cc)

Объясните своими словами, в чём может быть опасность применения ключа -auto-approve. Догадайтесь или нагуглите зачем может пригодиться данный ключ?
  - применение ключа -auto-approve может привести к тому, что изменения, внесенные по ошибке или же не планировавшиеся внестись (например использование какой то версии и прочего) автоматически применятся, из-за чего пересоздатся уже использованный и рабочий блок кода расчитаный на прошлую верию. Простыми словами - использование этого ключа без точного понимания вносимых исправлений может привести к поломке рабочего кода. 

Уничтожьте созданные ресурсы с помощью terraform. Убедитесь, что все ресурсы удалены. Приложите содержимое файла terraform.tfstate.
```
Destroy complete! Resources: 3 destroyed.
egor@egor-HLY-WX9XX:~/Media/vsCode/ter-homeworks/01/src$ docker ps
permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.47/containers/json": dial unix /var/run/docker.sock: connect: permission denied
egor@egor-HLY-WX9XX:~/Media/vsCode/ter-homeworks/01/src$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
egor@egor-HLY-WX9XX:~/Media/vsCode/ter-homeworks/01/src$
```

Содержимое файла terraform.tfstate:
```
{
  "version": 4,
  "terraform_version": "1.10.2",
  "serial": 11,
  "lineage": "10dc044c-7f9e-6575-f0db-a9cc67f40877",
  "outputs": {},
  "resources": [],
  "check_results": null
}

```

Объясните, почему при этом не был удалён docker-образ nginx:latest. Ответ ОБЯЗАТЕЛЬНО НАЙДИТЕ В ПРЕДОСТАВЛЕННОМ КОДЕ, а затем ОБЯЗАТЕЛЬНО ПОДКРЕПИТЕ строчкой из документации terraform провайдера docker. (ищите в классификаторе resource docker_image )
  - ключ значение в файле main.tv ```keep_locally = true``` означает использование image локально на машине. Команда terraform destroy при значении false или же вообще без указания ```keep_locally = true``` удалит данный образ. 
