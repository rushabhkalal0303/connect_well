import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/ResponsiveFlutter.dart';
import '../utils/colours.dart';
import '../utils/constant.dart';
import '../utils/dimens.dart';



class CustomEditBox extends StatelessWidget {
  final String? countryCode;
  final bool isCountryCodeRequired;
  final bool autoFocus;
  final bool enabled;
  final bool obscureText;
  int? maxLines, maxLength;

  TextInputType? textInputType = TextInputType.text;
  TextInputAction? textInputAction;
  final TextEditingController? textEditingController;
  TextCapitalization textCapitalization;
  List<TextInputFormatter>? inputFormatter;

  Function(String)? onChanged;
  FocusNode? focusNode;
  Function()? onEditingComplete;
  String? hintText;
  double? fontSize;
  Color borderColor;
  Color? fontColour;
  Color? hintColor;
  Color? bgColor;
  String labelText;
  double borderRadius;
  TextAlign textAlign;
  String? fontName;
  FontWeight? hintFontWeight;
  FontWeight? fontWeight;
  bool isDense;
  bool readOnly;
  Function()? onTap;
  Widget? prefix;
  Widget? suffix;
  bool enableInteractiveSelection;
  bool ismandatory;
  OutlineInputBorder? focus;
  Color? cursorColor;
  EdgeInsetsGeometry? contentPadding;

  CustomEditBox(
      {this.autoFocus = false,
      this.isCountryCodeRequired = false,
      this.enabled = true,
      this.cursorColor,
      this.obscureText = false,
      this.maxLines,
      this.focus,
      this.fontWeight,
      this.maxLength,
      this.hintFontWeight,
      this.textInputType,
      this.textInputAction,
      this.textEditingController,
      this.countryCode,
      this.textCapitalization = TextCapitalization.none,
      this.inputFormatter,
      this.onChanged,
      this.focusNode,
      this.onEditingComplete,
      this.hintText = "",
      this.labelText = "",
      this.fontSize,
      this.borderColor = Colors.white,
      this.fontColour,
      this.bgColor,
      this.hintColor,
      this.borderRadius = 10,
      this.textAlign = TextAlign.left,
      this.fontName,
      this.isDense = true,
      this.readOnly = false,
      this.onTap,
      this.prefix,
      this.suffix,
      this.contentPadding,
      this.enableInteractiveSelection = true,
      this.ismandatory = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextField(
      scrollPadding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20),
      enableInteractiveSelection: enableInteractiveSelection,
      keyboardType: textInputType,
      inputFormatters: inputFormatter,
      textAlign: textAlign != null ? textAlign : TextAlign.left,
      autofocus: autoFocus,
      enabled: enabled,
      readOnly: readOnly,
      cursorColor: cursorColor != null ? cursorColor : Colors.blue,
      obscureText: obscureText,
      maxLines: maxLines,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      controller: textEditingController,
      maxLength: maxLength,
      decoration: InputDecoration(
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
                horizontal:
                    ResponsiveFlutter.of(context).scale(Dimens.dimen_16dp),
                vertical:
                    ResponsiveFlutter.of(context).scale(Dimens.dimen_12dp)),

        // suffix: suffix,
        suffixIconConstraints: BoxConstraints(
          minHeight: 24,
          minWidth: 24,
        ),
        suffixIcon: suffix,
        prefixIcon: prefix,
        isDense: isDense,
        // contentPadding: EdgeInsets.only(
        //     left: ResponsiveFlutter.of(context).scale(Dimens.dimen_20dp)),
        filled: bgColor != null ? true : false,
        fillColor: bgColor != null ? bgColor : Colors.red,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                borderRadius != null ? borderRadius : Dimens.dimen_10dp),
            borderSide: BorderSide(
                color: borderColor == null
                    ? Color(borderGreyColor)
                    : borderColor)),
        focusedBorder: focus != null
            ? focus
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    borderRadius != null ? borderRadius : Dimens.dimen_10dp),
                borderSide: BorderSide(
                    color: borderColor == null
                        ? Color(borderGreyColor)
                        : borderColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                borderRadius != null ? borderRadius : Dimens.dimen_10dp),
            borderSide: BorderSide(
                color: borderColor == null
                    ? Color(borderGreyColor)
                    : borderColor)),
        counterText: "",
        hintText: hintText,
        hintStyle: TextStyle(
            color: hintColor == null ? Color(borderGreyColor) : hintColor,
            fontFamily: fontName != null ? fontName : FontName.InterRegular,
            fontWeight:
                hintFontWeight != null ? hintFontWeight : FontWeight.normal),
        labelText: labelText != null && labelText.isNotEmpty ? labelText : null,
        labelStyle: labelText != null && labelText.isNotEmpty
            ? TextStyle(
                color: fontColour == null ? Color(fontColor) : fontColour,
                fontWeight: FontWeight.w500,
                fontSize: ResponsiveFlutter.of(context)
                    .fontSize(Dimens.edit_font_15dp),
                fontFamily: FontName.InterMedium)
            : null,
      ),
      style: TextStyle(
        fontWeight: fontWeight != null ? fontWeight : FontWeight.w500,
        fontSize: fontSize != null
            ? fontSize
            : ResponsiveFlutter.of(context).fontSize(Dimens.edit_font_15dp),
        color: fontColour == null ? Color(secondPrimaryColor) : fontColour,
        fontFamily: fontName != null ? fontName : FontName.InterRegular,
        height: 1.2,
      ),
      expands: false,
      focusNode: focusNode,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onTap: onTap,
    ));
  }
}
