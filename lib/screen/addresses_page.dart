import 'package:fast_trans/rest/address_api.dart';
import 'package:flutter/material.dart';

import '../core/app_session.dart';
import '../util/dialogue.dart';
import '../util/exception_handler.dart';
import '../util/widget_util.dart';
import '../widget/card_with_colored_edge.dart';
import '../widget/round_elevated_button.dart';
import '../widget/round_text_field.dart';

class AddressesPage extends StatefulWidget {
  @override
  _AddressesState createState() => _AddressesState();
}

class _AddressesState extends State<AddressesPage> {
  bool _isSaveing = false;
  AddressApi addressApi = AddressApi();
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
      appBar: AppBar(title: WidgetUtil.text('Create ${title} Address', color: Colors.white)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: CardWithColoredEdge(
            isRedEdge: false,
            //  row3children: getRow3Widget(120, 1),
            620,
            Colors.blue.shade900,
            Colors.red,
            direction,
            // getWidget1('images/from.png', 'From'),
            getWidget10(),
          ),
        ),
      ),
    );
  }

  /*Widget text(
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
  }*/



// Initial Selected Value
  String dropdownvalue = 'Item 1';
  // List of items in our dropdown menu
  List<String> townList = [];
  List<String> villageList = [];
  /*Widget getDropdownButton() {
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
  }*/

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
                      child: WidgetUtil.getButtonText('Submit',35),
                      color: Colors.blueGrey,
                      onPressed: _isSaveing ? null : _submit,
                      radius: 30,
                      minimumSizeFromHeight: 0,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: RoundElevatedButton(
                      child:  WidgetUtil.getButtonText('Reset',35),
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

  /*Widget getButtonText(String text2) {
    Widget child2 = WidgetUtil.text(text2, color: Colors.white);
    Widget c2 = Container(
      alignment: Alignment.center,
      //color: Colors.red,
      //   width: 90,
      height: 35,
      // padding: const EdgeInsets.all(10.0),
      child: child2,
    );
    return c2;
  }*/

  void _submit() async {
    setState(() {
      _isSaveing = true;
    });
    print('_submit ');
    String name = nameController.text;
    String street = streetController.text;
    String mobile = mobileController.text;
    String buildingNumber = buildingNumberController.text;
    String city = cityController.text;
    String town = townController.text;
    String village = villageController.text;
    final title = ModalRoute.of(context)!.settings.arguments as String;
    // await Future.delayed(const Duration(seconds: 2));
    Address address = Address(
        city: City(city),
        town: Town(town),
        village: Village(village),
        mobile: mobile,
        buildingNumber: int.parse(buildingNumber),
        fullName: name,
        street: street,
    fromAddress: title == 'To' ? false:true,
    favourite: true);
    print('pop ');


    try{
  await  addressApi.saveAddress(address);
  if (title == 'To') {
    AppSession.instance.toAddresses.insert(0, address);
  } else {
    AppSession.instance.fromAddresses.insert(0,address);
  }
  Navigator.pop(context);
  } catch (error) {
  var errorMessage = ExceptionHandler.handleException(error);
  if (errorMessage == ExceptionHandler.KUnAuthorized) {
    errorMessage = ExceptionHandler.kInvalidCredentials;
  }
  Dialogs.showErrorDialog(errorMessage, context);
  setState(() {
    _isSaveing = false;
  });
  }

  }

  void _reset() {
    print('_reset ');

    nameController.text = 'full name ali';
    streetController.text = 'street ali';
    mobileController.text = '0569960717';
    buildingNumberController.text = '12';
    cityController.text = 'city1';
    townController.text = 'city1-town1';
    villageController.text = 'city1-town1-village1';
  }
}
