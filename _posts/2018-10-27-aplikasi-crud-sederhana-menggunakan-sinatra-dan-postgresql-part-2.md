---
layout: post
title: Aplikasi CRUD Sederhana Menggunakan Sinatra dan Postgresql [Part 2]
author: miral
categories: [ ruby, sinatra, activerecord, postgresql, tutorial ]
image: assets/images/sinatra-crud-postgres/page-2.png
image_external: false
featured: false
hidden: false
---

Halo teman-teman, di tulisan sebelumnya kita sudah belajar bagaimana membuat aplikasi sederhana menggunakan sinatra.
Untuk yang belum baca bisa dibaca [disini](/2018/10/25/membuat-simple-crud-dengan-sinatra-dan-postgresql-part-1).

Di Part 2 ini, kita akan mempelajari bagaimana menghubungkan aplikasi sinatra yang sudah kita buat di [Part 1](/2018/10/25/membuat-simple-crud-dengan-sinatra-dan-postgresql-part-1) ke database Postgresql menggunakan activerecord.


Sedekar informasi buat teman-teman yang baru berkunjung di blog ini. Tulisan ini terdiri dari 4 part, berikut ini daftar setiap part nya:

+ [Part 1 - Basic Sinatra](/2018/10/25/membuat-simple-crud-dengan-sinatra-dan-postgresql-part-1)
+ Part 2 - Menghubungkan Sinatra ke Database Postgresql Menggunakan Active Record
+ [Part 3 - CRUD dan View](http://localhost:4000/2018/11/02/aplikasi-crud-sederhana-menggunakan-sinatra-dan-postgresql-part-3)
+ [Part 4 - Push project ke heroku](/2018/11/09/aplikasi-crud-sederhana-menggunakan-sinatra-dan-postgresql-part-4-end)

Okey langsung saja kita mulai.

Langkah pertama, tambahkan beberapa gem yang dibutuhkan.

```ruby
# Gemfile
source "https://rubygems.org"

ruby "2.5.1"

gem "sinatra"

gem "activerecord"
gem "sinatra-activerecord"
gem "pg"
gem "rake"
gem "tux"

```

Kemudian jalankan perintah 

<pre>$ bundle install</pre>

Selanjutnya buat file konfigurasi database pada folder `config` bernama `database.yml`.
Kemudian tambahkan kode berikut ini.

```yaml
#config/database.yml
development:
  adapter: postgresql
  encoding: unicode
  database: sinatra-crud_development # ganti dengan nama database yang diinginkan
  pool: 5
  host: localhost
  username: root # ganti dengan username postgresql teman-teman
  password: root  # ganti dengan password untuk username postgresql teman-teman

production:
  adapter: postgresql
  encoding: unicode
  host: <%= ENV['DATABASE_HOST'] %>
  database: <%= ENV['DATABASE_NAME'] %>
  pool: 2
  username: <%= ENV['DATABASE_USERNAME'] %>
  password: <%= ENV['DATABASE_PASSWORD'] %>
```

Konfigurasi database diatas digunakan untuk environtment development dan production. Pada konfigurasi production kita menggunakan *environtment variabel*, 
nilai-nilai ini nantinya akan diset secara otomatis ketika kita push project kita ke heroku.

Langkah selanjutnya kita akan membuat sebuah kelas model bernama `Post`, dengan cara membuat file baru bernama `post.rb` pada folder `models`.

```ruby
# models/post.rb
class Post < ActiveRecord::Base
end
```

Setelah itu buat sebuah file baru lagi bernama `Rakefile`.

```ruby
# Rakefile
require "sinatra/activerecord"
require "sinatra/activerecord/rake"
require "./app"
```

`Rakefile` dibutuhkan agar kita dapat menggunakan perintah `rake` pada project kita. 

Untuk membuat database dapat menggunakan perintah berikut.

<pre>$ rake db:create</pre>

Perintah tersebut akan membuat sebuah database baru sesuai dengan konfigurasi yang ada pada `config/database.yml`.

Jika database berhasil dibuat maka akan tampil seperti gambar dibawah ini.

![Create DB]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-10-27_07-38-40.png)

Selanjutnya kita akan membuat sebuah file *database migration* baru untuk membuat tabel `Posts` yang kita beri nama `create_posts`. Caranya jalankan perintah berikut ini.

<pre>$ rake db:create_migration NAME=create_posts</pre>

Jika berhasil maka akan tampil seperti pada gambar dibawah ini.

![Create DB Migration]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-10-27_07-49-06.png)

Kemudian kita edit file `20181027004848_create_posts.rb`, tambahkan kode berikut ini.

```ruby
# db/migrate/20181027004848_create_posts.rb
class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title # Untuk membuat kolom title bertipe varchar
      t.text :content # Untuk membuat kolom content bertipe text

      t.timestamps null: false # Untuk membuat kolom timestamps
    end
  end
end

```

Jalankan perintah berikut ini untuk menjalankan *database migration*. 

<pre>$ rake db:migrate</pre>

Jika berhasil maka tampil seperti gambar berikut dan tabel `posts` berhasil dibuat.

![DB Migration Create posts Table]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-10-27_07-54-13.png)

Untuk menambahkan data ke database kita dapat menggunakan console `tux`, mirip seperti `rails console` pada Ruby on Rails.

Kita akan menambahkan satu data `post` dengan title "Greeting" dan content "Hello World!". Seperti pada gambar berikut.

![Add Data]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-10-27_08-44-50.png)

Sebelum lanjut ke tahap pengujian, pastikan struktur folder project teman-teman sama seperti gambar berikut ini.

![Add Data]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-10-27_09-05-42.png)

Kalau belum, kemungkinan ada langkah-langkah yang terlewatkan.

Selanjutnya kita akan menguji apakah aplikasi sinatra kita sudah terhubung dengan database yang sudah dibuat.

Update file `app.rb`, jadi seperti berikut ini.

```ruby
# app.rb
require 'sinatra'
require "sinatra/activerecord"

require "./models/post"

get '/' do
  @post = Post.first
  "#{@post.title} - #{@post.content}"
end

```

Jalankan aplikasi sinatra kita.

<pre>$ ruby app.rb</pre>

Kemudian kita akses alamat `http://localhost:4567/`

![Test]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-10-27_08-59-03.png)

Yeay, selamat kita berhasil menghubungkan aplikasi sinatra kita dengan database postgresql menggunakan active record.

Ditulisan berikutnya saya akan membahas bagaimana cara membuat Create Read Update Delete (CRUD) dan menambahkan views untuk aplikasi sinatra yang sudah dibuat.

Terima kasih sudah meluangkan waktunya untuk membaca tulisan saya ini.

Salam Rubyist!!


#### Update

- [20 Juni 2021] Fix typo Rackfile to Rakefile 

