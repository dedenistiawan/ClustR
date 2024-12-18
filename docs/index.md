---
title: "Analisis Cluster dengan R: Panduan Lengkap untuk Pemula"
cover-image: "images/cover.png"
author: "Deden Istiawan"
date: "2024-12-18"
site: bookdown::bookdown_site
output: 
  bookdown::gitbook:
    config:
      toc:
        collapse: subsection
        scroll_highlight: yes
      fontsettings:
        theme: white
        family: serif
        size: 2
    split_by: section+number
    highlight: tango
    includes:
      in_header: [header_include.html]
      before_body: open_review_block.html
  bookdown::pdf_book:
    pandoc_args: [ "--csl", "apa-old-doi-prefix.csl"]
    includes:
      in_header: preamble.tex
    citation_package: natbib
    keep_tex: yes
always_allow_html: yes
documentclass: book
classoption: oneside
geometry: "left=3cm,right=3cm,top=3cm,bottom=3cm"
bibliography: [book.bib, packages.bib]
biblio-style: apalike
biblatexoptions:
  - sortcites
link-citations: yes
github-repo: "dedenistiawan/Analisis_Cluster_R"
description: "Buku tentang analisis cluster dengan R adalah buku yang membahas tentang teknik analisis data yang digunakan untuk mengelompokkan objek atau data ke dalam kelompok-kelompok yang serupa. Buku ini biasanya membahas tentang konsep dasar analisis cluster."
url: 'https://github.com/dedenistiawan/ClustR'
tags: [Tutorial, Analisis Cluster, Unsupervised Learning, R Programming, Textbook]
editor_options: 
  markdown: 
    wrap: 72
---

# Kata Pengantar {.unnumbered}












<hr style="background-color:#3C6690;height:2px">

<center><img src="images/cover.png" style="width:60%;"/></center>

<br> Rekayasa Perangkat Lunak
<img src="images/itesa.png" style="float: right; margin: 0px 100px 0px 0px; width:35%"/>
<br> Fakultas Sains dan Teknologi <br> Institut Teknologi Statistika dan
Bisnis Muhammadiyah <br> Semarang, Indonesia <br>
<a href=\"mailto:deden.istiawan@itesa.ac.id?subject=Clustering%20with%20R\">[deden.istiawan\@itesa.ac.id](mailto:deden.istiawan@itesa.ac.id){.email}.</a>
<br><br>
Last updated on Wednesday, December 18, 2024.
<br> <br>
<iframe src="https://www.facebook.com/plugins/like.php?href=https%3A%2F%2Fwww.facebook.com%2FEconometricsWithR%2F&width=450&layout=standard&action=like&size=small&show_faces=true&share=true&height=80&appId" width="400" height="70" style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowTransparency="true" allow="encrypted-media" align="left"></iframe>
<br> <br> <br>

<hr style="background-color:#3C6690;height:2px">

Analisis cluster merupakan teknik yang sangat penting dalam bidang data
science, karena kemampuannya untuk mengelompokkan data berdasarkan
kesamaan karakteristik. Dengan mengelompokkan objek atau data, analisis
cluster membantu mengidentifikasi pola yang mungkin tidak terlihat
secara langsung dalam data mentah. Hal ini sangat berguna di berbagai
bidang, seperti pemasaran, biologi, dan pengenalan pola, di mana
pemahaman yang lebih dalam tentang struktur data dapat memberikan
wawasan yang berharga [@kaufman:clustering1990].

Salah satu manfaat utama dari analisis cluster adalah segmentasi pasar.
Dalam dunia bisnis, perusahaan dapat menggunakan teknik ini untuk
mengelompokkan pelanggan berdasarkan perilaku atau karakteristik
tertentu. Dengan memahami segmen-segmen ini, perusahaan dapat merancang
strategi pemasaran yang lebih efektif dan personalisasi produk untuk
memenuhi kebutuhan spesifik dari setiap kelompok. Selain itu, analisis
cluster juga memungkinkan pengelompokan data yang besar menjadi lebih
mudah dipahami dan diinterpretasikan, sehingga memfasilitasi pengambilan
keputusan yang lebih baik [@han2012mining].

Dalam konteks machine learning, analisis cluster sering digunakan
sebagai metode unsupervised learning. Ini berarti bahwa algoritma
clustering dapat menemukan struktur dalam data tanpa memerlukan label
atau kategori sebelumnya. Hal ini sangat berguna ketika menghadapi
dataset yang tidak terstruktur dan kompleks, di mana tujuan utamanya
adalah untuk mengeksplorasi dan mendapatkan wawasan awal tentang data
tersebut [@jain2010].

