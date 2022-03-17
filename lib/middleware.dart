import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> getHomeMiddleware() => [
  HomeMiddleware().getMiddlewareBindings(),
].expand((x) => x).toList();

class HomeMiddleware {
  List<Middleware<AppState>> getMiddlewareBindings() => [
    TypedMiddleware<AppState, TriggerAction>(_handleTriggerAction),
  ];

  void _handleTriggerAction(Store<AppState> store, TriggerAction action, next) {
    next(action);

    store.dispatch(DispatchedA());
    store.dispatch(DispatchedB());
  }
}

@immutable
class TriggerAction {
  @override
  String toString() {
    return 'TriggerAction{}';
  }
}

@immutable
class DispatchedA {
  @override
  String toString() {
    return 'DispatchedA{}';
  }
}

@immutable
class DispatchedB {
  @override
  String toString() {
    return 'DispatchedB{}';
  }
}

class AppState extends Equatable {
  @override
  List<Object> get props => [];
}
