class Village {
  int id = -1;
  String name = '';

  Village(this.name);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonObject = new Map<String, dynamic>();
    jsonObject["name"] = name;
    jsonObject["id"] = id;
    return jsonObject;
  }
  Village.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    print('   Villageid=$id');
    name = json['name'];
  }
}

class Town {
  int id = -1;
  String name = '';
  Town(this.name);
  Map<String, Village> villages = {};

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonObject = new Map<String, dynamic>();
    jsonObject["name"] = name;
    jsonObject["id"] = id;
    return jsonObject;
  }

  Town.fromJson(Map<String, dynamic> json) {
    id = json['id'];
     print(' Town id=$id');
    name = json['name'];
    var villagesList = json['villages'];
    if(villagesList != null)
      for (Map<String, dynamic> village in json['villages']) {
        String villageName = village['name'];
        print('   villageName=$villageName');
        villages[villageName] = Village.fromJson(village);
      }
  }
}

class City {
  int id = -1;
  String name = '';
  Map<String, Town> towns = {};
  City(this.name);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonObject = new Map<String, dynamic>();
    jsonObject["name"] = name;
    jsonObject["id"] = id;
    return jsonObject;
  }

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
     print('City id=$id');
    name = json['name'];
     var townsList = json['towns'];
     if(townsList != null)
      for (Map<String, dynamic> town in json['towns']) {
        String townName = town['name'];
           print(' townName=$townName');
        towns[townName] = Town.fromJson(town);
      }
  }
}

class Address {
  int? id;
  City? city;
  Town? town;
  Village? village;
  String? street;
  int? buildingNumber;
  String? mobile;
  String? fullName;
  bool favourite;
  bool? fromAddress;
  double? latitude;
  double? longitude;
  Address({
    this.id=-1,
    this.longitude = 0.0,
    this.latitude = 0.0,
    this.favourite=true,
    this.fromAddress=false,
    required this.street,
    required this.buildingNumber,
    required this.mobile,
    required this.fullName,
    required this.city,
    required this.town,
    required this.village,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonObject = new Map<String, dynamic>();
    jsonObject["id"] = id;
    jsonObject["city"] = city?.toJson();

    jsonObject["town"] = town?.toJson();
    jsonObject["village"] = village?.toJson();
    jsonObject["mobile"] = mobile;
    jsonObject["street"] = street;
    jsonObject["buildingNumber"] = buildingNumber;

    jsonObject["fullName"] = fullName;
    jsonObject["latitude"] = latitude;
    jsonObject["longitude"] = longitude;
    jsonObject["favourite"] = favourite;
    jsonObject["fromAddress"] = fromAddress;

    return jsonObject;
  }


  Address.fromJson(Map<String, dynamic> jsonObject, {this.favourite=true,}) {
    id = jsonObject["id"] ;
    mobile= jsonObject["mobile"];
    street= jsonObject["street"] ;
    buildingNumber =jsonObject["buildingNumber"];
    fullName =jsonObject["fullName"];
    latitude= jsonObject["latitude"];
    longitude = jsonObject["longitude"];
    fromAddress = jsonObject["fromAddress"];

    city = City.fromJson(jsonObject["city"]) ;
    town = Town.fromJson(jsonObject["town"] );
    village = Village.fromJson(jsonObject["village"]) ;

  }
}


class AddressResponse {
  List<Address> addresses = [];

  AddressResponse(this.addresses);

  AddressResponse.fromJson(List<dynamic> json) {

    for ( dynamic address in json) {
     // int id = address['id'];
      addresses.add(Address.fromJson(address));

    }
  }
}

class AddressLookupResponse {
  Map<String, City> cities = {};

  AddressLookupResponse(this.cities);

