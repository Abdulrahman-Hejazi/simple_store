import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_store/view/widgets/signin_form.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('LogIn'),
        centerTitle: true,
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),

        children: [
          SizedBox(height: 10,),
          Image.asset('images/logo.png',height: Get.height/3.5,),
          SizedBox(height: 35,),
          LogInForm(),
        ],
      ),

    );
  }
}
