import 'package:fast_trans/rest/address_api.dart';
import 'package:flutter/material.dart';

import '../core/app_session.dart';
import '../providers/Auth.dart';
import '../widget/card_with_colored_edge.dart';
import '../widget/drop_down_Input.dart';
import '../widget/round_elevated_button.dart';
import '../widget/round_text_field.dart';

class AddressesPage extends StatefulWidget {
  @override
  _AddressesState createState() => _AddressesState();
}

class _AddressesState extends State<AddressesPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController buildingNumberController =
      TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  Map<String, City> cities = {};
  @override
  void didChangeDependencies() {
    print('didChangeDependencies');

    cities = Auth().addressResponse.cities;
    print("length=${cities.length}");
    cities.keys.forEach((element) {
      print("element=${element}");
    });
    citiesList = cities.keys.map((e) => e).toList();

    /*cities.forEach((key, city) {
      print('city=${city.name}');
      city.towns.forEach((key, town) {
        print('town=${town.name}');
        town.villages.forEach((key, village) {
          print('village=${village.name}');
        });
      });
    });*/
  }

  List<String> citiesList = [];
  Widget build(BuildContext context) {
    double height = 150.0;
    Direction direction = AppSession.instance.languageCode == 'ar'
        ? Direction.left
        : Direction.right;

    return Scaffold(
      appBar: AppBar(title: text('Create Address', color: Colors.white)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: CaredWithColoredEdge(
            isRedEdge: false,
            //  row3children: getRow3Widget(120, 1),
            620,
            Colors.blue.shade900,
            Colors.red,
            direction,
            // getWidget1('images/from.png', 'From'),
            getWidget10('images/from.png', 'Name', 'Mohammad AlodatMohammad ',
                Colors.white),
          ),
        ),
      ),
    );
  }

  Widget text(
    String text, {
    Color color = Colors.white,
    double size = 14,
    String font = 'm',
  }) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontFamily: 'loew$font'),
      softWrap: true,
    );
  }

  List<Widget> getRow3Widget(double height, int index) {
    return [
      Center(
        child: Column(
          children: [
            Container(
              height: height / 2,
              //   color: Colors.amberAccent,
              child: InkWell(
                onTap: () {
                  print('selected edit Icone index $index');
                },
                child: Icon(
                  Icons.edit,
                  color: Colors.white70,
                  //size: 30,
                ),
              ),
              //  color: Colors.black,
            ),
            Container(
              height: height / 2,
              //  color: Colors.amberAccent,
              child: InkWell(
                onTap: () {
                  print('selected share index $index');
                },
                child: Icon(
                  Icons.share,
                  color: Colors.white70,
                  //size: 30,
                ),
              ),
              //  color: Colors.black,
            ),
          ],
        ),
      ),
      const SizedBox(width: 8),
    ];
  }

// Initial Selected Value
  String dropdownvalue = 'Item 1';
  // List of items in our dropdown menu
  List<String> townList = [];
  List<String> villageList = [];
  Widget getDropdownButton() {
    return DropdownButton(
      // Initial Value
      value: dropdownvalue,

      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items: townList.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue = newValue!;
        });
      },
    );
  }

  Widget _buildTextField(
    String labelText,
    controller, {
    bool isDrop = false,
    List<String> items = const [],
    PopupMenuItemSelected<String>? onSelected,
  }) {
    return RoundTextField(
      labelText: labelText,
      isRadius: false,
      isDrop: isDrop,
      items: items,
      onSelected: onSelected,
      // hintText: "info@demouri.com",
      hintTextColor: const Color(0xFFB6C7D1),
      hintFontSize: 14.0,
      //     icon: Icons.mail_outline,
      iconColor: const Color(0xFFB6C7D1),
      bottomPadding: 10,
      controller: controller,
      enabledBorderSideColor: Colors.white,
      focusedBorderSideColor: Colors.white,
      //   isEmail: true,
    );
  }

  String gender = "Male";
  Widget getWidget10(String imagePath, String textLabel1, String textLabel2,
      Color backgroundColor) {
    DropdownInput s = DropdownInput(
      hintText: 'City',
      options: ["Male", "Female"],
      value: gender,
      onChanged: (dynamic s) {},
      getLabel: (dynamic value) => value,
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
      child: Column(
        children: [
          //  _buildTextField('Full Name', nameController),
          _buildTextField('Full Name', nameController),
          _buildTextField('mobile', mobileController),
          _buildTextField('street', streetController),
          _buildTextField('Building Number', buildingNumberController),
          //dd
          _buildTextField(
            'city',
            cityController,
            isDrop: true,
            items: citiesList,
            onSelected: (String value) {
              if (value == cityController.text) return;
              townList = [];
              townController.text = '';
              villageController.text = '';
              setState(() {
                print('setState');
                cityController.text = value;
              });
              City? city = cities[value];
              city?.towns?.forEach((key, value) {
                townList.add(key);
              });
            },
          ),
          _buildTextField(
            'town',
            townController,
            isDrop: true,
            items: townList,
            onSelected: (String value) {
              if (value == townController.text) return;
              setState(() {
                print('setState');
                townController.text = value;
              });
              villageList = [];
              villageController.text = '';
              City? city = cities[cityController.text];
              Town? town = city?.towns[value];
              town?.villages?.forEach((key, value) {
                villageList.add(key);
              });
            },
          ),
          _buildTextField(
            'village',
            villageController,
            isDrop: true,
            items: villageList,
            onSelected: (String value) {
              setState(() {
                print('setState');
                villageController.text = value;
              });
              /* villageList = [];
              City? city = cities[cityController.text];
              Town? town = city?.towns[townController.text];
              Village? village = town?.villages[value];
              town?.villages?.forEach((key, value) {
                villageList.add(key);
              });*/
            },
          ),

          // _buildTextField('map', nameController),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: RoundElevatedButton(
                      child: getButtonText('Submit'),
                      color: Colors.blueGrey,
                      onPressed: () {},
                      radius: 30,
                      minimumSizeFromHeight: 0,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: RoundElevatedButton(
                      child: getButtonText('Reset'),
                      color: Colors.blueGrey,
                      onPressed: () {},
                      radius: 30,
                      minimumSizeFromHeight: 0,
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  Widget getButtonText(String text2) {
    Widget child2 = text(text2, color: Colors.white);
    Widget c2 = Container(
      alignment: Alignment.center,
      //color: Colors.red,
      //   width: 90,
      height: 35,
      // padding: const EdgeInsets.all(10.0),
      child: child2,
    );
    return c2;
  }
}
