import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_store/logic/user_bloc/user_bloc.dart';
import 'package:simple_store/model/user.dart';
import 'package:simple_store/service/auth.dart';
import 'package:simple_store/service/cache.dart';
import 'package:simple_store/view/screens/home_screen.dart';
import 'package:simple_store/view/screens/login_screen.dart';

class Wrapper extends StatelessWidget {

Auth auth = Auth();


  // resignIn() async {
  //   await DataSaver.dataSaverIni();
  //
  //   String? token = await DataSaver.getData('token');
  //   if (token != null){
  //     User user = await auth.getUser(token);
  //     return user;
  //   }
  //   else{
  //     return null;
  //   }
  //
  // }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc,UserState>(
        builder: (context, state) {
          if (state is UserSignIn){
              return HomeScreen();
          }
          else if (state is UserSignOut){
            return LoginScreen();
          }
          else {
            return Scaffold(
              body: Center(child: CircularProgressIndicator(),),
            );
          }

        },
    );
  }
}
