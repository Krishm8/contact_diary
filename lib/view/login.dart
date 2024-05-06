import 'package:contact_diary/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> fkey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    SharedPreferences.getInstance().then(
      (pref) {
        var isLogin = pref.getBool("isLogin");
        if (isLogin ?? false) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HomePage();
              },
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple.shade200,
                  Colors.blue.shade100,
                  Colors.redAccent.shade100,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Form(
              key: fkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 30),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Valid Email";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Valid Password";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black),
                      foregroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    onPressed: () async {
                      var isVal = fkey.currentState?.validate() ?? false;
                      if (isVal) {
                        if (email.text == "abc@gmail.com" &&
                            password.text == "123456") {
                          var sp = await SharedPreferences.getInstance();
                          await sp.setBool("isLogin", true);

                          Navigator.pushReplacementNamed(context, "home");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Invalid"),
                            ),
                          );
                        }
                      } else {}
                    },
                    child: Text("Login"),
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
