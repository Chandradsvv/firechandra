import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {

  var auth =FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  Future <void> emailLogin({required String email, required String password}) async{
    await auth.signInWithEmailAndPassword(email: email, password: password).then((value){
      print (value.user?.email);
    }).catchError(
            (e) async{
          print(e.toString());
          await auth.createUserWithEmailAndPassword(email: email, password: password).
          then((value){
            print(value.user?.email);
          });
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            children: [
              Container(
                //alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(

                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),

              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: 100,
                child: ElevatedButton(
                    child:Text('Login'),
                    onPressed: () async {
                      emailLogin(email: emailController.text.trim(),
                          password: passwordController.text.trim());

                    }

                  // print(emailController.text);
                  // print(passwordController.text);

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
