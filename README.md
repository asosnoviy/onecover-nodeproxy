# onecover-nodeproxy

## Замер покрытия кода тестами 1С:Предприятия

proxy - Логирующий реверс-прокси для 1с  
cover - Конвертор логов proxy в формат [genericCaverage](https://docs.sonarqube.org/latest/analysis/generic-test/)  

### Хау ту

Редактируем `env.bat`  
Ставим зависимости для прокси `npm install`  
Запускаем сервер-сайд `server.bat`

* Дебагсервер 1с на порту `1550`

* Proxy на порту `3000`

* Конфигуратор с отладкой настроенной на `http://ipadr:3000`

Запускаем клиент `client.bat`

* Тонкий клиент с отлдакой настроенной на `http://ipadr:3000`

Запускаем замеры.  
Кликаем VA в клиенте.  
Останавливаем замеры.  
Логи должны накапливатся в `./log/project.log`

Запускаем `cover.bat`  
Подкладываем Сонару `genericCoverage.xml` из `./out`
