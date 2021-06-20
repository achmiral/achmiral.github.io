---
layout: post
title: Aplikasi CRUD Sederhana Menggunakan Sinatra dan Postgresql [Part 3]
author: miral
categories: [ sinatra, ruby, activerecord, postgresql, tutorial ]
image: assets/images/sinatra-crud-postgres/page-3.png
image_external: false
featured: false
hidden: false
---

Halo teman-teman kembali lagi di tulisan saya tentang belajar membuat **Aplikasi CRUD Sederhana Menggunakan Sinatra dan Postgresql**.

Sebelumnya di [part 2](/2018/10/27/aplikasi-crud-sederhana-menggunakan-sinatra-dan-postgresql-part-2) kita belajar bagaimana mengubungkan aplikasi sinarta kita ke database postgresql menggunakan *activerecord*.

Di part 3 ini kita akan belajar membuat **Create Read Update Delete** pada aplikasi sinatra kita, beserta tampilan view nya masing-masing.

Sedekar informasi buat teman-teman yang baru berkunjung di blog ini. Tulisan ini terdiri dari 4 part, berikut ini daftar setiap part nya:

+ [Part 1 - Basic Sinatra](/2018/10/25/membuat-simple-crud-dengan-sinatra-dan-postgresql-part-1)
+ [Part 2 - Menghubungkan Sinatra ke Database Postgresql Menggunakan Active Record](/2018/10/27/aplikasi-crud-sederhana-menggunakan-sinatra-dan-postgresql-part-2)
+ Part 3 - CRUD dan View
+ [Part 4 - Push project ke heroku](/2018/11/09/aplikasi-crud-sederhana-menggunakan-sinatra-dan-postgresql-part-4-end)

Sebelum mulai, pastikan struktur project teman-teman seperti pada gambar dibawah ini.

![struktur project]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-10-27_09-05-42.png)

Pertama kita akan perlu merubah root route aplikasi sinatra kita menjadi sebagai berikut.

```ruby
# app.rb
require 'sinatra'
require "sinatra/activerecord"

require "./models/post"

get '/' do
  "Welcome to Sinatra App"
end

```

Kemudian jalankan aplikasi sinatra kita menggunakan perintah berikut.
<pre>
  $ ruby app.rb
</pre>

Ketika kita mengakses `http://localhost:4567` atau mengakses root aplikasi sinatra kita, maka akan tampil sebagai berikut.

![root route]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-01_19-50-00.png)

Kemudian kita buat *route* baru `/posts`, untuk menampilkan semua **post** yang ada di database. Buka file `app.rb`, lalu tambahkan kode berikut ini.


```ruby
# app.rb

...

get '/posts' do
  @posts = Post.all # Untuk mengambil seluruh data post yang ada di database

  erb :posts # fungsi untuk memanggil file views/posts.erb
end

```
Tanda `...` diatas adalah untuk mewakilkan baris-baris kode yang sebelumnya.

Kita akan menggunakan `erb` atau `embeded ruby` sebagai template engine untuk view pada aplikasi sinatra kita.

>`erb` (*Embeded ruby*) adalah sebuah template engine yang dapat kita gunakan ketika ingin menambahkan dan mengeksekusi kode-kode ruby pada view atau pada file HTML. Singkatnya, file `erb` tersebut terlebih dahulu diproses di server  untuk men-generate file HTML, kemudian file HTML tersebut akan dikirim ke client dan ditampilkan di browser.

Sinatra akan secara default mendeteksi direktori `views` sebagai direktori untuk menyimpan file-file view pada aplikasi sinatra kita.

Selanjutnya buatlah sebuah file baru bernama `posts.erb` di dalam direktori `views`, dan tambahkan kode berikut.

```erb
<!-- views/posts.erb -->

<table class="table">
  <thead>
    <tr>
      <th>Title</th>
      <th>Content</th>
    </tr>
  </thead>

  <tbody>
    <% @posts.each do |post| %>
      <tr>
        <td><%= post.title %></td>
        <td><%= post.content %></td>
      </tr>
    <% end %>
  </tbody>
</table>
```

Restart aplikasi sinatra kita dengan cara menekan `ctrl + c` pada terminal tempat kita menjalankan aplikasi sinatra kita, kemudian jalankan lagi perintah

<pre>
  $ ruby app.rb
</pre>

Setelah itu buka browser teman-teman dan akses `http://localhost:4567/posts`, akan tampil seperti pada gambar dibawah ini.

![posts route]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-01_20-03-06.png)

