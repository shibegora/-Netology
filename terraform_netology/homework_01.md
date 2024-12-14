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

[Ссылка на исправленный код (https://github.com/shibegora/-Netology/blob/main/terraform_netology/main.tf) ]
