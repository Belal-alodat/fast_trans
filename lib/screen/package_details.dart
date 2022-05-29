import 'package:fast_trans/models/package.dart';
import 'package:fast_trans/rest/address_api.dart';
import 'package:flutter/material.dart';

import '../core/app_session.dart';
import '../rest/package_api.dart';
import '../util/dialogue.dart';
import '../util/exception_handler.dart';
import '../util/widget_util.dart';
import '../widget/card_with_colored_edge.dart';
import '../widget/round_elevated_button.dart';
import '../widget/round_text_field.dart';

class PackageDetailsPage extends StatefulWidget {
  @override
  _PackageDetailsState createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetailsPage> {
  bool _isSaveing = false;
  bool _isFav = false;
  final TextEditingController priceController = TextEditingController();
  final TextEditingController piecesController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController productController = TextEditingController();
  final TextEditingController dimensionController = TextEditingController();
  Map<String, Product> products = {};
  Map<String, Dimension> dimensions = {};
  PackageAPI packageAPI =   PackageAPI(AppSession.instance.token);
  @override
  void didChangeDependencies() {
    print('didChangeDependencies');

  }

  List<String> productList = [];
  List<String> dimensionList = [];
  Widget build(BuildContext context) {
    products = AppSession.instance.products;
    dimensions = AppSession.instance.dimensions;
    productList = AppSession.instance.productList ;//products.keys.map((e) => e).toList();
    dimensionList = AppSession.instance.dimensionList;  //dimensions.keys.map((e) => e).toList();

    final title = ModalRoute.of(context)!.settings.arguments as String;
    double height = 150.0;
    Direction direction = AppSession.instance.languageCode == 'ar'
        ? Direction.left
        : Direction.right;

    return Scaffold(
      appBar: AppBar(title: WidgetUtil.text('Create Package', color: Colors.white)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: CardWithColoredEdge(
            isRedEdge: false,
            620,
            Colors.blue.shade900,
            Colors.red,
            direction,
            getWidget(),
          ),
        ),
      ),
    );
  }


  Widget getWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
      child: Column(
        children: [
          // WidgetUtil.buildTextField('Full Name', nameController),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  print('isFav=$_isFav');
                  setState(() {
                    _isFav = !_isFav;
                  });
                },
                child: Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  // padding: const EdgeInsets.fromLTRB(0, 0, 15, 25),
                  //    color: Colors.black,

                  child: Icon(
                    Icons.favorite,
                    color: _isFav ? Colors.red :Colors.white70,
                    //size: 30,

                  ),
                  //  color: Colors.black,
                ),
              ),
            ],
          ),
          WidgetUtil.buildTextField('price', priceController),
          WidgetUtil.buildTextField('weight', weightController),
          WidgetUtil.buildTextField('pieces', piecesController),
          WidgetUtil.buildTextField(
            'product',
            productController,
            isDrop: true,
            items: productList,
            onSelected: (String value) {
              if (value == productController.text) return;
              setState(() {
                print('setState');
                productController.text = value;
              });
            },
          ),
          WidgetUtil.buildTextField(
            'dimension',
            dimensionController,
            isDrop: true,
            items: dimensionList,
            onSelected: (String value) {
              if (value == dimensionController.text) return;
              setState(() {
                print('setState');
                dimensionController.text = value;
              });

            },
          ),
          // WidgetUtil.buildTextField('map', nameController),
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
                      child: WidgetUtil.getButtonText('Reset',35),
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

  void _submit() async {
    setState(() {
      _isSaveing = true;
    });
    print('_submit ');
    String priceStr = priceController.text;
    String piecesStr = piecesController.text;
    String weightStr = weightController.text;
    String productStr = productController.text;
    String dimensionStr = dimensionController.text;


    double weight = 0.0;
    try{
      weight = double.parse(weightStr);
    }catch(e){}

    double price = 0.0;
    try{
      price = double.parse(priceStr);
    }catch(e){}
    int pieces = 0;
    try{
      pieces = int.parse(piecesStr);
    }catch(e){}

    Package package =  Package(favourite:_isFav ,dimension:dimensions[dimensionStr]!,product:products[productStr]!,weight: weight,id: -1,price: price,pieces: pieces  );



    try{
      if(_isFav) await  packageAPI.savePackage(package);
      AppSession.instance.packages.insert(0,package);
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

    priceController.text = '1';
    piecesController.text = '2';
    weightController.text = '2';
    productController.text = 't';
    dimensionController.text = 't';

  }
}