Kita akan menambahkan framework css [bootstrap](http://getbootstrap.com/) untuk mempercantik tampilan view aplikasi sinatra kita.

Untuk menambahkan bootstrap, kita perlu membuat sebuah file `layout.erb` pada direktori `views`. Nantinya file ini akan menjadi layout untuk setiap file views pada aplikasi kita.

Buatlah filebaru bernama `layout.erb`, tambahkan kode berikut ini.

```erb
<!-- views/layout.erb -->

<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

    <title>Sinatra App!</title>
  </head>
  <body>

    <div class="container">
      <%= yield %>
    </div>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
  </body>
</html>
```

Bisa dilihat pada tag `div.container` kita menambahkan syntax ruby `yield`, syntax ini akan menunjukkan lokasi tempat menyisipkan kode-kode yang berasal dari view.

Seletah itu, buka browser teman-teman dan akses kembali `http://localhost:4567/posts`, Maka akan tampil seperti gambar berikut.

![table bootstrap]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-01_20-32-41.png)

Selanjutnya kita akan menambahkan fungsi CREATE pada aplikasi sinatra kita. 

Untuk menambahkan fungsi CREATE kita memerlukan 2 route baru, yakni
- `/posts/new` dengan method `get`, untuk menampilkan form membuat post baru
- `/posts` dengan method `post`, untuk melakukan proses insert ke database

Buka file `app.rb` dan tambahkan kode berikut.
```ruby
# app.rb

...

get '/posts/new' do
  @post = Post.new # Membuat sebuah objek post baru

  erb :new_post # memanggil file view new_post.erb
end

post '/posts' do
  @post = Post.new(params[:post]) # Membuat objek @post dengan atribut yang di peroleh dari form input new_post.erb

  if @post.save
    redirect '/posts'
  else
    erb :new_post
  end
end
```

Pada kode diatas kita membutuhkan sebuah file view baru bernama `new_post.erb`. Buatlah sebuah file baru bernama `new_post.erb` pada direkroti `views` dan tambahkan kode berikut ini.

```erb
<!-- views/new_post.erb -->

<h1>New Post</h1>

<form action="/posts" method="post">
  <div class="form-group">
    <label for="title">Title</label>
    <input type="text" name="post[title]" class="form-control" id="title" placeholder="Title">
  </div>
  <div class="form-group">
    <label for="content">Content</label>
    <textarea name="post[content]" id="content" class="form-control" cols="30" rows="3" placeholder="Content"></textarea>
  </div>
  <button type="submit" class="btn btn-primary btn-sm">Create Post</button>
  <a href="/posts" class="btn btn-danger btn-sm">Back</a>
</form>
```

Jika diperhatikan pada attribut `name` pada input field title bernilai `post[title]` dan  pada input field content bernilai `post[content]`. Nilai ini merupakan konvensi dari `erb` agar data dari form yang diinputkan akan menjadi sebuah data `hash`. Misalnya ketika kita menginputkan "**Greeting**" pada input field title dan "**Hello World!**" pada input field content, akan menjadi seperti berikut ini.

```ruby
post = { title: "Greeting", content: "Hello World!" }

post["title"] # => "Greeting"
post["content"] # => "Hello World!"
```

Selanjutnya jangan lupa restart aplikasi sinatra teman-teman, kemudian buka browser dan akses `http://localhost:4567/posts/new`. Dan inputkan title dan content sesuai keinginan teman-teman, dalam contoh ini saya menginputkan "Salam" dan "Halo Dunia!".

![new post]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-01_21-09-06.png)

Kemudian klik button `Create Post`, jika berhasil maka akan di redirect ke halaman `/posts`. Seperti pada gambar dibawah ini.

![new post]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-01_21-10-32.png)

Selanjutnya kita akan menambahkan fungsi READ pada aplikasi sinatra kita. Route yang dibutukan untuk fungsi ini adalah `/posts/:id` dengan method `get`, dimana `:id` adalah id dari post yang akan kita read dari database.

Untuk menambahkan fungsi READ, buka file `app.rb` kemudian tambahkan kode berikut ini.

```ruby
# app.rb

...

get '/posts/:id' do
  @post = Post.find(params[:id])

  erb :post_detail
end
```

Kemudian kita buat sebuah file view baru bernama `post_detail.erb` pada direktori views dan tambahkan kode berikut ini.

```erb
<!-- views/post_detail.erb -->

<h1><%= @post.title %></h1>
<hr>
<p>
  <%= @post.content %>
</p>

<a href="/posts/<%= @post.id %>/edit" class="btn btn-sm btn-primary">Edit</a>
<a href="/posts" class="btn btn-sm btn-danger">Back</a>
```

Kemudian kita modifikasi view `posts.erb`, kita tambahkan link untuk menuju ke halaman post detail, seperti berikut ini.


