import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce/core/network/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnectionChecker mockConnectionChecker;

  setUp(() {
    mockConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockConnectionChecker);
  });

  test('should forward the call to InternetConnectionChecker.hasConnection', () async {
    final tHasConnectionFuture = Future.value(true);

    when(mockConnectionChecker.hasConnection).thenAnswer((_) => tHasConnectionFuture);

    final result = networkInfoImpl.isConnected;

    expect(result, tHasConnectionFuture);
    verify(mockConnectionChecker.hasConnection);
  });
}
