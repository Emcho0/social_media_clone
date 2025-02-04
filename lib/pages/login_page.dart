import 'package:flutter/material.dart';
import 'package:social_media_clone/components/button.dart';
import 'package:social_media_clone/components/text_field.dart';

class LoginPage extends StatefulWidget {
  // final Function()? onTap;
  const LoginPage({
    super.key,
    // required this.onTap,
  });
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // kontroleri za uredjivanje (unos) teksta
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
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
                  "Dobro došli, nedostajali ste nam!",
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

                const SizedBox(height: 25),
                // sign in tipka
                MyButton(
                  onTap: () {},
                  text: 'Prijavi se',
                ),

                const SizedBox(height: 25),
                // idi na registraciju
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Niste član?"),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Registrujte se sada",
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
