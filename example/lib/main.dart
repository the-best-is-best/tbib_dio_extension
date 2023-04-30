import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tbib_dio_extension/tbib_dio_extension.dart';

void main() {
  DioManger.init();
  runApp(const MyApp());
}

class TokenInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // String? userJson = di<GetStorage>().read(GetStorageKeys.userKey);
    // if (userJson != null && userJson.isNotEmpty) {
    //   UserModel user = UserModel.fromJson(jsonDecode(userJson));
    //   if (user.token.isNotEmpty) {
    //     options.headers.addAll({'access_token': user.token});
    //   } else {
    //     di<GetStorage>().remove(GetStorageKeys.userKey);
    //     MitX.offAllNamed(RouteManager.authRoute);
    //   }
    // }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (response.statusCode == 403 || response.statusCode == 401) {
      // di<GetStorage>().remove(GetStorageKeys.userKey);
      // MitX.offAllNamed(RouteManager.authRoute);
    }

    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    super.onError(err, handler);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    getDataApi();
    super.initState();
  }

  void getDataApi() async {
    var dio = DioManger.dioApi;
    try {
      debugPrint("dio url is ${(dio.options.baseUrl)}");
      var res = await dio.post('/endpoint', data: {});
      debugPrint("dio url is ${res.realUri}");
      res.data;
    } catch (error) {
      debugPrint(
          "error catch is ${ErrorHandler.handle(error, messageFromApi: (error is DioError) ? error.response?.data['errorMessage'] : null).failure.messages}");
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
