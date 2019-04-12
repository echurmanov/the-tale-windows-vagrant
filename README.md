# the-tale-windows-vagrant

Устанавливаем Virtualbox и Vagrant (отсюда: https://www.vagrantup.com/downloads.html)

Прописываем в C:\Windows\System32\driver\etc\hosts

`
127.0.0.1 local.the-tale
`

Делаем `vagrant up`, устоновочный скрипт сам выкачает все что нужно из гит-хаба, настроит виртуалку и запустит все сервисы для работы "Сказки".
Остановить вируталку `vagrant halt`, повторно запустить `vagrant up --provision` (`--provision` нужен для автоматического запуска сервисов, если виртуалка уже запущена, то сервисы можно запустить из вируталки или из хостовой системы через `vagrant provision`).

Попасть на виртуалку `vagrant ssh`.
