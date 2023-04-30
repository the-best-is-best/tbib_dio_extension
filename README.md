##   TBIB Dio Extension

### Import

```dart
import 'package:tbib_dio_extension/tbib_dio_extension.dart';
```

### How To Use


```dart
// in main it removed in v 1.0.0 baseUrl optional
    DioManger.init(baseUrl: 'baseUrl');


// for custom option
DioManger.initWithCustomOption();

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
