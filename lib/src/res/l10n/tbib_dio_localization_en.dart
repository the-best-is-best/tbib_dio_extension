import 'tbib_dio_localization.dart';

/// The translations for English (`en`).
class TBIBDioLocalizationsEn extends TBIBDioLocalizations {
  TBIBDioLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get success => 'SUCCESS';

  @override
  String get no_content => 'Success with not content';

  @override
  String get bad_request => 'Bad request. try again later';

  @override
  String get forbidden_request => 'Forbidden request. try again later';

  @override
  String get unauthorized => 'User unauthorized, try again later';

  @override
  String get not_found => 'Not found';

  @override
  String get internal_server_error => 'Some thing went wrong, try again later';

  @override
  String get default_error => 'Some thing went wrong, try again later';

  @override
  String get time_Out => 'Request time out, try again later';

  @override
  String get no_internet => 'Check Your Internet';

  @override
  String get bad_certificate => 'Server Not Secure';
}
