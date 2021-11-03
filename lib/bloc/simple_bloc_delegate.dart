import 'package:bloc/bloc.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc? bloc, Object? event) {
    super.onEvent(bloc!, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
  }
}
