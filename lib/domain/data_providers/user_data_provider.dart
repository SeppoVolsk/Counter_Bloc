import 'package:provider_application_1/domain/entity/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataProvider {
  var user = User(0);
  final _storage = SharedPreferences.getInstance();

  Future<User> loadFromStorage() async {
    final counter = (await _storage).getInt('value') ?? 0;

    //user = User(counter);
    return User(counter);
  }

  Future<void> saveValue({User? usr}) async {
    (await _storage).setInt('value', usr == null ? user.counter : usr.counter);
  }
}