```erb
<!-- views/posts.erb -->

...
    <% @posts.each do |post| %>
      <tr>
        <td>
          <a href="/posts/<%= post.id %>">
            <%= post.title %>
          </a>
        </td>
        <td><%= post.content %></td>
      </tr>
    <% end %>
...
```
Kemudian buka browser teman-teman dan akses `http://localhost:4567/posts`, akan tampil seperti pada gambar berikut.

![list post new]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-01_21-44-07.png)

Teman-teman coba klik pada bagian title salah satu post. Maka akan tampil seperti gambar berikut ini.

![list post new]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-01_21-41-36.png)


Selanjutnya kita akan menambahkan fungsi UPDATE pada aplikasi sinatra kita.

Hampir sama seperti pada fungsi CREATE, kita membutuhkan 2 route baru, yakni
- `/posts/:id/edit` dengan method `get` untuk menampilkan form edit post
- `/posts/:id` dengan method `put` untuk memproses update post ke database

Buka file `app.rb` kemudian tambahkan kode berikut ini.

```ruby
# app.rb

...

get '/posts/:id/edit' do
  @post = Post.find(params[:id])

  erb :post_edit
end

put '/posts/:id' do
  @post = Post.find(params[:id])

  if @post.update(params[:post])
    redirect "/posts/#{@post.id}"
  else
    erb :post_edit
  end
end
```

Kemudian kita buat sebuah file view baru bernama `post_edit.erb` pada direktori `views` dan tambahkan kode berikut ini.

```erb
<!-- views/post_edit.erb -->

<h1>Edit Post</h1>

<form action="/posts/<%= @post.id %>" method="post">
  <input type="hidden" name="_method" value="put"/>
  <div class="form-group">
    <label for="title">Title</label>
    <input type="text" name="post[title]" class="form-control" id="title" placeholder="Title" value="<%= @post.title %>">
  </div>
  <div class="form-group">
    <label for="content">Content</label>
    <textarea name="post[content]" id="content" class="form-control" cols="30" rows="3" placeholder="Content"><%= @post.content %></textarea>
  </div>
  <button type="submit" class="btn btn-primary btn-sm">Edit Post</button>
  <a href="/posts" class="btn btn-danger btn-sm">Back</a>
</form>
```

Seperti biasa jangan lupa restart aplikasi sinatra teman-teman setiap kali melakukan perubahan pada file `app.rb`. 

Kemudian buka browser teman-teman dan akses `http://localhost:4567/posts`, lalu klik salah title salah satu post, kemudian klik tombol `edit post`. Maka akan tampil form seperti dibawah ini. Kita akan merubah content menjadi **Hello Dunia!**.

![edit post form]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-01_21-52-53.png)

Ketika proses edit berhasil maka akan tampil halam detail post seperti pada gambar dibawah ini, 

![edit post form]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-01_21-53-03.png)

Selanjutnya kita akan menambahkan fungsi terakhir yakni DELETE.

Untuk fungsi DELETE kita hanya memerlukan satu route baru yakni `/posts/:id` dengan method `delete`.

Buka file `app.rb` dan tambahkan kode berikut ini.

```ruby
# app.rb
...
delete '/posts/:id' do
  @post = Post.find(params[:id])
  @post.destroy
  redirect "/posts"
end
```

Kemudian kita modifikasi file `posts.erb`, kita akan menambahkan kolom baru yang berisi tombol `delete`.

Buka file `posts.erb` dan ubahlah menjadi seperti dibawah ini.

```erb
<!-- views/posts.erb -->
...
        <td>
          <a href="/posts/<%= post.id %>">
            <%= post.title %>
          </a>
        </td>
        <td><%= post.content %></td>
        <td>
          <form action="/posts/<%= post.id %>" method="post">
            <input type="submit" name="_method" value="delete" class="btn btn-xs btn-danger">
          </form>
        </td>
...
```

Kemudian buka browser teman-teman dan akses `http://localhost:4567/posts` maka akan tampil seperti berikut ini.

![Post list]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-01_22-07-22.png)

Cobalah untuk mengklik salah satu tombol delete, ketika berhasil di hapus maka akan di redirect ke tampilan berikut ini.

![Post list]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-01_22-07-32.png)

Yeaay, selamat kita berhasil menambahkan fungsi CRUD beserta view pada aplikasi sinatra kita.

Sebelum lanjut ke part berikutnya, pastikan struktur folder project teman-teman sama seperti gambar berikut ini.

![Post list]({{site.url}}/assets/images/sinatra-crud-postgres/Screenshot_2018-11-01_22-36-21.png)

Ditulisan berikutnya kita akan belajar bagaimana mempublish aplikasi sinatra kita ke heroku.

Terima kasih sudah meluangkan waktunya untuk membaca tulisan saya ini.

Salam Rubyist!!