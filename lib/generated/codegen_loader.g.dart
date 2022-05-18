// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) {
    print('CodegenLoader load ');
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> en = {
    "language": "العربية",
    "registerTitle": "Register for Account",
    "forgetPassword": "Forget password ?",
    "login": "Login",
    "welcome": "welcome",
    "welcome2": "Sign it to Manage your shipments",
    "IDNO": "Identity number",
    "IDDesc": "identity\\ Saudi residency or international ID",
    "docNo": "Active policy number",
    "exDate": "Policy expiry date",
    "userName": "Username",
    "userNameDesc": "User name must have minimum 6 and maximum 16 character",
    "mobileNO": "Mobile number",
    "mobileNODesc": "Local\\ International mobile number (E.G 966550000000)",
    "mobileNoEG": "E.G 966550000000",
    "email": "Email address",
    "cEmail": "Re-enter email address",
    "iAccept": "I accept",
    "termsAndConditions": "Terms and conditions",
    "createNewAccount": "Create new account",
    "password": "Password",
    "rememberMe": "Remember me",
    "fingerPrintLogin": "Fingerprint login",
    "buyInsurance": "Buy insurance",
    "trackYourClaim": "Track your claim",
    "findBranch": "Find a branch",
    "contactUs": "Contact us"
  };
  static const Map<String, dynamic> ar = {
    "language": "English",
    "registerTitle": "إنشاء حساب ",
    "forgetPassword": "هل نسيت كلمة المرور؟ ",
    "login": "تسجيل الدخول",
    "welcome": "مرحبا بك",
    "welcome2": "سجل الدخول لادارة شحناتك",
    "IDNO": "رقم الهوية",
    "IDDesc": "هوية/ إقامة سعودية أو هوية دولية",
    "docNo": "رقم الوثيقة",
    "exDate": "تاريخ إنتهاء الوثيقة",
    "userName": "إسم المستخدم",
    "userNameDesc": "إسم المستخدم يجب أن يتكون من ٦ إلى ١٥ حرف أو رقم",
    "mobileNO": "الجوال",
    "mobileNODesc": "رقم الجوال محلي/ دولي (مثال 966550000000)",
    "mobileNoEG": "مثال 966550000000",
    "email": "عنوان البريد الإلكتروني",
    "cEmail": "أعد كتابة البريد الإلكتروني",
    "iAccept": "أوافق على",
    "termsAndConditions": "الشروط والأحكام",
    "createNewAccount": "إنشاء حساب جديد",
    "password": "كلمة المرور",
    "rememberMe": "تذكرني",
    "fingerPrintLogin": "تسجيل الدخول بالبصمة",
    "buyInsurance": "إشتر تأمينك",
    "trackYourClaim": "تتبع مطالبتك",
    "findBranch": "إبحث عن فرع",
    "contactUs": "تواصل معنا"
  };

  static const Map<String, Map<String, dynamic>> mapLocales = {
    "en": en,
    "ar": ar
  };
}
