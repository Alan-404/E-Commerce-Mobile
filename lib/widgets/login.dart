// ignore_for_file: unnecessary_const

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/widgets/layouts/home.dart';
/* import 'package:flutter_secure_storage/flutter_secure_storage.dart'; */

Future<bool> loginAccount(email, password) async {
  final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/user/auth_user'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body:
          json.encode(<String, String>{'email': email, 'password': password}));
  if (response.statusCode == 200) {
    /* final storage = new FlutterSecureStorage(); */
    return true;
  } else {
    throw Exception('Failed to login account.');
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<bool>? loginUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 130),
        color: Colors.blue,
        child: Center(
          child: Column(
            children: [
              const Image(
                width: 100,
                height: 100,
                image: NetworkImage(
                    'https://wallpaperaccess.com/full/1712457.jpg'),
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text("Login Account",
                      style: TextStyle(fontSize: 35, color: Colors.white))),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.yellow)),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.orange, width: 2)),
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(color: Colors.white)),
                    style: const TextStyle(color: Colors.white, fontSize: 20)),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.yellow)),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.orange, width: 2)),
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(color: Colors.white)),
                    style: const TextStyle(color: Colors.white, fontSize: 20)),
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      loginAccount(
                              emailController.text, passwordController.text)
                          .then((value) {
                        if (value == true) {
                          emailController.text = "";
                          passwordController.text = "";
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DashboardScreen(
                                        route: "dashboard",
                                      )));
                        }
                      });
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Login Account',
                      style: TextStyle(color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
