import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {

  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  var auth =FirebaseAuth.instance;
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  Future <void> emailLogin({required String email, required String password}) async{
          await auth.createUserWithEmailAndPassword(email: email, password: password).
          then((value){
            print(value.user?.email);
          });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign_in Page"),
      ),
      body: Center(
        //  child: Container(
        //    height: MediaQuery.of(context).size.height,
        //  width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              // height: 200,
              //width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),

              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              //width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
            ),

            Container(
                height: 40,
                width: 100,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Sign in'),
                    onPressed: () async {
                      emailLogin(email: emailController.text.trim(),
                          password: passwordController.text.trim());

                    }
                )
            ),

          ],
        ),
        //   ),
      ),
    );
  }
}
