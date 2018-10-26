---
layout: post
title:  "Berkenalan dengan Docker"
author: miral
categories: [ Docker, tutorial ]
image: https://images.unsplash.com/photo-1535986437535-2417b0f5947f?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=daf6d2858bfaef8340283cea3c67073b&auto=format&fit=crop&w=750&q=80
image_external: true
featured: false
hidden: false
---

Selamat malam teman-teman. Kali ini saya ingin share ilmu yang baru saja saya pelajari yaitu [Docker](http://docker.com). Pertama kali saya mengenal docker adalah ketika saya mengikuti event [Docker Global Mentor Week - Yogyakarta](https://www.meetup.com/Docker-Indonesia/events/235327661/) yang diselegarakan oleh [Docker Indonesia](https://www.meetup.com/Docker-Indonesia)
di kampus STMIK AKAKOM Yogyakarta. Poster event-nya ada dibawah ini.

{% include image.html
    img="https://a248.e.akamai.net/secure.meetupstatic.com/photos/event/b/0/5/5/600_455865141.jpeg"
    title="Docker Global Mentor Week - Yogyakarta"
    caption="Docker Global Mentor Week - Yogyakarta"
    url="https://a248.e.akamai.net/secure.meetupstatic.com/photos/event/b/0/5/5/600_455865141.jpeg" %}


### Apa itu Docker?
Docker merupakan sebuah platform yang dibangun berdasarkan teknologi container.

{% include image.html
    img="https://upload.wikimedia.org/wikipedia/commons/d/df/Container_01_KMJ.jpg"
    title="container"
    caption="Container"
    url="https://upload.wikimedia.org/wikipedia/commons/d/df/Container_01_KMJ.jpg" %}

<!-- ![container](https://upload.wikimedia.org/wikipedia/commons/d/df/Container_01_KMJ.jpg)
*Coba* -->

Tentunya bentuknya bukan seperti container yang di atas, tapi secara fungsi hampir sama.

### Box Kontainer?
Misalnya kita ingin mengirim beberapa barang dengan jumlah yang banyak ke luar kota atau ke luar negeri. Sebelum melakukan pengiriman, barang-barang tersebut perlu kita packing atau perlu kita simpan ke dalam tempat yang aman agar barang-barang tersebut tidak rusak ketika proses pengiriman.

Misalnya saja proses pengirimannya dari rumah kita sampai ke tempat tujuan adalah sebagai berikut dari rumah kita, barangnya diantar menggunakan mobil menuju stasiun kereta, kemudian dari stasiun kereta, barangnya diantar menggunakan kereta menuju ke pelabuhan, setibanya di pelabuhan barang tersebut kemudian di angkut ke kapal yang nantinya akan diantarkan ke kota / negara tujuan.

Dengan proses pengiriman yang panjang dan dengan kendaraan pengangkut yang berbeda-beda maka kemungkinan terjadinya kerusakan barang akan semakin besar. Untuk mengatasi masalah tersebut, kita bisa menggunakan container sebagai box pengiriman.

Jika menggunakan box kontainer maka proses pengirimannya akan menjadi lebih mudah. Proses pengirimannya sebagai berikut dari rumah kita barang-barang tersebut akan dimasukkan ke dalam box kontainer, kemudian barang-barang tersebut akan diantar oleh truk kontainer menuju ke stasiun, sesampainya di stasiun kemudian barang-barang tersebut diangkut dan diantar menggunakan kereta kontainer ke pelabuhan, dan setibanya di pelabuhan akan di angkut menggunakan kapal kontainer.

### Docker Container?
Gambaran cara kerja container pada Docker hampir sama seperti kontainer pada pengiriman barang-barang yang telah dijelaskan sebelumnya. Kita anggap barang-barang tersebut terdiri dari aplikasi [aplikasi rails], web server[apache/nginx], dan database server [mysql/postgres]. Dan aplikasi tersebut ingin kita deploy ke production server.

Aplikasi yang kita bangun tentunya membutuhkan banyak dependency library agar bisa running dengan lancar. Sehingga kita perlu menginstall dependency library pada laptop kita juga pada production server . Akan sangat melelahkan jika kita perlu melakukan konfigurasi server agar memiliki konfigurasi yang sama dengan laptop kita ataupun sebaliknya.


Namun, dengan menggunakan docker container masalah tersebut bisa teratasi karena ketika kita membuat sebuah kontainer dari aplikasi yang sedang kita develop maka dependency library yang dibutuhkan oleh aplikasi tersebut ikut masuk ke dalam kontainer. Sehingga kita hanya perlu melakukan sekali konfigurasi agar aplikasi kita bisa running dengan lancar di production server.

Mungkin ini yang dapat saya share untuk kali ini. Terima kasih untuk teman-teman yang sudah meluangkan waktunya untuk membaca tulisan ini, semoga bisa bermanfaat buat teman-teman yang ingin belajar tentang docker :smile: :smile: :smile:.

Jika teman-teman ingin bergabung dan mendapatkan info event-event yang akan di adakan oleh Docker Indonesia, bisa langsung join di meetup Docker indonesia di [sini](https://www.meetup.com/Docker-Indonesia/), atau bisa join di group facebook [Docker.ID](https://telegram.me/dockerid) atau di Group Telegram [Docker.id](https://telegram.me/dockerid).
