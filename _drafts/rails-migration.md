---
layout: post
title: Migrasi Database pada Rails
author: Miral Achmed
---

Ketika mendengar kata **migrasi** mungkin yang terbayang adalah sekelompok burung
yang terbang dari utara menuju ke belahan bumi selatan pada musim dingin :smile:.

![Bird Migration](https://ericasodos.files.wordpress.com/2012/01/migration1.jpg)

Bukan...bukan...

Migrasi yang dibahas kali ini adalah migrasi database atau lebih tepatnya migrasi skema database.
Jadi yang dimigrasi itu **skema** atau **struktur** databasenya.

Untuk lebih memahami tentang skema database, saya akan memberikan contoh tentang
apa itu skema database?.

Misalnya kita mempunyai sebuah database dengan 1 tabel **Users**, dengan struktur
tabelnya seperti dibawah ini

 # | Name          | Type  | NULL | Extra
 - | - | - | - | -
 1 | id | int(11) | NO | AUTO_INCREMENT
 2 | email  | varchar(255) | NO |  
 3 | name | varchar(255) | NO |
 4 | Address | text | yes |
 5 | phones | varchar(15) | |