Secara keseluruhan, analisis cluster tidak hanya membantu dalam
pengelompokan data tetapi juga berfungsi sebagai alat eksplorasi yang
kuat dalam memahami hubungan dan pola dalam dataset. Dengan demikian,
penerapan analisis cluster dapat meningkatkan kualitas analisis data dan
mendukung pengambilan keputusan berbasis data yang lebih baik di
berbagai sektor industri .


#### Acknowledgement {.unnumbered}

Saya ingin mengucapkan terima kasih kepada keluarga, teman, dan rekan kerja yang telah mendukung saya dalam menyelesaikan buku ini. Terima kasih atas cinta, dukungan, dan motivasi yang telah Anda berikan

<br>
![Creative Commons License](https://mirrors.creativecommons.org/presskit/buttons/88x31/svg/by-nc-sa.eu.svg)

This book is licensed under the [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-nc-sa/4.0/).

# Pendahuluan

<hr style="background-color:#3C6690;height:2px">

Minat terhadap bahasa pemrograman statistik dan lingkungan perangkat lunak <tt>R</tt>[@R-base] yang tersedia secara gratis terus meningkat pesat. Pada saat kami mulai menyusun draf awal untuk proyek ini, lebih dari 11.000 add-on (banyak di antaranya menyediakan metode terkini) telah tersedia di Comprehensive <tt>R</tt> Archive Network ([CRAN](https://cran.r-project.org/)), sebuah jaringan luas server FTP di seluruh dunia yang menyimpan versi kode <tt>R</tt> dan dokumentasinya yang identik serta terkini. Dalam banyak bidang penelitian statistik terapan, <tt>R</tt> mendominasi dibandingkan perangkat lunak statistik lainnya, termasuk yang bersifat komersial. Keunggulan <tt>R</tt> sebagai perangkat lunak sumber terbuka yang tersedia secara gratis, ditambah dengan komunitas pengguna yang besar dan terus berkembang yang berkontribusi pada CRAN, membuat <tt>R</tt> semakin menarik bagi peneliti di berbagai disiplin ilmu, termasuk statistik, ekonomi, dan teknik.

Salah satu keuntungan utama menggunakan <tt>R</tt> dalam analisis data adalah kemampuannya untuk mendokumentasikan setiap langkah analisis secara eksplisit sehingga mudah untuk diperbarui dan diperluas. Hal ini memungkinkan pengguna untuk menggunakan kembali kode untuk aplikasi serupa dengan data yang berbeda. Selain itu, program <tt>R</tt>sepenuhnya dapat direproduksi, yang membuat hasil analisis mudah dipahami dan divalidasi oleh pihak lain.

Selama beberapa tahun terakhir, <tt>R</tt> telah menjadi bagian integral dari kurikulum mata kuliah analisis data dan statistika yang kami ajarkan di berbagai universitas. Dalam konteks pembelajaran, mempelajari pemrograman <tt>R</tt> sering kali dianggap sebanding dengan mempelajari bahasa asing, di mana praktik yang berkelanjutan sangat penting untuk keberhasilan belajar. Namun, hanya menampilkan kode R mentah pada slide presentasi tidak cukup untuk mendorong mahasiswa berinteraksi langsung dengan materi pembelajaran. Oleh karena itu, <tt>R</tt> sangat penting untuk memberikan pengalaman belajar yang lebih mendalam dan interaktif.


Dalam hal referensi literatur, sudah ada beberapa buku luar biasa yang membahas penggunaan <tt>R</tt> dan penerapannya, seperti *An Introduction to Statistical Learning* (James et al., 2013). Namun, banyak sumber tersebut mungkin terlalu kompleks untuk mahasiswa pemula yang baru memulai belajar statistik atau memiliki sedikit pengalaman pemrograman. Untuk menjawab tantangan ini, kami mulai menyusun koleksi panduan yang dapat direproduksi untuk digunakan dalam kelas. Panduan ini memberikan arahan tentang bagaimana menerapkan berbagai metode analisis klaster yang diambil dari literatur statistik dengan menggunakan <tt>R</tt> sebagai alat utama. Proses ini sangat terbantu oleh paket-paket R seperti `knitr` dan `rmarkdown` yang memungkinkan pembuatan laporan dinamis dengan mengintegrasikan teks, kode <tt>R</tt>, dan hasil output dalam berbagai format, termasuk PDF dan HTML.

Selain itu, paket `bookdown` telah menjadi alat utama kami dalam proyek ini. Paket ini dibangun di atas `rmarkdown` dan memungkinkan kami untuk membuat dokumen yang menarik secara visual, seperti halaman web interaktif. Dengan dukungan perangkat ini, kami menyusun sebuah buku berjudul *Analisis Cluster dengan R: Panduan Lengkap untuk Pemula*. Buku ini dirancang sebagai skrip interaktif dalam gaya laporan penelitian yang dapat direproduksi, dengan tujuan menyediakan pengaturan pembelajaran elektronik yang platform-independen dengan mengintegrasikan pengetahuan teoretis dan keterampilan empiris dalam analisis data.

Proyek ini bukanlah buku teks analisis klaster yang komprehensif atau pengenalan umum tentang <tt>R</tt>. Fokus kami adalah memberikan panduan praktis tentang bagaimana metode analisis klaster dapat diterapkan menggunakan <tt>R</tt>, tanpa terlalu banyak membahas derivasi matematis atau bukti formal. Tujuan kami adalah memungkinkan pembaca tidak hanya mereplikasi hasil analisis kasus menggunakan <tt>R</tt> tetapi juga memperkuat kemampuan mereka untuk menerapkan keterampilan baru tersebut pada aplikasi empiris lainnya.

Setiap bab dalam buku ini mencakup latihan pemrograman <tt>R</tt> interaktif. Latihan ini dirancang sebagai pelengkap potongan kode yang menampilkan implementasi teknik-teknik yang telah dibahas. Latihan-latihan ini dibuat menggunakan [DataCamp light widget](https://github.com/datacamp/datacamp-light) yang terhubung dengan sesi <tt>R</tt> yang dikelola di server [DataCamp](https://www.datacamp.com/home). Dengan pendekatan ini, pembaca dapat langsung mencoba dan bereksperimen dengan latihan yang disediakan untuk memperdalam pemahaman mereka terhadap metode yang dipelajari. Dengan cara ini, kami berharap dapat memberikan pengalaman belajar yang menyeluruh dan menarik bagi pembaca yang ingin mendalami analisis klaster menggunakan <tt>R</tt>.

<iframe src="DCL/intro_1.html" frameborder="0" scrolling="no" style="width:100%;height:360px">

</iframe>

Widget ini terdiri dari dua tab. Tab <tt>script.R</tt> menyerupai file dengan format <tt>.R</tt>, format file yang umum digunakan untuk menyimpan kode <tt>R</tt>. Baris yang diawali dengan tanda \# adalah komentar, yang tidak dianggap sebagai kode oleh <tt>R</tt>. Selain itu, tab script.R bekerja seperti lembar latihan di mana Anda dapat menuliskan solusi yang Anda buat. Jika Anda menekan tombol *Run*, kode akan dijalankan, pengujian kebenaran solusi dilakukan, dan Anda akan diberi tahu apakah pendekatan Anda benar. Jika tidak benar, Anda akan menerima umpan balik yang memberikan saran perbaikan atau petunjuk. Tab lainnya, <tt>R Console</tt>, adalah konsol <tt>R</tt> yang sepenuhnya berfungsi yang dapat digunakan untuk mencoba solusi sebelum mengirimkannya. Tentu saja, Anda dapat mengirimkan hampir semua kode <tt>R</tt> dan menggunakan konsol untuk bereksperimen dan mengeksplorasi. Cukup ketikkan perintah dan tekan tombol *Enter* pada keyboard Anda.

Pada konsol, Anda akan melihat simbol <tt>\></tt> di panel kanan (konsol). Simbol ini disebut "prompt" dan menunjukkan bahwa pengguna dapat memasukkan kode yang akan dijalankan. Untuk menghindari kebingungan, kami tidak akan menampilkan simbol ini di buku ini. Output yang dihasilkan oleh kode R dikomentari dengan <tt>#\></tt>.

Biasanya, kami menampilkan kode <tt>R</tt> bersama dengan output yang dihasilkan dalam potongan kode. Sebagai contoh, perhatikan baris kode berikut yang ditampilkan dalam potongan di bawah ini. Kode ini memberi tahu <tt>R</tt> untuk menghitung jumlah paket yang tersedia di <tt>CRAN</tt>. Potongan kode diikuti oleh output yang dihasilkan.



``` r
# check the number of R packages available on CRAN
nrow(available.packages(repos = "http://cran.us.r-project.org"))
#> [1] 0
```

Setiap potongan kode dilengkapi dengan tombol di sisi kanan luar yang memungkinkan Anda menyalin kode ke clipboard Anda. Ini membuat pekerjaan dengan segmen kode yang lebih besar menjadi lebih nyaman, baik di versi <tt>R</tt>/*RStudio* Anda maupun di widget-widget yang disajikan di sepanjang buku ini. Pada widget di atas, Anda dapat mengklik tab <tt>R Console</tt> Console dan mengetikkan `nrow(available.packages(repos = "http://cran.us.r-project.org"))` (perintah dari potongan kode di atas) dan menjalankannya dengan menekan tombol *Enter* pada keyboard Anda. [^index-1]

[^index-1]: The <tt>R</tt> session is initialized by clicking into
    the widget. This might take a few seconds. Just wait for the
    indicator next to the button *Run* to turn green.

Perhatikan bahwa beberapa baris dalam widget tersebut dikomentari, yang meminta Anda untuk menetapkan nilai numerik pada sebuah variabel dan kemudian mencetak isi variabel tersebut ke konsol. Anda dapat memasukkan pendekatan solusi Anda ke dalam <tt>script.R</tt> dan menekan tombol *Run* untuk mendapatkan umpan balik seperti yang dijelaskan di atas. Jika Anda tidak tahu bagaimana menyelesaikan latihan ini (jangan panik, itu mungkin alasan mengapa Anda membaca ini), klik *Hint* untuk mendapatkan saran. Jika Anda masih belum menemukan solusi, klik *Solution* untuk membuka tab lain, <tt>Solution.R</tt>, yang berisi kode solusi sampel. Seringkali, latihan dapat diselesaikan dengan berbagai cara, dan <tt>Solution.R</tt> akan menyajikan solusi yang kami anggap sebagai solusi yang mudah dipahami dan idiomatik.

## Kolofon

Buku ini disusun dengan:


```
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.4.0 (2024-04-24 ucrt)
#>  os       Windows 11 x64 (build 22631)
#>  system   x86_64, mingw32
#>  ui       RTerm
#>  language (EN)
#>  collate  English_Indonesia.utf8
#>  ctype    English_Indonesia.utf8
#>  tz       Asia/Jakarta
#>  date     2024-12-18
#>  pandoc   3.2 @ C:/Program Files/RStudio/resources/app/bin/quarto/bin/tools/ (via rmarkdown)
#> 
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package        * version    date (UTC) lib source
#>  abind            1.4-8      2024-09-12 [1] CRAN (R 4.4.1)
#>  AER              1.2-14     2024-09-28 [1] CRAN (R 4.4.2)
#>  askpass          1.2.0      2023-09-03 [1] CRAN (R 4.4.0)
#>  backports        1.5.0      2024-05-23 [1] CRAN (R 4.4.0)
#>  base64enc        0.1-3      2015-07-28 [1] CRAN (R 4.4.0)
#>  bdsmatrix        1.3-7      2024-03-02 [1] CRAN (R 4.4.0)
#>  bit              4.5.0      2024-09-20 [1] CRAN (R 4.4.1)
#>  bit64            4.5.2      2024-09-22 [1] CRAN (R 4.4.1)
#>  bitops           1.0-9      2024-10-03 [1] CRAN (R 4.4.1)
#>  blob             1.2.4      2023-03-17 [1] CRAN (R 4.4.2)
#>  bookdown         0.39       2024-04-15 [1] CRAN (R 4.4.0)
#>  boot             1.3-30     2024-02-26 [2] CRAN (R 4.4.0)
#>  broom            1.0.7      2024-09-26 [1] CRAN (R 4.4.1)
#>  bslib            0.7.0      2024-03-29 [1] CRAN (R 4.4.0)
#>  cachem           1.1.0      2024-05-16 [1] CRAN (R 4.4.0)
#>  callr            3.7.6      2024-03-25 [1] CRAN (R 4.4.2)
#>  car              3.1-3      2024-09-27 [1] CRAN (R 4.4.1)
#>  carData          3.0-5      2022-01-06 [1] CRAN (R 4.4.1)
#>  cellranger       1.1.0      2016-07-27 [1] CRAN (R 4.4.0)
#>  cli              3.6.2      2023-12-11 [1] CRAN (R 4.4.0)
#>  clipr            0.8.0      2022-02-22 [1] CRAN (R 4.4.0)
#>  collapse         2.0.18     2024-11-23 [1] CRAN (R 4.4.2)
#>  colorspace       2.1-0      2023-01-23 [1] CRAN (R 4.4.0)
#>  conflicted       1.2.0      2023-02-01 [1] CRAN (R 4.4.2)
#>  cowplot          1.1.3      2024-01-22 [1] CRAN (R 4.4.1)
#>  cpp11            0.5.0      2024-08-27 [1] CRAN (R 4.4.1)
#>  crayon           1.5.2      2022-09-29 [1] CRAN (R 4.4.0)
#>  cubature         2.1.1      2024-07-14 [1] CRAN (R 4.4.2)
#>  curl             6.0.1      2024-11-14 [1] CRAN (R 4.4.2)
#>  cvar             0.5        2022-11-03 [1] CRAN (R 4.4.2)
#>  data.table       1.15.4     2024-03-30 [1] CRAN (R 4.4.0)
#>  DBI              1.2.3      2024-06-02 [1] CRAN (R 4.4.2)
#>  dbplyr           2.5.0      2024-03-19 [1] CRAN (R 4.4.2)
#>  Deriv            4.1.6      2024-09-13 [1] CRAN (R 4.4.1)
#>  digest           0.6.35     2024-03-11 [1] CRAN (R 4.4.0)
#>  doBy             4.6.24     2024-10-07 [1] CRAN (R 4.4.1)
#>  dplyr            1.1.4      2023-11-17 [1] CRAN (R 4.4.0)
#>  dtplyr           1.3.1      2023-03-22 [1] CRAN (R 4.4.2)
#>  dynlm            0.3-6      2019-01-06 [1] CRAN (R 4.4.2)
#>  evaluate         1.0.1      2024-10-10 [1] CRAN (R 4.4.2)
#>  fansi            1.0.6      2023-12-08 [1] CRAN (R 4.4.0)
#>  farver           2.1.2      2024-05-13 [1] CRAN (R 4.4.0)
#>  fastICA          1.2-7      2024-12-11 [1] CRAN (R 4.4.0)
#>  fastmap          1.2.0      2024-05-15 [1] CRAN (R 4.4.0)
#>  fBasics          4041.97    2024-08-19 [1] CRAN (R 4.4.2)
#>  fGarch           4033.92    2024-03-26 [1] CRAN (R 4.4.2)
#>  fontawesome      0.5.2      2023-08-19 [1] CRAN (R 4.4.0)
#>  forcats          1.0.0      2023-01-29 [1] CRAN (R 4.4.2)
#>  Formula          1.2-5      2023-02-24 [1] CRAN (R 4.4.0)
#>  fs               1.6.4      2024-04-25 [1] CRAN (R 4.4.0)
#>  gargle           1.5.2      2023-07-20 [1] CRAN (R 4.4.2)
#>  gbutils          0.5        2022-05-27 [1] CRAN (R 4.4.2)
#>  generics         0.1.3      2022-07-05 [1] CRAN (R 4.4.0)
#>  ggplot2          3.5.1      2024-04-23 [1] CRAN (R 4.4.0)
#>  glue             1.7.0      2024-01-09 [1] CRAN (R 4.4.0)
#>  googledrive      2.1.1      2023-06-11 [1] CRAN (R 4.4.2)
#>  googlesheets4    1.1.1      2023-06-11 [1] CRAN (R 4.4.2)
#>  gss              2.2-8      2024-10-11 [1] CRAN (R 4.4.1)
#>  gtable           0.3.5      2024-04-22 [1] CRAN (R 4.4.0)
#>  haven            2.5.4      2023-11-30 [1] CRAN (R 4.4.2)
#>  highr            0.11       2024-05-26 [1] CRAN (R 4.4.0)
#>  hms              1.1.3      2023-03-21 [1] CRAN (R 4.4.0)
#>  htmltools        0.5.8.1    2024-04-04 [1] CRAN (R 4.4.0)
#>  httr             1.4.7      2023-08-15 [1] CRAN (R 4.4.2)
#>  ids              1.0.1      2017-05-31 [1] CRAN (R 4.4.2)
#>  isoband          0.2.7      2022-12-20 [1] CRAN (R 4.4.0)
#>  itewrpkg         1.0        2024-12-13 [1] Github (mca91/itewrpkg@6a6265e)
#>  jquerylib        0.1.4      2021-04-26 [1] CRAN (R 4.4.0)
#>  jsonlite         1.8.8      2023-12-04 [1] CRAN (R 4.4.0)
#>  KernSmooth       2.23-22    2023-07-10 [2] CRAN (R 4.4.0)
#>  knitr            1.47       2024-05-29 [1] CRAN (R 4.4.0)
#>  labeling         0.4.3      2023-08-29 [1] CRAN (R 4.4.0)
#>  lattice          0.22-6     2024-03-20 [2] CRAN (R 4.4.0)
#>  lifecycle        1.0.4      2023-11-07 [1] CRAN (R 4.4.0)
#>  lme4             1.1-35.5   2024-07-03 [1] CRAN (R 4.4.1)
#>  lmtest           0.9-40     2022-03-21 [1] CRAN (R 4.4.2)
#>  locpol           0.8.0      2022-11-29 [1] CRAN (R 4.4.0)
#>  lubridate        1.9.3      2023-09-27 [1] CRAN (R 4.4.0)
#>  magrittr         2.0.3      2022-03-30 [1] CRAN (R 4.4.0)
#>  MASS             7.3-60.2   2024-04-24 [2] local
#>  Matrix           1.7-0      2024-03-22 [2] CRAN (R 4.4.0)
#>  MatrixModels     0.5-3      2023-11-06 [1] CRAN (R 4.4.1)
#>  maxLik           1.5-2.1    2024-03-24 [1] CRAN (R 4.4.2)
#>  memoise          2.0.1      2021-11-26 [1] CRAN (R 4.4.0)
#>  mgcv             1.9-1      2023-12-21 [2] CRAN (R 4.4.0)
#>  microbenchmark   1.5.0      2024-09-04 [1] CRAN (R 4.4.1)
#>  mime             0.12       2021-09-28 [1] CRAN (R 4.4.0)
#>  minqa            1.2.8      2024-08-17 [1] CRAN (R 4.4.1)
#>  miscTools        0.6-28     2023-05-03 [1] CRAN (R 4.4.2)
#>  modelr           0.1.11     2023-03-22 [1] CRAN (R 4.4.1)
#>  munsell          0.5.1      2024-04-01 [1] CRAN (R 4.4.0)
#>  mvtnorm          1.2-5      2024-05-21 [1] CRAN (R 4.4.0)
#>  nlme             3.1-164    2023-11-27 [2] CRAN (R 4.4.0)
#>  nloptr           2.1.1      2024-06-25 [1] CRAN (R 4.4.1)
#>  nnet             7.3-19     2023-05-03 [2] CRAN (R 4.4.0)
#>  np               0.60-18    2024-12-10 [1] CRAN (R 4.4.0)
#>  numDeriv         2016.8-1.1 2019-06-06 [1] CRAN (R 4.4.0)
#>  openssl          2.2.0      2024-05-16 [1] CRAN (R 4.4.0)
#>  orcutt           2.3        2018-09-27 [1] CRAN (R 4.4.0)
#>  pbkrtest         0.5.3      2024-06-26 [1] CRAN (R 4.4.1)
#>  pillar           1.9.0      2023-03-22 [1] CRAN (R 4.4.0)
#>  pkgconfig        2.0.3      2019-09-22 [1] CRAN (R 4.4.0)
#>  plm              2.6-4      2024-04-01 [1] CRAN (R 4.4.2)
#>  prettyunits      1.2.0      2023-09-24 [1] CRAN (R 4.4.0)
#>  processx         3.8.4      2024-03-16 [1] CRAN (R 4.4.2)
#>  progress         1.2.3      2023-12-06 [1] CRAN (R 4.4.0)
#>  ps               1.8.1      2024-10-28 [1] CRAN (R 4.4.2)
#>  purrr            1.0.2      2023-08-10 [1] CRAN (R 4.4.0)
#>  quadprog         1.5-8      2019-11-20 [1] CRAN (R 4.4.0)
#>  quantmod         0.4.26     2024-02-14 [1] CRAN (R 4.4.2)
#>  quantreg         5.99       2024-10-22 [1] CRAN (R 4.4.1)
#>  R6               2.5.1      2021-08-19 [1] CRAN (R 4.4.0)
#>  ragg             1.3.3      2024-09-11 [1] CRAN (R 4.4.2)
#>  rappdirs         0.3.3      2021-01-31 [1] CRAN (R 4.4.0)
#>  rbibutils        2.3        2024-10-04 [1] CRAN (R 4.4.1)
#>  RColorBrewer     1.1-3      2022-04-03 [1] CRAN (R 4.4.0)
#>  Rcpp             1.0.12     2024-01-09 [1] CRAN (R 4.4.0)
#>  RcppEigen        0.3.4.0.2  2024-08-24 [1] CRAN (R 4.4.1)
#>  RCurl            1.98-1.16  2024-07-11 [1] CRAN (R 4.4.1)
#>  rdd              0.57       2016-03-14 [1] CRAN (R 4.4.2)
#>  rddtools         1.6.0      2022-01-10 [1] CRAN (R 4.4.2)
#>  Rdpack           2.6.1      2024-08-06 [1] CRAN (R 4.4.1)
#>  rdrobust         2.2        2023-11-03 [1] CRAN (R 4.4.2)
#>  readr            2.1.5      2024-01-10 [1] CRAN (R 4.4.1)
#>  readxl           1.4.3      2023-07-06 [1] CRAN (R 4.4.0)
#>  rematch          2.0.0      2023-08-30 [1] CRAN (R 4.4.0)
#>  rematch2         2.1.2      2020-05-01 [1] CRAN (R 4.4.2)
#>  reprex           2.1.1      2024-07-06 [1] CRAN (R 4.4.2)
#>  rlang            1.1.4      2024-06-04 [1] CRAN (R 4.4.0)
#>  rmarkdown        2.27       2024-05-17 [1] CRAN (R 4.4.0)
#>  rstudioapi       0.16.0     2024-03-24 [1] CRAN (R 4.4.0)
#>  rvest            1.0.4      2024-02-12 [1] CRAN (R 4.4.2)
#>  sandwich         3.1-1      2024-09-15 [1] CRAN (R 4.4.2)
#>  sass             0.4.9      2024-03-15 [1] CRAN (R 4.4.0)
#>  scales           1.3.0      2023-11-28 [1] CRAN (R 4.4.0)
#>  selectr          0.4-2      2019-11-20 [1] CRAN (R 4.4.2)
#>  SparseM          1.84-2     2024-07-17 [1] CRAN (R 4.4.1)
#>  spatial          7.3-17     2023-07-20 [2] CRAN (R 4.4.0)
#>  stabledist       0.7-2      2024-08-17 [1] CRAN (R 4.4.1)
#>  stargazer        5.2.3      2022-03-04 [1] CRAN (R 4.4.0)
#>  stringi          1.8.4      2024-05-06 [1] CRAN (R 4.4.0)
#>  stringr          1.5.1      2023-11-14 [1] CRAN (R 4.4.0)
#>  strucchange      1.5-4      2024-09-02 [1] CRAN (R 4.4.2)
#>  survival         3.5-8      2024-02-14 [2] CRAN (R 4.4.0)
#>  sys              3.4.2      2023-05-23 [1] CRAN (R 4.4.0)
#>  systemfonts      1.1.0      2024-05-15 [1] CRAN (R 4.4.2)
#>  textshaping      0.4.1      2024-12-06 [1] CRAN (R 4.4.2)
#>  tibble           3.2.1      2023-03-20 [1] CRAN (R 4.4.0)
#>  tidyr            1.3.1      2024-01-24 [1] CRAN (R 4.4.0)
#>  tidyselect       1.2.1      2024-03-11 [1] CRAN (R 4.4.0)
#>  tidyverse        2.0.0      2023-02-22 [1] CRAN (R 4.4.2)
#>  timechange       0.3.0      2024-01-18 [1] CRAN (R 4.4.0)
#>  timeDate         4041.110   2024-09-22 [1] CRAN (R 4.4.1)
#>  timeSeries       4041.111   2024-09-22 [1] CRAN (R 4.4.2)
#>  tinytex          0.51       2024-05-06 [1] CRAN (R 4.4.0)
#>  TTR              0.24.4     2023-11-28 [1] CRAN (R 4.4.2)
#>  tzdb             0.4.0      2023-05-12 [1] CRAN (R 4.4.0)
#>  urca             1.3-4      2024-05-27 [1] CRAN (R 4.4.2)
#>  utf8             1.2.4      2023-10-22 [1] CRAN (R 4.4.0)
#>  uuid             1.2-1      2024-07-29 [1] CRAN (R 4.4.1)
#>  vars             1.6-1      2024-03-21 [1] CRAN (R 4.4.2)
#>  vctrs            0.6.5      2023-12-01 [1] CRAN (R 4.4.0)
#>  viridisLite      0.4.2      2023-05-02 [1] CRAN (R 4.4.0)
#>  vroom            1.6.5      2023-12-05 [1] CRAN (R 4.4.1)
#>  withr            3.0.2      2024-10-28 [1] CRAN (R 4.4.2)
#>  xfun             0.49       2024-10-31 [1] CRAN (R 4.4.1)
#>  xml2             1.3.6      2023-12-04 [1] CRAN (R 4.4.2)
#>  xts              0.14.1     2024-10-15 [1] CRAN (R 4.4.2)
#>  yaml             2.3.8      2023-12-11 [1] CRAN (R 4.4.0)
#>  zoo              1.8-12     2023-04-13 [1] CRAN (R 4.4.2)
#> 
#>  [1] C:/Users/Deden/AppData/Local/R/win-library/4.4
#>  [2] C:/Program Files/R/R-4.4.0/library
#> 
#> ──────────────────────────────────────────────────────────────────────────────
```

## Pengenalan Singkat R and RStudio

<div class="figure" style="text-align: center">
<img src="images/rstudio.jpg" alt="RStudio: the four panes" width="80%" />
<p class="caption">(\#fig:unnamed-chunk-8)RStudio: the four panes</p>
</div>

#### Dasar-Dasar R {.unnumbered}

Berikut adalah versi terjemahan dalam bahasa Indonesia untuk bagian tersebut:

---

Seperti disebutkan sebelumnya, buku ini bukan dimaksudkan sebagai pengantar <tt>R</tt>, melainkan panduan tentang cara memanfaatkan kemampuannya untuk aplikasi yang umum dijumpai dalam ekonometrika tingkat sarjana. Pembaca yang memiliki pengetahuan dasar tentang pemrograman <tt>R</tt> mungkin akan merasa nyaman untuk langsung memulai dari Bab \@ref(pt). Namun, bagian ini ditujukan bagi mereka yang belum pernah bekerja dengan <tt>R</tt> atau *RStudio* sebelumnya. Jika Anda setidaknya sudah tahu cara membuat objek dan memanggil fungsi, Anda bisa melewati bagian ini. Namun, jika Anda ingin menyegarkan keterampilan Anda atau mendapatkan gambaran tentang cara bekerja dengan *RStudio*, lanjutkan membaca. 

As mentioned before, this book is not intended to be an introduction to
<tt>R</tt> but a guide on how to use its capabilities for
applications commonly encountered in undergraduate econometrics. Those
having basic knowledge in <tt>R</tt> programming may feel
comfortable starting with Chapter \@ref(pt). This section, however, is
meant for those who have not worked with <tt>R</tt> or *RStudio*
before. If you at least know how to create objects and call functions,
you can skip it. If you would like to refresh your skills or get a
feeling for how to work with *RStudio*, keep reading.

First of all, start *RStudio* and open a new <tt>R</tt> script by
selecting *File*, *New File*, *R Script*. In the editor pane, type


``` r
1 + 1
```

and click on the button labeled *Run* in the top right corner of the
editor. By doing so, your line of code is sent to the console and the
result of this operation should be displayed right underneath it. As you
can see, <tt>R</tt> works just like a calculator. You can do all
arithmetic calculations by using the corresponding operator
(<tt>+</tt>, <tt>-</tt>, <tt>*</tt>, <tt>/</tt> or
<tt>^</tt>). If you are not sure what the last operator does, try
it out and check the results.

#### Vectors {.unnumbered}

In <tt>R</tt>, you can work with variables or more generally,
objects. To define an object, you use the assignment operator
<tt><-</tt>, for example, to create a variable named
<tt>x</tt> with the value <tt>10</tt>, you can type `x <- 10`
and then click the *Run* button. The new variable should appear in the
environment pane on the top right. However, the console won't display
any results because this line of code doesn't produce any visible
output. If you want to see the value of `x`, you can simply type `x` in
the console and press *Enter*, and <tt>R</tt> will display the
corresponding value in the console.

<tt>x</tt> is a scalar, a vector of length $1$. You can easily
create longer vectors by using the function <tt>c()</tt> (*c* is
for "concatenate" or "combine"). To create a vector <tt>y</tt>
containing the numbers $1$ to $5$ and print it, do the following.


``` r
y <- c(1, 2, 3, 4, 5)
y
#> [1] 1 2 3 4 5
```

You can also create a vector of letters or words. For now just remember
that characters have to be surrounded by quotes, else they will be
parsed as object names.


``` r
hello <- c("Hello", "World")
```

Here we have created a vector of length 2 containing the words
<tt>Hello</tt> and <tt>World</tt>.

Do not forget to save your script! To do so, select *File* and then
*Save*.

#### Functions {.unnumbered}

You have seen that the function <tt>c()</tt> can be used to combine
objects. In general, all function calls look the same: a function name
is always followed by round parentheses. Often the parentheses include
arguments.

Here are two simple examples.


``` r
# generate the vector `z`
z <- seq(from = 1, to = 5, by = 1)

# compute the mean of the entries in `z`
mean(z)
#> [1] 3
```

In the first line we use a function called <tt>seq()</tt> to create
the exact same vector as we did in the previous section, calling it
<tt>z</tt>. The function takes on the arguments <tt>from</tt>,
<tt>to</tt> and <tt>by</tt> which should be self-explanatory.
The function <tt>mean()</tt> computes the arithmetic mean of its
argument <tt>x</tt>. Since we pass the vector <tt>z</tt> as
the argument <tt>x</tt>, the result is <tt>3</tt>!

If you are not sure which arguments a function expects, you may consult
the function's documentation. Let's say we are not sure how the
arguments required for <tt>seq()</tt> work. We then type `?seq` in
the console. By hitting return, the documentation page for that function
pops up in the lower right pane of *RStudio*. In there, the section
*Arguments* holds the information we seek. On the bottom of almost every
help page you find examples on how to use the corresponding functions.
This is very helpful for beginners and we recommend to have a look.

Of course, all of the commands presented above also work in interactive
widgets throughout the book. You may try them below.

<iframe src='DCL/playground.html' frameborder='0' scrolling='no' style='width:100%;height:340px'></iframe>


