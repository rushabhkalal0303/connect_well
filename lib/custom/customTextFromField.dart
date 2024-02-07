import 'package:flutter/material.dart';

import '../utils/ResponsiveFlutter.dart';
import '../utils/colours.dart';
import '../utils/dimens.dart';

class CustomEditBox extends StatelessWidget {
  final String labelText;

  const CustomEditBox({Key? key, required this.labelText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: ResponsiveFlutter.of(context).scale(Dimens.dimen_15dp),
        left: ResponsiveFlutter.of(context).scale(Dimens.dimen_20dp),
        right: ResponsiveFlutter.of(context).scale(Dimens.dimen_20dp),
      ),
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Color(lableTextColor)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black, // Color when focused
            ),
          ),
        ),
      ),
    );
  }
}