import 'package:flutter/material.dart';
import 'package:zipzip/services/ApiServices.dart';
import 'package:zipzip/models/Kullanici.dart';
import 'package:zipzip/pages/login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final adsoyadController = TextEditingController();
  final kullaniciAdiController = TextEditingController();
  final parolaController = TextEditingController();
  final apiService = ApiServices();
  late Kullanici yeniKul;

  @override
  void initState() {
    super.initState();
    yeniKul = Kullanici();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Kayıt",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28.0, color: Colors.green),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Ad Soyad",
                    ),
                    onSaved: (girilen) {
                      yeniKul.adisoyadi = girilen!;
                    },
                    controller: adsoyadController,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Kullanıcı Adı",
                    ),
                    onSaved: (girilen) {
                      yeniKul.kullaniciadi = girilen!;
                    },
                    controller: kullaniciAdiController,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,//telefondaki klavye için çalışıyor, bilgisayardaki klavyede çalışmadı
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "E-posta",
                    ),
                    onSaved: (girilen) {
                      yeniKul.eposta = girilen!;
                    },
                    controller: emailController,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Parola",
                    ),
                    onSaved: (girilen) {
                      yeniKul.parola = girilen!;
                    },
                    controller: parolaController,
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      final String adSoyad = adsoyadController.text.trim();
                      final String email = emailController.text.trim();
                      final String kullaniciAdi = kullaniciAdiController.text.trim();
                      final String parola = parolaController.text.trim();

                      if (adSoyad.isEmpty ||
                          email.isEmpty ||
                          kullaniciAdi.isEmpty ||
                          parola.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Tüm alanları doldurunuz."),
                            duration: Duration(seconds: 5),
                          ),
                        );
                      } else {
                        _formKey.currentState!.save();
                        bool kayitIslemi = await ApiServices.EpostaGet(email);

                        if (kayitIslemi) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Zaten bir hesabınız var."),
                              duration: Duration(seconds: 5),
                            ),
                          );
                        } else {
                          ApiServices.KullaniciKayit(yeniKul);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text("Kaydol"),
                  ),
                  const SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: const Text("Zaten bir hesabınız var mı?"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}