# Library App Using with Ruby on Rails & Turbo Frames and Turbo Streams

Bu projemde, [CRUD APP Hotwire](https://github.com/sabricakir/CRUD-app-with-hotwire) projesindeki özelliklerin üstüne validates, associations ve callbacks'leri ekleyerek biraz daha gelişmiş bir app ile karşınızdayım. Yine bu projemde de kullandığım turbo stream ve framelerin kullanımının detaylı örneklerine verdiğim linkteki projemden ulaşabilirsiniz. Bu projemde biraz daha validates, associations ve callbacks kavramları üstünde duracağım.

Öncelikle ana sayfamdan başlamak istiyorum. Resimde de gördüğünüz üzere sitenin üst tarafında bulunan navbar ile sitemiz içerisinde gezebiliyoruz. Ana sayfam kitapların listesinin bulunduğu ve yeni bir kitap ekleyebildiğimiz yer olarak karşımıza çıkyıor.

![main-page](https://user-images.githubusercontent.com/84380549/161300828-d12d50ab-ff7e-401f-821d-0936f3b350ef.png)

Burada yeni kitap ekleme kısmında da dikkatinizi çekeceği üzere 3 adet select box bulunuyor. Bunlar diğer oluşturduğum modellerle ilişkili olacak şekilde çalışıyor. Ne demek istiyorum hemen açıklayayım.

![book-under-authors](https://user-images.githubusercontent.com/84380549/161301711-7a6c6c3e-4c11-4755-8820-5f60f683da9c.png)
![book-under-publishers](https://user-images.githubusercontent.com/84380549/161301718-869e26e2-ee0b-4812-bea5-0a8633d83717.png)

Resimlerde gördüğünüz üzere select box listelerinin içinde isimler bulunuyor. Bunların oluşma süreci oluşturduğum associationlardan geliyor. Book modeli ile BookType, Author, Publisher modelleriyle oluşturduğum ilişkiler sayesinde yeni bir BookType, Author ya da Publisher oluşturduğum anda select box listeme bu modelin ismi ekleniyor.

Associationlar da şu şekilde : 

![book-association](https://user-images.githubusercontent.com/84380549/161304973-2793198a-ddbb-49cf-8a3a-80a8330c5b46.png)
![author-association](https://user-images.githubusercontent.com/84380549/161304970-43c4d20c-37b1-4f82-9bfa-435e5beed2d6.png)
![publisher-association](https://user-images.githubusercontent.com/84380549/161304969-0e3073ff-d97a-4af3-9c8e-28ec95f9b625.png)
![bookType-association](https://user-images.githubusercontent.com/84380549/161304966-e28d58d2-5ffe-40b4-9f5c-f417b9856543.png)

Kitap ile diğer modeller arasında belongs_to ilişkisi var iken diğer modellerin ise kendi içinde has_many ve has_many:through ilişkileri bulunuyor. has_many:through sayesinde ise yazarın anlaştığı yayın evleri veya yazarın yayınlamış olduğu kitap türlerine de erişim imkanı bulabiliyorum.

![author-association-array](https://user-images.githubusercontent.com/84380549/161302795-b7f376e0-2e7a-40e6-bf84-bda5a2e61608.png)

![association-author-to-others](https://user-images.githubusercontent.com/84380549/161302673-d3bb377e-a1f8-4847-9a01-898af140eb7c.png)

Validation kullanımına örnek olarak yazar modelindeki validationları incelediğimizde eğer validation'lara uymayan bir şekilde kayıt eklemeye çalışırsak şu şekilde hata alıyoruz. Yine aynı şekilde diğer modeller için validation kullanımları da bu örneğe benzer şekilde gerçekleşiyor.

![author-validates](https://user-images.githubusercontent.com/84380549/161305456-8b6b4217-29d0-4c20-8701-039c933fc004.png)
![authors-errors](https://user-images.githubusercontent.com/84380549/161305453-51238705-49d4-4653-adba-a8fb3fa3aa91.png)

Son olarak callbacks'ler için de yine model katmanında oluşturduğum kodlardan da anlayabileceğiniz şekilde yeni bir modele ait herhangi bir kayıt eklerken yazdığınız string ifadelerin büyük ya da küçük harf olma durumu farketmeksizin hepsi before_save callback'in içinde çağırmış olduğum normalize_name fonksiyonu sayesinde düzenlenip kaydediliyor.

![author-callback](https://user-images.githubusercontent.com/84380549/161306141-93ca442c-ec91-40ad-9dde-78c70a4f3eb1.png)
![author-callback-2](https://user-images.githubusercontent.com/84380549/161306151-b06bd144-480e-4a79-a8da-3e87933acf46.png)
![author-callback-3](https://user-images.githubusercontent.com/84380549/161306381-b9356ab3-a21e-48eb-87e5-24d2a0cff072.png)


