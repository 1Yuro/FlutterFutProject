class Kullanici 
{
  int id= 0;
  String adisoyadi = "";
  String kullaniciadi="";
  String eposta = "";
  String parola = "";

  Kullanici();

  Kullanici.parametreli(this.id,this.adisoyadi,this.kullaniciadi,this.eposta,this.parola);

  Kullanici.fromObject(dynamic a)
  {
    this.id=a["ID"];
    this.adisoyadi=a["AdSoyad"];
    this.kullaniciadi=a["KullaniciAdi"];
    this.eposta=a["KullaniciEposta"];
    this.parola=a["Parola"];
  }
  Map<String, dynamic> toMap()
  {
    var map = Map<String, dynamic>();
    map["ID"] = this.id;
    map["AdSoyad"]=this.adisoyadi;
    map["KullaniciAdi"]=this.kullaniciadi;
    map["Eposta"]=this.eposta;
    map["Parola"]=this.parola;
    return map;
  }
}