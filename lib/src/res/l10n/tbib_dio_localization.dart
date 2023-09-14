import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'tbib_dio_localization_ar.dart';
import 'tbib_dio_localization_en.dart';

/// Callers can lookup localized strings with an instance of TBIBDioLocalizations
/// returned by `TBIBDioLocalizations.of(context)`.
///
/// Applications need to include `TBIBDioLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/tbib_dio_localization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: TBIBDioLocalizations.localizationsDelegates,
///   supportedLocales: TBIBDioLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the TBIBDioLocalizations.supportedLocales
/// property.
abstract class TBIBDioLocalizations {
  TBIBDioLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static TBIBDioLocalizations? of(BuildContext context) {
    return Localizations.of<TBIBDioLocalizations>(context, TBIBDioLocalizations);
  }

  static const LocalizationsDelegate<TBIBDioLocalizations> delegate = _TBIBDioLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @success.
  ///
  /// In ar, this message translates to:
  /// **'تم بنجاح'**
  String get success;

  /// No description provided for @no_content.
  ///
  /// In ar, this message translates to:
  /// **'تم بنجاح ولكن لا يوجد محتوى'**
  String get no_content;

  /// No description provided for @bad_request.
  ///
  /// In ar, this message translates to:
  /// **'طلب غير صالح جرب مره اخري في وقتا اخر'**
  String get bad_request;

  /// No description provided for @forbidden_request.
  ///
  /// In ar, this message translates to:
  /// **'طلب ممنوع جرب مره اخري في وقتا اخر'**
  String get forbidden_request;

  /// No description provided for @unauthorized.
  ///
  /// In ar, this message translates to:
  /// **'غير مصرح لك بالدخول جرب مره اخري في وقتا اخر'**
  String get unauthorized;

  /// No description provided for @not_found.
  ///
  /// In ar, this message translates to:
  /// **'غير موجود جرب مره اخري في وقتا اخر'**
  String get not_found;

  /// No description provided for @internal_server_error.
  ///
  /// In ar, this message translates to:
  /// **'خطأ بالخادم جرب مره اخري في وقتا اخر'**
  String get internal_server_error;

  /// No description provided for @default_error.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ ما جرب مره اخري في وقتا اخر'**
  String get default_error;

  /// No description provided for @time_Out.
  ///
  /// In ar, this message translates to:
  /// **'انتهاء الوقت جرب مره اخري في وقتا اخر'**
  String get time_Out;

  /// No description provided for @no_internet.
  ///
  /// In ar, this message translates to:
  /// **'تاكد من الاتصال بالإنترنت'**
  String get no_internet;

  /// No description provided for @bad_certificate.
  ///
  /// In ar, this message translates to:
  /// **'شهادة غير صالحة'**
  String get bad_certificate;
}

class _TBIBDioLocalizationsDelegate extends LocalizationsDelegate<TBIBDioLocalizations> {
  const _TBIBDioLocalizationsDelegate();

  @override
  Future<TBIBDioLocalizations> load(Locale locale) {
    return SynchronousFuture<TBIBDioLocalizations>(lookupTBIBDioLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_TBIBDioLocalizationsDelegate old) => false;
}

TBIBDioLocalizations lookupTBIBDioLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return TBIBDioLocalizationsAr();
    case 'en': return TBIBDioLocalizationsEn();
  }

  throw FlutterError(
    'TBIBDioLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
