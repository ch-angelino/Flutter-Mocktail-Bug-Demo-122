import 'package:flutter_test/flutter_test.dart';
import 'package:demo/middleware.dart';
import 'package:mocktail/mocktail.dart';
import 'package:redux/redux.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(TriggerAction());
    registerFallbackValue(DispatchedA());
    registerFallbackValue(DispatchedB());
  });

  test('Fail 1', () async {
    final store = StoreMock();

    await getHomeMiddleware().call(store, TriggerAction());

    verify(() => store.dispatch(any<DispatchedA>()));
    verify(() => store.dispatch(any<DispatchedB>()));
  });

  test('Pass 1', () async {
    final store = StoreMock();

    await getHomeMiddleware().call(store, TriggerAction());

    verify(() => store.dispatch(any<DispatchedA>()));
  });

  test('Pass 2', () async {
    final store = StoreMock();

    await getHomeMiddleware().call(store, TriggerAction());

    verify(() => store.dispatch(any<DispatchedB>()));
  });

  test('Pass 3', () async {
    final store = StoreMock();

    await getHomeMiddleware().call(store, TriggerAction());

    verify(() => store.dispatch(any<DispatchedA>())).called(2);
  });
}

class StoreMock extends Mock implements Store<AppState> {}

extension MiddlewareExtension on List<Middleware<AppState>> {
  Future<void> call(Store<AppState> store, dynamic action) async {
    for (final middleware in this) {
      await middleware.call(store, action, (_) {});
    }
  }
}