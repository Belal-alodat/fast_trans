import 'package:flutter/material.dart';

class ItemMenuType {
  String _title, _imageTitle;
  bool _isSelected;
  final String _pageDetailsName;

  ItemMenuType.name(
      this._title, this._isSelected, this._imageTitle, this._pageDetailsName);

  ItemMenuType(
      this._title, this._isSelected, this._imageTitle, this._pageDetailsName);

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
  }

  String get title => _title;

  String get pageDetailsName => _pageDetailsName;

  set title(String value) {
    _title = value;
  }

  get imageTitle => _imageTitle;

  set imageTitle(value) {
    _imageTitle = value;
  }
}

class ItemsMenueCards extends StatelessWidget {
  //final ItemType policyType;
  final List<ItemMenuType> itemTypeList;
  final int index;
  ItemsMenueCards(this.itemTypeList, this.index);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    print('height $height width $width');
    bool isSelected = itemTypeList[index].isSelected;
    String title = itemTypeList[index].title;
    String imageTitle = itemTypeList[index].imageTitle;
    return CardMenu(
        isSelected: isSelected,
        imageTitle: imageTitle,
        title: title,
        textScaleFactor: textScaleFactor);
  }
}

class CardMenu extends StatelessWidget {
  const CardMenu({
    Key? key,
    required this.isSelected,
    required this.imageTitle,
    required this.title,
    required this.textScaleFactor,
  }) : super(key: key);

  final bool isSelected;
  final String imageTitle;
  final String title;
  final double textScaleFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      //  color: Colors.blueGrey,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          decoration: BoxDecoration(
            border: isSelected
                ? Border.all(
                    width: 4,
                    // color: MyColor.TxtColorOrange,
                    color: Colors.red)
                : Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Image.asset(
            imageTitle,
            // width: MediaQuery.of(context).size.width / 12,
            //  height: MediaQuery.of(context).size.width / 12,
            fit: BoxFit.fill,
          ),
          /*child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  imageTitle,
                  // width: MediaQuery.of(context).size.width / 12,
                  //  height: MediaQuery.of(context).size.width / 12,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                  color: Colors.blue,
                  height: MediaQuery.of(context).size.width * .1,
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        // color: MyColor.loginTxtColor,
                        color: Colors.red,
                        letterSpacing: -0.05,
                        fontSize: 14 / textScaleFactor,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
            ],
          ),*/
        ),
      ),
    );
  }
}
