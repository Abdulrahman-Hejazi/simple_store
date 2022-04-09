part of 'user_bloc.dart';



abstract class UserEvent {

}

class UserSigningIn extends UserEvent{
  UserSigningIn(this.userCredintials);
  UserCredintials userCredintials;
}

class UserSigningOut extends UserEvent{
  UserSigningOut();
}

class UserCheckToken extends UserEvent{
}