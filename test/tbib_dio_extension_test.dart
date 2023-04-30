import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tbib_dio_extension/tbib_dio_extension.dart';

void main() {
  test('Test Custom Error', () async {
    DioManger.init();
    var dio = DioManger.dioApi;
    try {
      debugPrint("dio url is ${(dio.options.baseUrl)}");
      var res = await dio.post('/api/Account/Login',
          data: {'userName': 's', 'passWord': 's', 'fireBaseToken': 's'});
      debugPrint("dio url is ${res.realUri}");
      res.data;
    } catch (error) {
      debugPrint(
          "error catch is ${ErrorHandler.handle(error, messageFromApi: (error is DioError) ? error.response?.data['errorMessage'] : null).failure.messages}");
      debugPrint(ErrorHandler.handle(error).failure.messages);
    }
  });
}
