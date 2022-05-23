import 'dart:core';

import 'package:flutter/widgets.dart';

enum AddressDataState { fresh, saving, saved }

class AddressProvider with ChangeNotifier {
  AddressDataState addressDataState = AddressDataState.fresh;

  Future<void> saveAddress(String name) async {
    addressDataState = AddressDataState.saving;
    await Future.delayed(const Duration(seconds: 100));
    addressDataState = AddressDataState.saved;
    notifyListeners();
  }
}
