import 'package:flutter/material.dart';

class Multi_profile_tile extends StatelessWidget {
  Multi_profile_tile(String? people);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text("_person.name"),
      subtitle: Text("세"),
    );
  }
}

class PersonHandIcon extends StatelessWidget {
  PersonHandIcon(this._isLeftHand);

  final bool _isLeftHand;

  @override
  Widget build(BuildContext context) {
    if (_isLeftHand)
      return Icon(Icons.arrow_left);
    else
      return Icon(Icons.arrow_right);
  }
}
