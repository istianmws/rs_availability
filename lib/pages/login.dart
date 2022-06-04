import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rs_availibility/pages/home.dart';
import 'package:rs_availibility/pages/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' show json;
import 'dart:async';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String _username = "";
  String password = "";
  bool isLoginSuccess = false;
  late SharedPreferences logindata;
  late bool newuser;

  void _tampilkanalert() {
    AlertDialog alert = AlertDialog(
      title: Text("Hai $_username",
        style: const TextStyle(
          fontSize: 25,
        ),),
      content: Container(
        child: const Text(" Selamat datang ...",
          style: TextStyle(
            fontSize: 15,
          ),),
      ),
      actions: [
        TextButton(
          child: const Text('Ok'),
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage())),
        ),
      ],
    );

    showDialog(context: context, builder: (context) => alert);
    return;
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);

    if (!newuser) {
      Navigator.pushReplacement(context, 
      new MaterialPageRoute(builder: (context) =>
      Home()));
    }
    //newuser = (logindata.getBool('login') ?? true);
    // print(newuser);

    // if (newuser == false) {
    // Navigator.pushReplacement(
    // context, new MaterialPageRoute(builder: (context) => HomePage()));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login Page"),
        ),
        body: Column(children: [
          _usernameField(),
          _passwordField(),
          _loginButton(context),
        ]),
      ),
    );
  }

  Widget _usernameField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        enabled: true,
        onChanged: (value) {
          _username = value;
        },
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.account_circle,
              color: Color.fromARGB(255, 0, 147, 254)),
          hintText: 'Username',
          contentPadding: const EdgeInsets.all(8.0),
          border: const OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
            borderSide:
                BorderSide(color: (isLoginSuccess) ? Colors.blue : Colors.red),
          ),
        ),

      ),
    );
  }

  Widget _passwordField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        enabled: true,
        obscureText: true,
        onChanged: (value) {
          password = value;
        },
        decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: const EdgeInsets.all(8.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
            borderSide:
                BorderSide(color: (isLoginSuccess) ? Colors.blue : Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width,
      child:
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: (isLoginSuccess) ? Colors.blue : Colors.red, // background
          onPrimary: Colors.white, // foreground
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () {
          _tampilkanalert();

        String text = "";
        if (password == "123") {
          setState(() {
            text = "Login Success";
            isLoginSuccess = true;
          });
          logindata.setBool('login', false);
                logindata.setString('email', email);

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                  return Home();
                }));

              } else {
                setState(() {
                  text = "Login Failed";
                  isLoginSuccess = false;
                });
              }
              SnackBar snackBar = const SnackBar(
                content: Text("Berhasil Masuk"),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text('Log In',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xffffffff),
          ),
        ),
      )
      // ElevatedButton(
      //   style: ElevatedButton.styleFrom(
      //     primary: (isLoginSuccess) ? Colors.blue : Colors.red, // background
      //     onPrimary: Colors.white, // foreground
      //   ),
      //   onPressed: () {
      //     String text = "";
      //     if (password == "123") {
      //       setState(() {
      //         text = "Login Success";
      //         isLoginSuccess = true;
      //       });
      //       logindata.setBool('login', false);
      //       logindata.setString('email', email);
      //
      //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      //         return Home();
      //       }));
      //
      //     } else {
      //       setState(() {
      //         text = "Login Failed";
      //         isLoginSuccess = false;
      //       });
      //     }
      //     SnackBar snackBar = SnackBar(
      //       content: Text("Berhasil Masuk"),
      //     );
      //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //   },
      //   child: const Text('Login'),
      // ),
    );
  }
}