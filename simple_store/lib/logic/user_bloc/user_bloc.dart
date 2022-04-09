import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:simple_store/logic/user_bloc/user_repo.dart';
import 'package:simple_store/model/user.dart';
import 'package:simple_store/model/user_creditials.dart';


part 'user_event.dart';
part 'user_state.dart';



class UserBloc extends Bloc<UserEvent,UserState>{
  UserBloc(this.userRepo) : super(UserLoading()){
    on<UserSigningIn>(_onUserSigningIn);
    on<UserSigningOut>(_onUserSiginingOut);
    on<UserCheckToken>(_onUserCheck);
  }

  UserRepo userRepo;


  FutureOr<void> _onUserSigningIn(UserSigningIn event, Emitter<UserState> emit) async {
    bool result = await userRepo.signin(event.userCredintials);
    
    if (result){
      emit(UserSignIn(user: userRepo.loadUser()));
    }
    else{
      emit(UserWrongCredintials());
    }
  }



  FutureOr<void> _onUserSiginingOut(UserSigningOut event, Emitter<UserState> emit) {
    userRepo.logout();
    emit(UserSignOut());
  }

  FutureOr<void> _onUserCheck(UserCheckToken event, Emitter<UserState> emit)async {
    User? user = await userRepo.userCheck();
    if (user != null){
      emit(UserSignIn(user: user));
    }
    else{
      emit(UserSignOut());
    }

  }
}