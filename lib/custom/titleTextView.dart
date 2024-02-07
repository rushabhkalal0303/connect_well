import 'package:flutter/material.dart';

import '../utils/ResponsiveFlutter.dart';
import '../utils/colours.dart';
import '../utils/constant.dart';
import '../utils/dimens.dart';

class TitleTextView extends StatelessWidget {
  TitleTextView(
      this.text,
      {
        this.textAlign,
        this.color,
        this.fontName,
        this.fontSize,
        this.softWrap =true,
        this.maxLines,
        this.fontWeight,
        this.height = 1.5,
        this.textOverflow,
        this.key,
        this.shouldHaveUnderline = false
      }
    );

  final String text;
  TextAlign?  textAlign = TextAlign.left;
  Color? color = Color(fontColor);
  String? fontName = FontName.InterRegular;
  double? fontSize = Dimens.dimen_16dp;
  bool softWrap = true;
  int? maxLines;
  FontWeight? fontWeight;
  double? height;
  TextOverflow? textOverflow;
  GlobalKey? key;
  bool shouldHaveUnderline = false;

  @override
  Widget build(BuildContext context) {
      return Text(
        text,
        key: key,
        textAlign:textAlign,
        overflow: textOverflow!=null ? textOverflow : TextOverflow.clip,
        softWrap: softWrap,
        maxLines: maxLines,
        style: TextStyle(
            color: (color == null) ? Color(fontColor) : color,
            fontSize: (fontSize == null) ? ResponsiveFlutter.of(context).fontSize(1.7) : fontSize,
            decoration: shouldHaveUnderline ? TextDecoration.underline : TextDecoration.none,//TextDecoration.none ,
            fontFamily: fontName != null ? fontName : FontName.InterRegular,
            fontWeight: fontWeight != null ? fontWeight : null,
            height: height!=null ? height : 1.5,

        ),
      );
  }
}