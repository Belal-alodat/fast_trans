import 'supplier_api_base.dart';

class AddressApi extends SupplierAPI {
  /*Future<LoginResponse> login(LoginRequest request) async {
    //  print('on login');
    Map<String, dynamic> requestMap = request.toJson();

    final response = await dioClient.post("/auth/login", data: requestMap);
    // print('response here');
    LoginResponse loginResponse = LoginResponse.fromJson(response);
    //  print('loginResponse${loginResponse.token}');
    return loginResponse;
  }*/
}

class Village {
  int id = -1;
  String name = '';

  Village.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    //print('id=$id');
    name = json['name'];
  }
}

class Town {
  int id = -1;
  String name = '';
  Map<String, Village> villages = {};

  Town.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // print('id=$id');
    name = json['name'];

    for (Map<String, dynamic> village in json['villages']) {
      String villageName = village['name'];
      //print('villageName=$villageName');
      villages[villageName] = Village.fromJson(village);
    }
  }
}

class City {
  int id = -1;
  String name = '';
  Map<String, Town> towns = {};

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // print('id=$id');
    name = json['name'];

    for (Map<String, dynamic> town in json['towns']) {
      String townName = town['name'];
      //   print('townName=$townName');
      towns[townName] = Town.fromJson(town);
    }
  }
}

class AddressResponse {
  Map<String, City> cities = {};

  AddressResponse(this.cities);

  AddressResponse.fromJson(List<Map<String, dynamic>> json) {
    for (Map<String, dynamic> city in json) {
      String cityName = city['name'];
      //  print('cityName=$cityName');
      cities[cityName] = City.fromJson(city);
    }
  }
}

main() {
  print('hi');
  AddressResponse s = AddressResponse.fromJson(addresses);

  print('s=${s.cities.length}');
  s.cities.forEach((key, city) {
    print('city=${city.name}');
    city.towns.forEach((key, town) {
      print('town=${town.name}');
      town.villages.forEach((key, village) {
        print('village=${village.name}');
      });
    });
  });
}

List<Map<String, dynamic>> addresses = [
  {
    "id": 1,
    "name": "city1",
    "towns": [
      {
        "id": 1,
        "name": "city1-town1",
        "villages": [
          {"id": 1, "name": "city1-town1-village1"},
          {"id": 2, "name": "city1-town1-village2"},
          {"id": 3, "name": "city1-town1-village3"}
        ]
      },
      {
        "id": 2,
        "name": "city1-town2",
        "villages": [
          {"id": 4, "name": "city1-town2-village4"},
          {"id": 5, "name": "city1-town2-village5"},
          {"id": 6, "name": "city1-town2-village6"}
        ]
      }
    ]
  },
  {
    "id": 2,
    "name": "city2",
    "towns": [
      {
        "id": 21,
        "name": "city2-town21",
        "villages": [
          {"id": 7, "name": "city2-town21-village7"},
          {"id": 8, "name": "city2-town21-village8"},
          {"id": 9, "name": "city2-town21-village9"}
        ]
      },
      {
        "id": 22,
        "name": "city2-town22",
        "villages": [
          {"id": 10, "name": "city2-town22-village10"},
          {"id": 11, "name": "city2-town22-village11"},
          {"id": 12, "name": "city2-town22-village12"}
        ]
      }
    ]
  }
];
