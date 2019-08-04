### Generate password with htpassws command
```
htpasswd -nbB admin 'password' | cut -d ":" -f 2
$2y$05$LpW31h/NsH9nEnPHVTM75uqsvJap7NYeFLl5XOtRRy64nArc8V5vq
```
###  add hash another $  if exits $ , look at docker-compose.yml