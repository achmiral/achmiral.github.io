---
layout: post
title: Tingkatkan Kecepatan Navigasi Blog Anda Dengan Turbolinks
author: miral
categories: [ jekyll, turbolinks, tutorial ]
image: assets/images/tubolinks-jekyll/turbolinks-jekyll.png
image_external: false
featured: true
hidden: true
---

Halo teman-teman, kali ini saya ingin berbagi tutorial mengenai update terbaru pada blog ini. Pada beberapa waktu yang lalu saya menambahkan **Turbolinks** pada blog ini.

[Turbolinks](https://github.com/turbolinks/turbolinks) adalah pustaka Javascript yang digunakan untuk meningkatkan performa navigasi pada Website / Blog Anda layaknya _Single Page Application (SPA)_. Versi terbaru turbolinks adalah `5.2.0` (ketika tulisan ini dibuat).

> Tutorial ini dibuat untuk teman-teman yang menggunakan [jekyll](https://jekyllrb.com/).

#### Langkah - langkah:

##### 1. Download Turbolinks Versi Terbaru
Download Turbolinks Versi Terbaru pada link berikut ini [Turbolinks v5.2.0](https://github.com/turbolinks/turbolinks/archive/v5.2.0.zip).

##### 2. Tambahkan Turbolinks ke folder assets
Ekstrak dan copy file `turbolinks.js` yang terdapat pada folder `dist/turbolinks.js`, ke folder `assets/js/turbolinks.js`

##### 3. Tambahkan script tag
Tambahkan script tag pada file `_layouts/default.html`, di dalam tag `<head></head>`

```html
{% raw %}
<script src="{{ site.baseurl }}/assets/js/turbolinks.js" type="text/javascript" charset="utf-8">
</script>
{% endraw %}
```

##### 4. Modifikasi file JS
Lakukan modifikasi pada kode javascript yang disediakan oleh template yang Anda gunakan seperti berikut ini. Pada blog ini menggunakan template [*Mediumish*](https://github.com/wowthemesnet/mediumish-theme-jekyll), jadi yang modif adalah file `assets/js/mediumish.js`

```javascript
// assets/js/mediumish.js

// Before
jQuery(document).ready(function() {
  // mediumish js code
});

// After
var ready = function() {
  // mediumish js code
}

jQuery(document).ready(ready);
jQuery(document).on("turbolinks:load", ready);
```

##### 4. Done!
Selesai, saatnya deploy ke github pages :grinning:

Terima kasih untuk teman-teman yang sudah meluangkan waktunya untuk membaca tulisan ini, semoga bisa bermanfaat. Salam Rubyist!! :smile: :smile: :smile:

--------

#### Referensi:
- https://github.com/turbolinks/turbolinks
- https://blog.appsignal.com/2018/05/23/speeding-up-your-apps-navigation-with-turbolinks.html
- http://patrickoscity.de/blog/turbolinks-with-jekyll