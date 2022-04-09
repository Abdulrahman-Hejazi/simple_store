import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simple_store/logic/user_bloc/user_bloc.dart';
import 'package:simple_store/model/login_response.dart';
import 'package:simple_store/model/user_creditials.dart';
import 'package:simple_store/service/auth.dart';
import 'package:simple_store/service/cache.dart';
import 'package:simple_store/view/routes.dart';

class LogInForm extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  Auth _auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              onChanged: (value) {
                email = value;
              },
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              onChanged: (value) {
                // Save password
                password = value;
              },
              validator: (value) {
                // validate
                return (value == null || value.length < 5)
                    ? 'password is too weak'
                    : null;
              },
              obscureText: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'password',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor),
            child: Text('login'),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<UserBloc>(context)
                  ..add(UserSigningIn(
                      UserCredintials(email.toString(), password.toString())));
              }
            },
          ),
        ],
      ),
    );
  }
}
