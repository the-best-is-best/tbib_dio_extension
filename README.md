##   TBIB Dio Extension

* HINT

if use flutter version under 3.16.0
use version 1.0.6

Need dependency_overrides use this

```pubspec
dependency_overrides:
  gql: ^1.0.0+1
```

see <a href="https://pub.dev/packages/requests_inspector">how work requests_inspector</a>

### Import

```dart
import 'package:tbib_dio_extension/tbib_dio_extension.dart';
```

### How To Use

#### Use In Repository

```dart
  if (await networkInfo.isConnected) {
      try {
        var res = await appServicesClient.getSettings();
        if (res.isSuccess) {
          return Success(res.toModel);
        } else {
          return Error(Failure(res.statusCode, res.errorMessage));
        }
      } catch (error) {
        return Error(ErrorHandler.handle(error).failure);
      }
    } else {
      //failure
      // return either left
      return Error(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }

```

#### use in any thing

```dart
// in main it removed in v 1.0.0 baseUrl optional
    DioManger.init(baseUrl: 'baseUrl');


    // for custom option
    DioManger.initWithCustomOption();

    // get dio
    var dio = DioManger.dioApi;

    // call api
    try
    {
       var res= await dio.post('endpoint');
    }
    catch(error)
    {
        // get error from dio
        ErrorHandler.handle(error).failure.messages;
    }
   /* you can get error from api
    example response api
    {
        "result": null,
        "errorMessage": "Invalid userName Or Password",
    }
   */

   ErrorHandler.handle(error, messageFromApi: (error is DioError) ? error.response?.data['errorMessage'] : null).failure.messages;


