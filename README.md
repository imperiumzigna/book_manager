# README

![Cobertura](https://github.com/imperiumzigna/book_manager/coverage/coverage-badge.png)

## Solução para desafio Zygo/PagSeguro

Este repositório contém minha implementação para o problema descrito [Link Original](https://github.com/zygotecnologia/zygo-programming-challenges/blob/master/developer/pleno/README.md) como parte do seletivo para a vaga de desenvolvedor Backend.

[Home](https://github.com/imperiumzigna/book_manager/root_page.png)
## Requisitos

* Ruby (2.7.1)
* Ruby on Rails 6.1.0
* Postgres 9.6
* NodeJs v12
## Setup

O projeto está configurado com docker.

### Inicia a aplicação

``` docker-compose up -d ```

### Roda as migrations

``` 
docker-compose exec website rails db:create 
docker-compose exec website rails db:migrate 
```

### Roda os seeds

```
 docker-compose exec website rails dev:populate
```

Ao final do comando será fornecido um email e senha para acesso admin

### Roda os testes

```
 docker-compose exec website bundle exec rspec
```


