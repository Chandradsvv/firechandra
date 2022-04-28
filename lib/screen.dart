import 'dart:ffi';

import 'package:firechandra/Signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Home.dart';

class screen extends StatefulWidget {
  const screen({Key? key}) : super(key: key);

  @override
  _screenState createState() => _screenState();
}

class _screenState extends State<screen> {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  var auth= FirebaseAuth.instance;
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  Future<void>googleLogin()async{
    await _googleSignIn.signOut();
    var userdata= await _googleSignIn.signIn();
    print(userdata?.email);
    var authentication = await userdata?.authentication;
    var credential= GoogleAuthProvider.credential(
      accessToken: authentication?.accessToken,
      idToken: authentication?.idToken
    );
    UserCredential user = await FirebaseAuth.instance.signInWithCredential(credential);
    print(user.user?.displayName);


  }

  Future<void> emailLogin({required String email, required String password}) async {
 var user = await auth.signInWithEmailAndPassword(email: email, password: password);
 if (user != null) {
   Navigator.push(
     context,
     MaterialPageRoute(builder: (context) => Home()),
   );
 }
 else { // How to handle exception
   throw new Exception('Value is empty.');
 }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
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
                    child: const Text('Login'),
                    onPressed: () {
                      emailLogin(email: emailController.text.trim(),
                          password: passwordController.text.trim());

                    }
                  )
              ),
              Row(
                children: <Widget>[
                  const Text('Does not have an account?'),
                  TextButton(
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>Signin()),
                    ),
                      //signup screen

                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Container(
                height: 50,
                width: 200,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      googleLogin();
                    },
                    child: Ink(
                      color: Color(0xFF397AF3),
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [

                            Icon(Icons.email), // <-- Use 'Image.asset(...)' here
                            SizedBox(width: 12),
                            Text('Sign in with Google'),
                          ],
                        ),
                      ),
                    ),
                  )
                ),
              ),
            ],
          ),
     //   ),
      ),
    );
  }
}
