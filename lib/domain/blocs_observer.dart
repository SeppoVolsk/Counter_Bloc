import 'package:bloc/bloc.dart';
//
//
//
//dhjgf

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(bloc);
    print(' $event ');
  }
}
