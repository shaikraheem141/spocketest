# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version => 2.6.5

* Rails version => 6.0

* System dependencies => MySQL

* Configuration => Change mysql username & password at config/database.yml

* Deployment instructions

```
$ bundle install
$ yarn add bootstrap@4.4.1 jquery popper.js
$ rails db:create
$ rails db:migrate
$ rails product:import_json (Products from the json file SpocketProducts.json will be imported to db)
$ rails sunspot:solr:start
$ rails sunspot:reindex

```
