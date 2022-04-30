// import 'dart:math';
// import 'package:provider_application_1/domain/data_providers/user_data_provider.dart';
// import 'package:provider_application_1/domain/entity/user.dart';

// class UserService {
//   final userDataProvider = UserDataProvider();
//   User get user => userDataProvider.user;

//   void incrementCounterOne() {
//     final user = userDataProvider.user;
//     userDataProvider.user = user.copyWith(count: user.counter + 1);
//     userDataProvider.saveValue();
//   }

//   void decrementCounterOne() {
//     final user = userDataProvider.user;
//     userDataProvider.user = user.copyWith(count: max(user.counter - 1, 0));
//     userDataProvider.saveValue();
//   }

//   Future<void> initialize() async {
//     await userDataProvider.loadFromStorage();
//   }
// }
