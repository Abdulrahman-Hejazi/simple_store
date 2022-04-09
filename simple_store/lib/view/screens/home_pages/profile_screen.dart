import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_store/logic/user_bloc/user_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserSignIn) {
        return ListView(
          padding: EdgeInsets.symmetric(vertical: 60, horizontal: 100),
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                  child: Text(
                state.user.name,
                style: TextStyle(fontSize: 18, letterSpacing: 1.1),
              )),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                  child: Text(
                state.user.email,
                style: TextStyle(fontSize: 18, letterSpacing: 1.1),
              )),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(onPressed: () {
              BlocProvider.of<UserBloc>(context).add(UserSigningOut());
            }, child: Text('Log Out'))
          ],
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