  AddressLookupResponse.fromJson(List<dynamic> json) {
    for (Map<String, dynamic> city in json) {
      String cityName = city['name'];
        print('cityName=$cityName');
      cities[cityName] = City.fromJson(city);
    }
  }
}

main() {
  print('hi');
  /*AddressLockupResponse s = AddressLockupResponse.fromJson(addressesLookupAsJson);

  print('s=${s.cities.length}');
  s.cities.forEach((key, city) {
    print('city=${city.name}');
    city.towns.forEach((key, town) {
      print('town=${town.name}');
      town.villages.forEach((key, village) {
        print('village=${village.name}');
      });
    });
  });*/

  AddressResponse addressResponse  = AddressResponse.fromJson(addressesAsJson);
  print('[');
 // addressResponse.addresses.forEach((address) {  print('   id=${address.id}');});
  addressResponse.addresses.forEach((address) {
    print('   id=${address.id}');
    print('   city=${address.city?.name}');
    print('   town=${address.town?.name}');
    print('   village=${address.village?.name}');
    print('   fromAddress=${address.fromAddress}');
    print('   favourite=${address.favourite}');
    print('   longitude=${address.longitude}');
    print('   buildingNumber=${address.buildingNumber}');
    print('   fullName=${address.fullName}');
    print('   latitude=${address.latitude}');
    print('   mobile=${address.mobile}');
    print('   street=${address.street}');
    print(' }');
  });
  print(']');
}
List<Map<String, dynamic>> addressesAsJson = [
  {
    "id": 11,
    "city": {
      "id": -1,
      "name": "t"
    },
    "town": {
      "id": -1,
      "name": "t"
    },
    "village": {
      "id": -1,
      "name": "t"
    },
    "mobile": "mobile",
    "street": "street",
    "buildingNumber": 1,
    "fullName": "fullName",
    "latitude": 1.1,
    "longitude": 1.1,
    "fromAddress": false
  },
  {
    "id": 29,
    "city": {
      "id": -1,
      "name": "t"
    },
    "town": {
      "id": -1,
      "name": "t"
    },
    "village": {
      "id": -1,
      "name": "t"
    },
    "mobile": "mobile",
    "street": "street",
    "buildingNumber": 1,
    "fullName": "fullName",
    "latitude": 1.1,
    "longitude": 1.1,
    "fromAddress": false
  },
  {
    "id": 33,
    "city": {
      "id": -1,
      "name": "t"
    },
    "town": {
      "id": -1,
      "name": "t"
    },
    "village": {
      "id": -1,
      "name": "t"
    },
    "mobile": "mobile",
    "street": "street",
    "buildingNumber": 1,
    "fullName": "fullName",
    "latitude": 1.1,
    "longitude": 1.1,
    "fromAddress": false
  },
  {
    "id": 55,
    "city": {
      "id": -1,
      "name": "t"
    },
    "town": {
      "id": -1,
      "name": "t"
    },
    "village": {
      "id": -1,
      "name": "t"
    },
    "mobile": "0569960717",
    "street": "street ali",
    "buildingNumber": 12,
    "fullName": "full name ali1",
    "latitude": 0.0,
    "longitude": 0.0,
    "fromAddress": false
  },
  {
    "id": 56,
    "city": {
      "id": -1,
      "name": "t"
    },
    "town": {
      "id": -1,
      "name": "t"
    },
    "village": {
      "id": -1,
      "name": "t"
    },
    "mobile": "0569960717",
    "street": "street ali",
    "buildingNumber": 12,
    "fullName": "full To",
    "latitude": 0.0,
    "longitude": 0.0,
    "fromAddress": false
  },
  {
    "id": 61,
    "city": {
      "id": -1,
      "name": "t"
    },
    "town": {
      "id": -1,
      "name": "t"
    },
    "village": {
      "id": -1,
      "name": "t"
    },
    "mobile": "0569960717",
    "street": "street ali",
    "buildingNumber": 12,
    "fullName": "full name ali to",
    "latitude": 0.0,
    "longitude": 0.0,
    "fromAddress": false
  },
  {
    "id": 63,
    "city": {
      "id": -1,
      "name": "t"
    },
    "town": {
      "id": -1,
      "name": "t"
    },
    "village": {
      "id": -1,
      "name": "t"
    },
    "mobile": "0569960717",
    "street": "street ali",
    "buildingNumber": 12,
    "fullName": "full name ali to",
    "latitude": 0.0,
    "longitude": 0.0,
    "fromAddress": false
  },
  {
    "id": 85,
    "city": {
      "id": -1,
      "name": "t"
    },
    "town": {
      "id": -1,
      "name": "t"
    },
    "village": {
      "id": -1,
      "name": "t"
    },
    "mobile": "0569960717",
    "street": "street ali",
    "buildingNumber": 12,
    "fullName": "full to to",
    "latitude": 0.0,
    "longitude": 0.0,
    "fromAddress": false
  }
];

List<Map<String, dynamic>> addressesLookup2AsJson = [
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
