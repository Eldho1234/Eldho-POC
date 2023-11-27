import 'package:flutter/material.dart';
import 'package:login/API%20services/api_services.dart';
import 'package:login/view/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _EmailController = TextEditingController();

  final TextEditingController _PasswordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool shopass = true;

  void login() async {
    bool isAuthenticated = await ApiServices.login(
        _EmailController.text, _PasswordController.text);
    if (isAuthenticated) {
      print("Login successful");
    } else {
      print("Invalid credentials.please try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              const Center(
                  child: Text("Book Shop",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold))),
                          const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _EmailController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.account_box_sharp),
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100))),
                  textInputAction: TextInputAction.next,
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return "please enter a email";
                    }
                    if (!isEmailVAlid(email)) {
                      return 'Enter a valid email';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _PasswordController,
                  obscureText: shopass,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.visibility_off,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (shopass) {
                                shopass = false;
                              } else {
                                shopass = true;
                              }
                            });
                          },
                          icon: Icon(shopass == true
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100))),
                  textInputAction: TextInputAction.done,
                  validator: (Password) {
                    if (Password!.isEmpty || Password.length < 6) {
                      return 'Enter a valid password,length should bw greater than 6';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      //style: ButtonStyle(backgroundColor:M),
                      onPressed: () {
                        login();
                        final valid = formkey.currentState!.validate();
                        if (valid) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ));
                        } else {
                          return;
                        }
                        _EmailController.clear();
                        _PasswordController.clear();
                      },
                      child: const Center(child: Text("Login"))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool isEmailVAlid(String email) {
  final RegExp emailREgx = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return emailREgx.hasMatch(email);
}
