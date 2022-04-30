import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider_application_1/domain/blocs/users_bloc.dart';
import 'package:provider_application_1/domain/blocs_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () {},
    blocObserver: MyBlocObserver(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: BlocProvider<UsersBloc>(
        create: (context) => UsersBloc(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersBloc, UsersState>(
      listenWhen: (previous, current) => true,
      //слушает при определенных условиях
      listener: (context, state) {
        //Просто слушает всё, ни на что не влияет, ничто не перерисовывает
        print(state.currentUser.counter);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Trenikus'),
        ),
        body: const _ShowValue(),
        floatingActionButton: const _ChangeValueButtons(),
      ),
    );
  }
}

// class ViewModelState {
//   final String counterTitle;

//   ViewModelState({required this.counterTitle});
// }

//  class ViewModel extends ChangeNotifier {

//   final _userService = UserService();
//   //final userDataProvider = UserDataProvider();
//   var _state = ViewModelState(counterTitle: '');
//   ViewModelState get state => _state;

//   void loadValue() async {
//     await _userService.initialize();
//     //await _userService.userDataProvider.loadFromStorage();

//     _state = ViewModelState(counterTitle: _userService.user.counter.toString());
//     notifyListeners();
//   }

//   ViewModel() {
//     loadValue();
//     // _userService.initialize().then((_) {
//     //   print(_userService.user.counter);
//     //   _state =
//     //       ViewModelState(counterTitle: _userService.user.counter.toString());

//     //   print(_state.counterTitle);
//     //   notifyListeners();
//     // });
//   }

//   Future<void> onIncrementButtonPressed() async {
//     _userService.incrementCounterOne();
//     _updateState();
//   }

//   Future<void> onDecrementButtonPressed() async {
//     _userService.decrementCounterOne();
//     _updateState();
//   }

//   void _updateState() {
//     final user = _userService.user;
//     _state = ViewModelState(counterTitle: user.counter.toString());
//     notifyListeners();
//   }
// }

class _ShowValue extends StatelessWidget {
  const _ShowValue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      buildWhen: ((previous, current) => true),
      builder: (context, state) {
        return Center(
          child: SizedBox(
            width: 150,
            height: 150,
            child: FittedBox(
              child: Text('${state.currentUser.counter}'),
            ),
          ),
        );
      },
    );
    // final bloc = context.read<UsersBloc>();
    // return StreamBuilder<UsersState>(
    //   initialData: bloc.state,
    //   stream: bloc.stream,
    //   builder: (context, snapshot) {
    //     return Center(
    //       child: SizedBox(
    //         width: 150,
    //         height: 150,
    //         child: FittedBox(
    //           child: Text(
    //             snapshot.requireData.currentUser.counter.toString(),
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}

class _ChangeValueButtons extends StatelessWidget {
  const _ChangeValueButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UsersBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          onPressed: () => bloc.add(UserIncrementEvent()),
          child: const Icon(Icons.plus_one),
        ),
        FloatingActionButton(
            onPressed: () => bloc.add(UserDecrementEvent()),
            child: const Icon(Icons.exposure_minus_1)),
      ],
    );
  }
}
