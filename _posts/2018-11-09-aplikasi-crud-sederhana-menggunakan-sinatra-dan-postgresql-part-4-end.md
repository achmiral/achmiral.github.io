---
layout: post
title: Aplikasi CRUD Sederhana Menggunakan Sinatra dan Postgresql [Part 4] END
author: miral
categories: [ ruby, sinatra, activerecord, postgresql, tutorial ]
image: assets/images/sinatra-crud-postgres/page-4.png
image_external: false
featured: false
hidden: false
---

Halo teman-teman sebelum weekend, yuk belajar bareng membuat **Aplikasi CRUD Sederhana Menggunakan Sinatra dan Postgresql**

Di [part 3](/2018/11/02/aplikasi-crud-sederhana-menggunakan-sinatra-dan-postgresql-part-3) kita sudah belajar bagaimana cara menambahkan fungsi **CRUD** dan view pada aplikasi kita. Di part 4 atau part terakhir ini, kita akan belajar bagaimana mempublish aplikasi sinatra kita ke [heroku](https://id.heroku.com/login) agar bisa di akses secara online.

Sedekar informasi buat teman-teman yang baru berkunjung di blog ini. Tulisan ini terdiri dari 4 part, berikut ini daftar setiap part nya:

+ [Part 1 - Basic Sinatra](/2018/10/25/membuat-simple-crud-dengan-sinatra-dan-postgresql-part-1)
+ [Part 2 - Menghubungkan Sinatra ke Database Postgresql Menggunakan Active Record](/2018/10/27/aplikasi-crud-sederhana-menggunakan-sinatra-dan-postgresql-part-2)
+ [Part 3 - CRUD dan View](/2018/11/02/aplikasi-crud-sederhana-menggunakan-sinatra-dan-postgresql-part-3)
+ Part 4 - Push project ke heroku

Sebelum kita mulai belajar, pastikan struktur direktori projek aplikasi sinatra teman-teman sama seperti gambar di bawah ini ya. Kalau belum sama silahkan membaca kembali part-part sebelumnya, kemungkinan ada langkah yang terlewatkan.

![Struktur Direktori]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-01_22-36-21.png)

Untuk teman-teman yang belum memiliki akun heroku, teman-teman bisa mengklik link registrasi [disini](https://signup.heroku.com/login).

Kalau teman-teman sudah selesai registrasi akun heroku, kita bisa mulai belajarnya.

Pertama-tama teman-teman harus menginstall program [**heroku-cli**](https://devcenter.heroku.com/articles/heroku-cli#download-and-install) di komputer teman-teman, agar kita bisa menjalankan perintah-perintah heroku melalui terminal.

Kalau sudah terinstall teman-teman bisa mengeceknya dengan menggunakan perintah.

<pre>
  $ heroku -v
</pre>

Jika berhasil terinstall maka akan tampil seperti berikut.

![Struktur Direktori]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-02_05-57-13.png)

Ada beberapa persiapan yang perlu kita lakukan agar bisa mempublish aplikasi sinatra kita ke heroku.

Di heroku aplikasi ruby berbasis web dikenali sebagai aplikasi berbasis rack atau [rack based application](https://devcenter.heroku.com/articles/rack).

Untuk menjalankan aplikasi sinatra atau aplikasi berbasis rack di heroku, kita perlu membuat sebuah file bernama `config.ru`.

Pada root direktori project aplikasi sinatra kita, buatlah sebuah file baru bernama `config.ru`, kemudian tambahkan kode berikut ini

```ruby
# config.ru

require './app'

run Sinatra::Application
```

Kita dapat mencoba menjalankan aplikasi berbasis rack kita secara local dengan perintah berikut.

<pre>
  $ rackup -p 3000
</pre>

Maka akan tampil seperti berikut ini.

![Struktur Direktori]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-02_06-14-33.png)

Bisa dilihat bahwa output dari perintah tersebut terlihat mirip dengan output perintah berikut ini.

<pre>
  $ ruby app.rb -p 3000
</pre>

![Struktur Direktori]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-02_06-14-22.png)

Aplikasi sinatra kita bisa dijalankan dengan menggunakan perintah `ruby app.rb -p 3000` maupun `rackup -p 3000`, tetapi pada heroku kita akan menggunakan `rackup`.

Selanjutnya kita buat file baru bernama `Procfile`, file ini berisi perintah yang akan di eksekusi oleh heroku untuk menlajankan aplikasi kita.

```ruby
# Procfile

web: bundle exec rackup config.ru -p $PORT
```

