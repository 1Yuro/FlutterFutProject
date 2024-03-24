import 'dart:convert';
import 'package:zipzip/models/Kullanici.dart';
import 'package:http/http.dart' as http;

class ApiServices 
{
  static String KullaniciListeleURL="http://26.110.79.203:7105/Kullanici/Listele";
  static String KullaniciKayitURL="http://26.110.79.203:7105/Kullanici/Kayit";
  static String TakimlariGetirURL="http://26.110.79.203:7105/LigTablosu/TakimlariGetir";
  static Future getLigTablosu() async {
  final response = await http.get(Uri.parse(TakimlariGetirURL));

  if (response.statusCode == 200) {
    print("İstek başarılı");
    }
  else {
    throw Exception('LigTablosu yüklenemedi');
  }
  return response.body;
}

  static Future<bool> KullaniciKayit(Kullanici kul)async 
  {
    var kulMap = kul.toMap();
    kulMap.remove("ID");
    var kulJson = json.encode(kul.toMap());
    var response = await http.post(Uri.parse(KullaniciKayitURL),body:kulJson,headers: header);

    return Future.value(response.statusCode==200 ? true : false);
  }
  static Future<bool> Giris(String eposta, String parola) async {
  final response = await http.get(Uri.parse(KullaniciListeleURL));

  if (response.statusCode == 200) { 
    final jsonDataList = json.decode(response.body);

    for (var jsonData in jsonDataList) {
      if (jsonData['eposta'] == eposta && jsonData['parola'] == parola) {
        return true; 
      }
    }
  }
  return false;
}
  static Future<bool> EpostaGet(String eposta) async {
    final response = await http.get(Uri.parse(KullaniciListeleURL)); 

    if (response.statusCode == 200) { 
      final jsonDataList = json.decode(response.body);

      for (var jsonData in jsonDataList) {
        if (jsonData['eposta'] == eposta) {
          return true; 
        }
      }
    }
    return false;
}
  static Future<String> EpostaEsitle(String eposta) async {
    final response = await http.get(Uri.parse(KullaniciListeleURL)); 

    if (response.statusCode == 200) { // 
      final jsonDataList = json.decode(response.body);

      for (var jsonData in jsonDataList) {
        if (jsonData['eposta'] == eposta) {
          return jsonData['kullaniciAdi']; // 
        }
      }
 
    }
    return "";
}
  static Map<String,String> header = {
    "Content-type":"application/json",
    "Accept": "application/json",
  };

}
