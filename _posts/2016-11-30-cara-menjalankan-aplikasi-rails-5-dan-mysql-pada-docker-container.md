---
layout: post
title:  "Cara Menjalankan Aplikasi Rails 5 + MySQL Pada Docker Container"
author: miral
categories: [ Ruby, Ruby on Rails, Docker, Container, tutorial ]
image: https://images.unsplash.com/photo-1493946740644-2d8a1f1a6aff?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=488a4ba9014132269a54faab75b6de49&auto=format&fit=crop&w=768&q=80
image_external: true
featured: false
hidden: false
---

Selamat malam teman-teman, kali ini saya ingin sharing tutorial bagaimana cara menggunakan Docker pada aplikasi Rails versi 5. 
Sebelum memulai tutorialnya pastikan komputer / laptop / macbook (amin :smile:) teman-teman sudah terinstall rails versi 5 dan docker 1.12.3 ya.

### Bahan - bahan
Aplikasi yang akan kita gunakan pada tutorial kali ini antara lain:

- [OS Ubuntu 14.04.5 64bit](http://www.gudangilmukomputer.com/2015/05/cara-instal-ubuntu-1504-lengkap-dengan-gambar.html)
- [Rails versi 5.0.0.1](https://gorails.com/setup/ubuntu/16.04)
- [Docker versi 1.12.3](https://docs.docker.com/engine/installation/linux/ubuntulinux/)
- [Docker compose versi 1.9.0](https://docs.docker.com/compose/install/)

Tutorial instalasi aplikasi bisa langsung diklik pada nama aplikasinya

### Deskripsi Project
Pada tutorial ini kita akan membuat sebuat aplikasi rails sederhana yaitu sebuah aplikasi note, dimana kita bisa 
menyimpan note pada aplikasi rails kita. Kemudian, kita akan menggunakan MySQL 5.7 sebagai database nya. 
Satu hal yang perhatikan bahwa proyek yang kita akan buat kali ini khusus untuk dijalankan pada environment development, jadi bukan untuk production.


Langsung saja kita mulai tutorialnya.

### Langkah-langkah

Pertama kita buat sebuah projek rails baru dengan menggunakan perintah:

```
rails new noteapp -d mysql
```
**-d** : artinya kita akan menggunakan database MySQL.

tunggu sampai struktur projeknya selesai dibuat. Jika sudah sampai pada tampilan seperti dibawah ini,

![langkah pertama]({{ site.url }}/assets/images/tutorial-rails-docker/langkah pertama.png)

Berarti struktur projek aplikasi rails teman-teman telah selesai dibuat.

Kemudian kita buka folder projek rails yang telah dibuat menggunakan text editor favorit teman-teman,
kali ini saya menggunakan sublime text 3. Tampilan projeknya akan seperti ini.

![Projek rails baru]({{ site.url }}/assets/images/tutorial-rails-docker/02.png)

Setelah itu kita jalankan perintah:

```ruby
rails generate scaffold Note title:string content:text
```

Perintah ini akan mengenerate struktur folder beserta file-file yang dibutuhkan agar aplikasinya bisa kita jalankan.

![Generate Scaffold]({{ site.url }}/assets/images/tutorial-rails-docker/03.png)

Kemudian kita akan melakukan beberapa config pada file _database.yml_

```yml
#noteapp/config/database.yml

default: &default
  adapter: mysql2
  encoding: utf8
  pool: 5
  host: <%= ENV['NOTEAPP_DATABASE_HOST'] %>
  username: <%= ENV['NOTEAPP_DATABASE_USERNAME'] %>
  password: <%= ENV['NOTEAPP_DATABASE_PASSWORD'] %>
  socket: /var/run/mysqld/mysqld.sock

development:
  <<: *default
  database: noteapp_development

test:
  <<: *default
  database: noteapp_test

production:
  <<: *default
  database: noteapp_production

```

kalau diperhatikan pada bagian __*host*__, __*username*__, __*password*__ kita menggunakan environment 
variabel yang nantinya kita akan buat filenya.

Sekarang kita perlu membuat sebuah environment file __*.env*__, kemudian kita ketikkan sebagai berikut:

```yaml
#noteapp/.env

# App Env
NOTEAPP_DATABASE_HOST=db
NOTEAPP_DATABASE_USERNAME=root
NOTEAPP_DATABASE_PASSWORD=password

# MySQL Env
MYSQL_ROOT_PASSWORD=password

```

NOTEAPP_DATABASE_HOST merupakan environment variable yang kita gunakan untuk mengisi attribut host pada 
konfigurasi _**database.yml**_. Kita menggunakan nama __*db*__ karena nama tersebut merupakan nama dari 
kontainer database MySQL kita yang nanti kita akan koneksikan ke kontainer aplikasi rails kita.

Langkah berikutnya kita akan membuat sebuah file __*Dockerfile*__. Dockerfile bisa disebut sebagai sebuah file resep 
untuk membuat sebuah image, didalam file docker file berisi bahan-bahan dan perintah-perintah yang dibutuhkan 
untuk membuat sebuah image.

Langsung saja kita buat sebuat file bernama __*Dockerfile*__ pada root folder aplikasi rails kita.

```ruby
#noteapp/Dockerfile

# kita akan menggunakan image ruby:2.3.2-alpine sebagai 
# base image dari image baru kita
FROM ruby:2.3.2-alpine

# Kita perlu menginstall packet / library yang akan 
# dibutuhkan oleh aplikasi kita.
RUN apk --update add --virtual build-dependencies \
                               build-base \
                               libxml2-dev \
                               libxslt-dev \
                               zlib-dev \
                               mysql-dev \
                               nodejs \
                               tzdata \
                               && rm -rf /var/cache/apk/*

# perintah ini akan membuat sebuah folder bernama app
# pada image baru kita
RUN mkdir -p /usr/src/app

# perintah ini akam merubah folder kerja kita menjadi
# /usr/src/app
WORKDIR /usr/src/app

# perintah ini akan melakukan proses copy Gemfile dari komputer
# kita ke image baru
COPY Gemfile Gemfile.lock ./

# perintah ini akan menjalankan bundle install pada image
RUN gem install bundler && bundle install --jobs 20

# Perintah ini akan menjalankan proses copy folder source 
# code aplikasi noteapp kita ke dalam image.
COPY . ./
```

Setelah membuat Dockerfile selanjutnya kita akan membuat sebuah file lagi bernama *docker-compose.yml*.

```yaml
#noteapp/docker-compose.yml

version: '2'

services:
  app:
    build: .
    depends_on:
      - db
    links:
      - db
    env_file:
      - .env
    ports:
      - "3000:3000"
    volumes:
      - .:/usr/src/app
    command: rails server -b 0.0.0.0 -p 3000

  db:
    image: mysql:5.7
    env_file:
      - .env

```

Kita akan menggunakan 2 buah image yang pertama *app* kemudian yang kedua adalah *db*.

- ```build: .``` artinya docker akan membuild sebuah image baru berdasarkan resep pada ```Dockerfile```
- ```depends_on: -db``` artinya container ```app``` akan running setelah container ```db``` running. 
- ```links: -db``` artinya container ini akan dikoneksikan ke container ```db```. 
- ```env_file: .env``` artinya container ini akan menggunakan environment variabel yang ada pada file ```.env```
sebagai environment variabel pada image
- ```ports: -"3000:3000"``` artinya kita akan membuka port 3000 pada container, yang bisa kita akses dari luar kontainer pada porst 3000 juga
- ```volumes: .:/usr/src/app``` artinya kita akan menghubungkan direktori projek kita yang ada dilaptop ke
direktori ```/usr/src/app``` pada image.
- ```command: rails server -b 0.0.0.0 -p 3000``` artinya ketika kita menjalankan kontainer dari image ini,maka container akan otomatis menjalankan perintah ini pada saat startup.

Image *db*
- ```image: mysql:5.7``` kita akan menggunakan image mysql:5.7 sebagai database
- ```env_file: .env``` image *db* akan membaca file .env untuk mencari environmen variabel MYSQL_ROOT_PASSWORD.

Kemudian kita save file *docker-compose.yml* tersebut pada root directory noteapp kita. Jalankan perintah

```yaml
docker-compose build
```
untuk membuild image kita berdasarkan config dari file *docker-compose.yml*

Proses pembuatan image akan berjalan, tunggu beberapa menit, tergantung kecepatan internet kita :smile:.

![docker compose build]({{site.url}}/assets/images/tutorial-rails-docker/04.png)

Jika proses build nya sudah selesai maka tampilannya akan mirip dengan tampilan berikut

![docker compose build]({{site.url}}/assets/images/tutorial-rails-docker/05.png)

Setelah itu kita akan menjalankan container menggunakan perintah

```ruby
docker-compose up
```

Maka tampilannya akan seperti berikut ini

![docker compose build]({{site.url}}/assets/images/tutorial-rails-docker/06.png)

Kemudian jalankan aplikasi web browser, dan akses alamat

```ruby
http://localhost:3000
```

Jika muncul tampilan seperti dibawah ini 

![docker compose build]({{ site.url}}/assets/images/tutorial-rails-docker/07.png)

Jangan panik dulu, menurut pesan erornya menunjukan Unknown database, karena database untuk aplikasi kita belum dibuat. Untuk itu mari kita buat databasenya

```ruby
docker exec noteapp_app_1 rails db:setup
docker exec noteapp_app_1 rails db:migrate
```

noteapp_app_1 adalah nama container aplikasi rails kita. Mungkin di komputer teman-teman akan berbeda namanya. Untuk mengeceknya teman-teman bisa menjalankan perintah

```ruby
docker ps
```
Kira-kira outputnya akan seperti ini.

![docker compose build]({{ site.url}}/assets/images/tutorial-rails-docker/08.png)

Ketika perintah 	```rails db:setup``` dan ```rails db:migrate``` dijalankan akan muncul output sebagai berikut

![docker compose build]({{ site.url}}/assets/images/tutorial-rails-docker/09.png)

Kemudian kita kembali ke web browser dan refresh page.

Waawww,, aplikasi rails kita sudah running :smile:

![docker compose build]({{ site.url}}/assets/images/tutorial-rails-docker/10.png)

Eitss.. tunggu dulu. Kita masih perlu merubah file ```config/routes.rb``` pada projek kita, agar aplikasi noteapp kita bisa berjalan semestinya

```ruby
# config/routes.rb

Rails.application.routes.draw do
 root 'notes#index'
 resources :notes
end

```

Kemudian di refresh page pada browser

![docker compose build]({{ site.url}}/assets/images/tutorial-rails-docker/11.png)

Maka tampilannya kira-kira akan seperti ini. 

Selamat kita telah berhasil menjalankan aplikasi rails + mysql pada container docker :smile:.

Terima kasih sudah membaca tutorial bagaimana cara menjalankan aplikasi rails 5 + mysql pada docker container. Jika ada penjelasan saya yang kurang tepat mohon dikoreksi silahkan memberikan komentar di bawah ini :smile:, soalnya saya juga baru belajar mengenai teknologi container pada docker, jadi pemahaman saya mengenai docker masih banyak kurangnya. Saya menantikan komentar teman-teman, supaya kita bisa belajar bersama-sama :smile:
