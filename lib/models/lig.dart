class Lig{

  int id= 0;
  String takimadi = "";
  int takimoynanan = 0;
  int takimgalibiyet = 0;
  int takimberaberlik = 0;
  int takimmalubiyet = 0;
  int takimatilangol = 0;
  int takimyenengol = 0;
  int takimaveraj = 0;
  int takimpuan = 0;

  Lig();

  Lig.ozellik(this.id,this.takimadi,this.takimoynanan,this.takimgalibiyet,this.takimberaberlik,this.takimmalubiyet,this.takimatilangol,this.takimyenengol,this.takimaveraj,this.takimpuan);

  Lig.fromObject(dynamic a)
  {
    this.id = a["id"];
    this.takimadi = a["takimAdi"];
    this.takimoynanan = a["takimOyananan"];
    this.takimgalibiyet = a["takimGalibiyet"];
    this.takimberaberlik = a["takimBeraberlik"];
    this.takimmalubiyet = a["takimMalubiyet"];
    this.takimatilangol = a["takimAtilanGol"];
    this.takimyenengol = a["takimYenenGol"];
    this.takimaveraj = a["takimAveraj"];
    this.takimpuan = a["takimPuan"];
  }
  Map<String,dynamic> toMap()
  {
    var map = Map<String, dynamic>();
    map["id"] = this.id;
    map["takimAdi"] = this.takimadi;
    map["takimOyananan"] = this.takimoynanan;
    map["takimGalibiyet"] = this.takimgalibiyet;
    map["takimBeraberlik"] = this.takimberaberlik;
    map["takimMalubiyet"] = this.takimmalubiyet;
    map["takimAtilanGol"] = this.takimatilangol;
    map["takimYenenGol"] = this.takimyenengol;
    map["takimAveraj"] = this.takimaveraj;
    map["takimPuan"] = this.takimpuan;
    return map;
  }
}