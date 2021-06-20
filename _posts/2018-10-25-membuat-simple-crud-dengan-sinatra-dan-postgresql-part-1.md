---
layout: post
title: Aplikasi CRUD Sederhana Menggunakan Sinatra dan Postgresql [Part 1]
author: miral
categories: [ ruby, sinatra, activerecord, postgresql, tutorial ]
image: assets/images/sinatra-crud-postgres/page-1.png
image_external: false
featured: false
hidden: false
---

Setelah beberapa tahun blog ini tak terurus, saya mencoba menghidupkan kembali blog ini tentunya dengan topik yang saya rasa cukup menarik, yang akan saya tulis disela-sela kesibukan saya mengerjakan skripsi wkwkwk. Kalau gak salah tulisan terakhir itu tanggal 30 November 2016, udah lama banget yah.

Jadi beberapa hari yang lalu saya mendapatkan _contract_ pertama saya di [upwork](https://www.upwork.com/o/profiles/users/_~01c156fb88f920717c/) (Horeee). 
Di dalam contractnya saya diminta untuk membimbing si client untuk membuat sebuah aplikasi web sederhana menggunakan web framework [sinatra](http://sinatrarb.com), mulai dari awal pembuatan project sampai bisa di deploy ke [heroku](https://sinatra-crud-postgresql.herokuapp.com). 

Nekat aja sih, padahal saya belum pernah membuat aplikasi web pakai sinatra sebelumnya. 
Tapi yah mumpung dapat kesempatan bagus, lumayan bisa belajar terus dapat bayaran pula wkwkwk.

Di tulisan kali ini saya ini berbagi bagaimana cara membuat sebuah aplikasi CRUD sederhana menggunakan framework Sinatra dan RDBMS Postgresql.

Tulisan ini nantinya terdiri dari 4 part:
+ Part 1 - Basic Sinatra
+ [Part 2 - Menghubungkan Sinatra ke Database Postgresql Menggunakan Active Record](/2018/10/27/aplikasi-crud-sederhana-menggunakan-sinatra-dan-postgresql-part-2)
+ [Part 3 - CRUD dan View](/2018/11/02/aplikasi-crud-sederhana-menggunakan-sinatra-dan-postgresql-part-3)
+ [Part 4 - Push project ke heroku](/2018/11/09/aplikasi-crud-sederhana-menggunakan-sinatra-dan-postgresql-part-4-end)

Okey kita mulai saja.

Pertama kita buat sebuah folder project bernama `sinatra-crud-postgresql`. 

<pre>$ mkdir sinatra-crud-postgresql</pre>

Kemudian di dalam folder project kita tadi kita buat lagi 3 folder yakni `config`, `models` dan `views`. 

<pre>
$ cd sinatra-crud-postgresql
$ mkdir config models views
</pre>
Struktur foldernya seperti pada gambar dibawah ini.

![Create project]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-10-25_23-09-41.png)

Setelah itu kita buat file baru bernama `Gemfile` di root project kita dan tambahkan kode berikut ini

```ruby
# Gemfile
source "https://rubygems.org"

ruby "2.5.1"

gem "sinatra"
```

Setelah itu kita jalankan perintah
<pre>$ bundle install</pre>
Untuk menginstall `gem` yang telah kita deklarasikan di `Gemfile`.

Kemudian kita buat file baru dengan nama `app.rb`, file ini nantinya akan menjadi file utama dari aplikasi sinatra yang akan kita buat.

Struktur folder project kita sekarang seperti pada gambar dibawah ini.

![Struktur baru sinatra]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-10-26_05-26-09.png)

Kemudian pada file `app.rb` tambahkan kode berikut ini.

```ruby
# app.rb
require "sinatra"

get '/' do
  "Hello World!"
end
```
Penjelasan dari baris kode diatas adalah pertama kita akan memanggil _library_ sinatra menggunakan syntax `require "sinatra"`, kemudian kita mendeklarasikan sebuah route baru di aplikasi sinatra kita. Ketika ada `GET` request ke alamat "`/`", maka aplikasi sinatra kita akan memberikan _response_ berupa text _"Hello World!"_.

Untuk melihat hasilnya jalankan perintah
<pre>$ ruby app.rb</pre>

![Server Pertama]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-10-25_23-30-52.png)

Buka browser teman-teman, dan akses `http://localhost:4567`, jika berhasil maka akan tampil seperti pada gambar dibawah ini

![sinatra hello world]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-10-25_23-31-42.png)

Yeay, selamat kita telah berhasil membuat aplikasi web minimalis kita menggunakan sinatra.

Ditulisan berikutnya saya akan membahas bagaimana cara menghubungkan aplikasi sinatra kita ke database postgresql menggunakan active record.

Terima kasih sudah meluangkan waktunya untuk membaca tulisan saya ini.

Salam Rubyist!!