Setelah itu pada terminal teman-teman jalankan perintah `heroku login`, untuk melakukan login ke service heroku melalui terminal. 

Ketika berhasil login kemudian jalankan perintah berikut ini untuk membuat sebuah app baru pada akun heroku teman-teman.

<pre>
  $ heroku create simple-crud-sinatra-postgresql
</pre>

`simple-crud-sinatra-postgresql` merupakan nama dari aplikasi sinatra kita di heroku. Jika berhasil maka akan tampil seperti gambar berikut.

![Struktur Direktori]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-02_06-33-37.png)

Kemudian kita commit project kita ke git, dengan menggunakan perintah berikut.

<pre>
  $ git add -A
  $ git commit -  m "Perisapan publish heroku"
</pre>

Seperti yang ditunjukkan oleh gambar berikut.

![Struktur Direktori]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-02_06-37-02.png)

Selanjutnya kita upload projek kita ke heroku dengan menggunakan perintah berikut.

<pre>
  $ git push heroku master
</pre>

Kita tunggu sampai aplikasi sinatra kita berhasil di upload ke heroku, seperti berikut.

<script id="asciicast-bQmvKiFwIBrK078Nf2yZsLztS" src="https://asciinema.org/a/bQmvKiFwIBrK078Nf2yZsLztS.js" async></script>

Ketika sudah berhasil di upload, teman-teman bisa mengakses alamat yang diberikan oleh heroku yakni `https://simple-crud-sinatra-postgresql.herokuapp.com/`. Kita juga bisa mengakses alamat tersebut dengan menggunakan perintah berikut.

<pre>
  $ heroku open
</pre>

Maka akan secara otomatis membuka browser dan mengakses alamat aplikasi sinatra kita yang berada di heroku, seperti gambar berikut.

![Live app]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-02_06-45-18.png)

Ketika kita mengakses path `/posts`, akan tampil `internal server error`. Ini terjadi karena database untuk aplikasi sinatra kita belum dibuat. Untuk membuat database kita menggunakan perintah berikut.

<pre>
  $ heroku run rake db:migrate
</pre>

Jika berhasil maka akan tampil seperti pada gambar dibawah ini.

![Live app]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-02_06-49-47.png)

Kemudian kita coba refresh halaman `/posts` sebelumnya, maka akan tampil tabel kosong, karena kita belum menambahkan post. Seperti gambar berikut ini.

![Live app]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-02_06-52-18.png)

Kita dapat menambahkan post dengan mengakses `/posts/new`. Pada input title kita ketikkan "Greeting" dan pada input content kita ketikkan "Hello World!", seperti pada gambar berikut ini.

![Live app]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-02_06-54-33.png)

Kemudian klik tombol `create post`, jika berhasil dibuat maka akan diredirect ke halaman `/posts`, seperti pada gambar berikut.

![Live app]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-02_06-54-41.png)

Selanjutnya kita coba menambahkan satu post lagi dengan title "Salam" dan content "Halo Dunia!". Maka ketika mengakses halaman `/posts` akan tampil seperti berikut ini.

![Live app]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-02_06-55-09.png)

Kita akan coba menghapus post pertama dengan mengklik tombol `delete`. Jika berhasil terhapus maka akan tampil seperti berikut ini.

![Live app]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-02_06-55-17.png)

Selanjutkan kita coba untuk mengedit post yang tersisa. Caranya, kita klik pada bagian title agar kita berpindah ke halaman detail post, kemudian kita klik tombol `edit`. Maka akan tampil sebagai berikut.

![Live app]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-02_07-03-26.png)

Kemudian klik tombol `edit post`, jika berhasil maka akan diredirect ke halaman `/posts/:id` dan akan tampil sebagai berikut.

![Live app]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-02_07-03-39.png)

Jika kita kembali ke halaman `/posts` akan tampil sebagai berikut.

![Live app]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-02_07-03-45.png)

Yeaayy, selamat teman-teman kita telah berhasil mempublish aplikasi sinatra kita ke heroku.

Terima kasih teman-teman yang sudah meluangkan waktunya untuk belajar bersama saya di seri tutorial membuat **Aplikasi CRUD Sederhana Menggunakan Sinatra dan Postgresql** ini, semoga bisa bermanfaat buat teman-teman. 

Jangan lupa dilike facebook fanpage blog ini [disini](https://www.facebook.com/achmiral.id), agar tidak ketinggalan tulisan-tulisan berikutnya.

Salam Rubyist!!

### Github Project
- https://github.com/achmiral/simple-crud-sinatra-postgresql
