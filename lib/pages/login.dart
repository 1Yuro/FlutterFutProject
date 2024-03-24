import 'package:flutter/material.dart';
import 'package:zipzip/pages/mainpage.dart';
import 'package:zipzip/pages/register.dart';
import 'package:zipzip/services/ApiServices.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _Login();
}
class _Login extends State<LoginScreen>
{
  var formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
    void dispose() {
    _emailController.dispose();
    super.dispose();
  }
  @override
    Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0), 
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/image/futop.png', 
                    height: 100.0,
                  ),
                  SizedBox(height: 20),
                  const Text(
                    "Hoş Geldiniz",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30.0,color: Colors.green,fontWeight: FontWeight.w500),                   
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      labelText: "E-posta",
                    ),
                    controller: _emailController,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      labelText: "Parola",
                    ),
                    controller: passwordController,
                    validator: (value) {
                      if (value!.length < 6) {
                        return "Parola en az 6 karakter uzunluğunda olmalıdır";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async { 
                      var email = _emailController.text.trim();
                      var password = passwordController.text.trim();
                      bool girisIslemi = await ApiServices.Giris(email, password);
                      
                      final snackBar = SnackBar(
                        content: Text(girisIslemi ? "Giriş başarılı" : "E-posta veya parola yanlış"),
                        duration: const Duration(seconds: 5),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      if (girisIslemi) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => mainPage(eposta: email))
                        );
                      }
                    },
                    child: const Text("Giriş Yap"), 
                  ),
                  const SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () 
                    {
                      Navigator.of(context).push
                      (
                        MaterialPageRoute(builder: (context){ return const RegisterScreen();})
                      );
                    },
                    child: const Text("Hesap oluştur"),
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
