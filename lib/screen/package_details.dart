import 'package:fast_trans/rest/address_api.dart';
import 'package:flutter/material.dart';

import '../core/app_session.dart';
import '../widget/card_with_colored_edge.dart';
import '../widget/round_elevated_button.dart';
import '../widget/round_text_field.dart';

class PackageDetailsPage extends StatefulWidget {
  @override
  _PackageDetailsState createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetailsPage> {
  bool _isSaveing = false;
  final TextEditingController priceController = TextEditingController();
  final TextEditingController piecesController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController buildingNumberController =
      TextEditingController();
  final TextEditingController productController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController dimensionController = TextEditingController();
  Map<String, City> cities = {};
  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    cities = AppSession.instance.getcities();

    //  print("length=${cities.length}");
    /* cities.keys.forEach((element) {
      print("element=${element}");
    });*/
    citiesList = cities.keys.map((e) => e).toList();
  }

  List<String> citiesList = [];
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context)!.settings.arguments as String;
    double height = 150.0;
    Direction direction = AppSession.instance.languageCode == 'ar'
        ? Direction.left
        : Direction.right;

    return Scaffold(
      appBar: AppBar(title: text('Create Package', color: Colors.white)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: CaredWithColoredEdge(
            isRedEdge: false,
            620,
            Colors.blue.shade900,
            Colors.red,
            direction,
            getWidget10(),
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
  Widget getWidget10() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
      child: Column(
        children: [
          //  _buildTextField('Full Name', nameController),
          _buildTextField('price', priceController),
          _buildTextField('weight', weightController),
          _buildTextField('pieces', piecesController),

          //dd
          _buildTextField(
            'product',
            productController,
            isDrop: true,
            items: citiesList,
            onSelected: (String value) {
              if (value == productController.text) return;
              townList = [];
              dimensionController.text = '';
              villageController.text = '';
              setState(() {
                print('setState');
                productController.text = value;
              });
              City? city = cities[value];
              city?.towns?.forEach((key, value) {
                townList.add(key);
              });
            },
          ),
          _buildTextField(
            'dimension',
            dimensionController,
            isDrop: true,
            items: townList,
            onSelected: (String value) {
              if (value == dimensionController.text) return;
              setState(() {
                print('setState');
                dimensionController.text = value;
              });
              villageList = [];
              villageController.text = '';
              City? city = cities[productController.text];
              Town? town = city?.towns[value];
              town?.villages?.forEach((key, value) {
                villageList.add(key);
              });
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
                      onPressed: _isSaveing ? null : _submit,
                      radius: 30,
                      minimumSizeFromHeight: 0,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: RoundElevatedButton(
                      child: getButtonText('Reset'),
                      color: Colors.blueGrey,
                      onPressed: _reset,
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

  void _submit() async {
    setState(() {
      _isSaveing = true;
    });
    print('_submit ');
    String name = priceController.text;
    String street = piecesController.text;
    String mobile = weightController.text;
    String buildingNumber = buildingNumberController.text;
    String city = productController.text;
    String town = dimensionController.text;
    String village = villageController.text;
    // await Future.delayed(const Duration(seconds: 2));
    Address address2 = Address(
        city: City(city),
        town: Town(town),
        village: Village(village),
        mobile: mobile,
        buildingNumber: int.parse(buildingNumber),
        fullName: name,
        street: street);
    print('pop ');
    final title = ModalRoute.of(context)!.settings.arguments as String;
    if (title == 'To') {
      AppSession.instance.toAddresses.add(address2);
    } else {
      AppSession.instance.fromAddresses.add(address2);
    }

    Navigator.pop(context);
  }

  void _reset() {
    print('_reset ');

    priceController.text = 'full name ali';
    piecesController.text = 'street ali';
    weightController.text = '0569960717';
    buildingNumberController.text = '12';
    productController.text = 'city1';
    dimensionController.text = 'city1-town1';
    villageController.text = 'city1-town1-village1';
  }
}
