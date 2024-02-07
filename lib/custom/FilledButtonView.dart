import 'package:flutter/material.dart';

import '../utils/ResponsiveFlutter.dart';
import '../utils/colours.dart';
import '../utils/constant.dart';
import '../utils/dimens.dart';



class FilledButtonView extends StatelessWidget {
  FilledButtonView(this.text,
      {this.onPressed,
      this.fontFamily,
      this.isDisable = false,
      this.color,
      this.textColor,
      this.disabledColor,
      this.padding = 16,
      this.fontWeight = FontWeight.w500,
      this.horizontalPadding = 16,
      this.borderRad = 15});

  final String text;
  bool isDisable = false;
  Function()? onPressed;
  String? fontFamily = FontName.InterRegular;
  FontWeight? fontWeight = FontWeight.w500;
  Color? color = Color(primaryColor);
  Color? textColor = Color(whiteColor);
  Color? disabledColor = Color(primaryColor);
  double padding = Dimens.dimen_16dp;
  double horizontalPadding = Dimens.dimen_16dp;
  double borderRad = Dimens.dimen_15dp;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              borderRad != null ? borderRad : Dimens.dimen_15dp),
        ),
        backgroundColor: color == null ? Color(primaryColor) : color,
        disabledBackgroundColor:
            disabledColor == null ? Color(primaryColor) : disabledColor,
        padding: EdgeInsets.fromLTRB(
            horizontalPadding, padding, horizontalPadding, padding),
      ),
      onPressed: (isDisable != null && isDisable) ? null : onPressed,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: ResponsiveFlutter.of(context).fontSize(Dimens.font_15dp),
            color: (isDisable != null && isDisable)
                ? Color(whiteColor)
                : textColor != null
                    ? textColor
                    : Color(whiteColor),
            fontWeight: fontWeight,
            fontFamily:
                (fontFamily == null) ? FontName.InterRegular : fontFamily),
      ),
    );
  }
}
