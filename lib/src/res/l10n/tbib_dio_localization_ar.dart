import 'tbib_dio_localization.dart';

/// The translations for Arabic (`ar`).
class TBIBDioLocalizationsAr extends TBIBDioLocalizations {
  TBIBDioLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get success => 'تم بنجاح';

  @override
  String get no_content => 'تم بنجاح ولكن لا يوجد محتوى';

  @override
  String get bad_request => 'طلب غير صالح جرب مره اخري في وقتا اخر';

  @override
  String get forbidden_request => 'طلب ممنوع جرب مره اخري في وقتا اخر';

  @override
  String get unauthorized => 'غير مصرح لك بالدخول جرب مره اخري في وقتا اخر';

  @override
  String get not_found => 'غير موجود جرب مره اخري في وقتا اخر';

  @override
  String get internal_server_error => 'خطأ بالخادم جرب مره اخري في وقتا اخر';

  @override
  String get default_error => 'حدث خطأ ما جرب مره اخري في وقتا اخر';

  @override
  String get time_Out => 'انتهاء الوقت جرب مره اخري في وقتا اخر';

  @override
  String get no_internet => 'تاكد من الاتصال بالإنترنت';

  @override
  String get bad_certificate => 'شهادة غير صالحة';
}
