##   TBIB Dio Extension

### Import

```dart
import 'package:tbib_dio_extension/tbib_dio_extension.dart';
```

### How To Use


```dart
// in main 
    DioManger.init(baseUrl: 'baseUrl');

    // get dio 
    var dio = DioManger.dioApi;

    // call api

   var res= await dio.post('endpoint');

   // get error from dio
   ErrorHandler.handle(error).failure.messages;

   /* you can get error from api
    example response api
    {
        "result": null,
        "errorMessage": "Invalid userName Or Password",
    }
   */

   ErrorHandler.handle(error, messageFromApi: (error is DioError) ? error.response?.data['errorMessage'] : null).failure.messages;
