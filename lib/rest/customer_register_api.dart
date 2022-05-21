import 'supplier_api_base.dart';

class RegisterApi extends SupplierAPI {
  Future<void> register2(RegisterRequest request) async {
    print('on register2sss');
  }

  Future<void> register(RegisterRequest request) async {
    print('on register');
    Map<String, dynamic> requestMap = request.toJson();

    final response = await dioClient.post("/auth/register", data: requestMap);
  }
}

class RegisterRequest {
  final String email;
  final String password;
  final String mobile;
  final String fullName;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.mobile,
    required this.fullName,
  });

  Map<String, dynamic> toJson() {
    print('on toJson $mobile');
    final Map<String, dynamic> jsonObject = new Map<String, dynamic>();
    final Map<String, dynamic> jsonObject0 = new Map<String, dynamic>();

    jsonObject["email"] = email;
    jsonObject["password"] = password;
    jsonObject["fullName"] = fullName;
    jsonObject["mobile"] = mobile;
    jsonObject0["credentials"] = jsonObject;
    return jsonObject0;
  }
}
