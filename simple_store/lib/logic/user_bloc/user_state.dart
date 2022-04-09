part of 'user_bloc.dart';


abstract class UserState{}

class UserLoading extends UserState {}

class UserSignIn extends UserState{
  UserSignIn({required this.user});
  final User user;

}

class UserSignOut extends UserState{

}

class UserWrongCredintials extends UserState{

}