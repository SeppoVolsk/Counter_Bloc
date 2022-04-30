// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:provider_application_1/domain/data_providers/user_data_provider.dart';
import 'package:provider_application_1/domain/entity/user.dart';

class UsersState {
  final User currentUser;

  UsersState(this.currentUser);

  UsersState copyWith({
    User? currentUser,
  }) {
    return UsersState(
      currentUser ?? this.currentUser,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsersState && other.currentUser == currentUser;
  }

  @override
  int get hashCode => currentUser.hashCode;
}

abstract class UsersEvents {}

class UserIncrementEvent implements UsersEvents {}

class UserDecrementEvent implements UsersEvents {}

class UserInitializeEvent implements UsersEvents {}

class UsersBloc extends Bloc<UsersEvents, UsersState> {
  final userDataProvider = UserDataProvider();
  //var _state = UsersState(User(0));
  // UsersState get state => _state;

  // final _eventController = StreamController<UsersEvents>.broadcast();
  // late final Stream<UsersState> _stateStream;
  // Stream<UsersState> get stream => _stateStream;

  // void updateState(UsersState state) {
  //   if (_state == state) return;
  //   _state = state;
  //   _stateController.add(state);
  // }

  UsersBloc() : super(UsersState(User(0))) {
    on<UserInitializeEvent>((event, emit) async {
      final user = await userDataProvider.loadFromStorage();
      emit(UsersState(user));
    }, transformer: sequential());
    on<UserDecrementEvent>((event, emit) async {
      var user = state.currentUser;
      user = user.copyWith(count: max(user.counter - 1, 0));
      await userDataProvider.saveValue(usr: user);
      emit(UsersState(user));
    }, transformer: sequential());
    on<UserIncrementEvent>((event, emit) async {
      var user = state.currentUser;
      user = user.copyWith(count: user.counter + 1);
      await userDataProvider.saveValue(usr: user);
      emit(UsersState(user));
    }, transformer: sequential());
    add(UserInitializeEvent());
  }

  // void dispatch(UsersEvents event) {
  //   _eventController.add(event);
  // }

  // Stream<UsersState> _updateState(UsersState state) async* {
  //   if (_state == state) return;
  //   _state = state;
  //   yield state;
  // }

  // Stream<UsersState> _mapEventToState(UsersEvents event) async* {
  //   if (event is UserInitializeEvent) {
  //     final user = await userDataProvider.loadFromStorage();
  //     yield UsersState(user);
  //   } else if (event is UsersIncrementEvent) {
  //     var user = _state.currentUser;
  //     user = user.copyWith(count: user.counter + 1);
  //     await userDataProvider.saveValue(usr: user);
  //     yield UsersState(user);
  //   } else if (event is UserDecrementEvent) {
  //     var user = _state.currentUser;
  //     user = user.copyWith(count: max(user.counter - 1, 0));
  //     await userDataProvider.saveValue(usr: user);
  //     yield UsersState(user);
  //   }
  // }

  // Future<void> _initialize() async {
  //   final user = await userDataProvider.loadFromStorage();
  //   final newState = state.copyWith(currentUser: user);
  //   emit(newState);
  // }

  // void incrementCounterOne() {
  //   var user = state.currentUser;
  //   user = user.copyWith(count: user.counter + 1);
  //   emit(state.copyWith(currentUser: user));
  //   userDataProvider.saveValue(usr: user);
  // }

  // void decrementCounterOne() {
  //   var user = state.currentUser;
  //   user = user.copyWith(count: max(user.counter - 1, 0));
  //   emit(state.copyWith(currentUser: user));
  //   userDataProvider.saveValue(usr: user);
  // }

  // void close() {
  //   _eventController.close();
  // }
}
