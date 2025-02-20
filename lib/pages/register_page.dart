import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_clone/components/button.dart';
import 'package:social_media_clone/components/text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // kontroleri za uredjivanje (unos) teksta
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  // registracija korisnika
  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }
  void signUp() {
    // prikazati krug za ucitavanje
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // provjeriti da li su sifre iste
    if (passwordTextController.text != confirmPasswordTextController.text) {
      // iskoci loading krug
      Navigator.pop(context);
      displayMessage('Šifre se ne poklapaju');
      return;
    }

    // pokusati kreirati korisnika
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
    } on FirebaseAuthException catch (e){
      Navigator.pop(context);
      displayMessage(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 189, 191, 203), // tsuki3
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Icon(
                  Icons.lock,
                  size: 100,
                ),
                // dobrodosli nazad
                Text(
                  "Dobro došli, hajmo napraviti račun za vas!",
                  style: TextStyle(
                    color: Color.fromARGB(255, 74, 77, 89), // tsuki0
                  ),
                ),
                const SizedBox(height: 25),
                // email polje
                MyTextField(
                  controller: emailTextController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),
                // password polje

                MyTextField(
                  controller: passwordTextController,
                  hintText: 'Šifra',
                  obscureText: true,
                ),
                // potvrda za password polje

                const SizedBox(height: 10),
                // password polje

                MyTextField(
                  controller: confirmPasswordTextController,
                  hintText: 'Potvrdi šifru',
                  obscureText: true,
                ),

                const SizedBox(height: 25),
                // sign up tipka
                MyButton(
                  onTap: signUp,
                  text: 'Registruj se',
                ),

                const SizedBox(height: 25),
                // idi na prijavu
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Imate već račun?"),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Prijavite se sada",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 66, 96, 138), // umiBlue
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
