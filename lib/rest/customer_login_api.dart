import 'auth_api_base.dart';
import 'supplier_api_base.dart';

class CustomerLoginApi extends AuthAPI {
  Future<LoginResponse> login(LoginRequest request) async {
    //  print('on login');
    Map<String, dynamic> requestMap = request.toJson();

    final response = await dioClient.post("/login", data: requestMap);
    // print('response here');
    LoginResponse loginResponse = LoginResponse.fromJson(response);
    //  print('loginResponse${loginResponse.token}');
    return loginResponse;
  }
}

class LoginResponse {
  String statusCode = '';
  String token = '';

  LoginResponse({required this.statusCode, required this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['jwt-token'];
    // print('loginResponse=$token');
  }
}

class LoginRequest {
  final String userName;
  final String password;
  final String lang_code;

  LoginRequest(
      {required this.userName,
      required this.password,
      required this.lang_code});

  Map<String, dynamic> toJson() {
    print('on toJson');
    final Map<String, dynamic> jsonObject = new Map<String, dynamic>();

    jsonObject["email"] = this.userName;
    jsonObject["password"] = this.password;
    jsonObject["lang_code"] = this.lang_code;

    return jsonObject;
  }
}
