import 'package:simple_store/model/login_response.dart';
import 'package:simple_store/model/user.dart';
import 'package:simple_store/model/user_creditials.dart';
import 'package:simple_store/service/auth.dart';
import 'package:simple_store/service/cache.dart';

class UserRepo {
  User? _user;

  Auth _auth = Auth();

  Future<bool> signin(UserCredintials userCredintials) async {
    bool signedIn = false;
    try {
      LoginResponse? response =
          await _auth.signIn(userCredintials.email, userCredintials.password);
      if (response != null) {
        DataSaver.saveData(response.token, 'token');
        _user =
            User(name: response.name, email: response.email, id: response.id);
        signedIn = true;
      } else {
        signedIn = false;
      }
    } catch (e) {
      print(e);
    }

    return signedIn;
  }

  loadUser() => _user;

  Future<User?> userCheck() async {
    String? token = await DataSaver.getData('token');
    User? user = token != null ? await _auth.getUser(token): null;
    return user;
  }

  void logout() async {
    String token = await DataSaver.getData('token');
    await _auth.signOut(token);
    DataSaver.deleteData('token');

  }
}
