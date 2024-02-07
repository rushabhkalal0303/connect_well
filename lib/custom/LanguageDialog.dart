import 'package:connect_well/custom/titleTextView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../localization/languageTranslation.dart';
import '../utils/ResponsiveFlutter.dart';
import '../utils/colours.dart';
import '../utils/constant.dart';
import '../utils/dimens.dart';


class LanguageDialog extends StatefulWidget {
  String? selectedValue;
  bool isForLanguage = true;
  Function(String)? onDoneTap;

  LanguageDialog(
      {this.selectedValue,
      this.onDoneTap,
      required this.isForLanguage,
      Key? key})
      : super(key: key);

  @override
  _LanguageDialogState createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  String? selectedGroupValue;

  @override
  void initState() {
    super.initState();
    selectedGroupValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return dialogContent(context);
  }

  Widget dialogContent(BuildContext buildContext) {
    return Container(
      padding: EdgeInsets.all(Dimens.dimen_20dp),
      decoration: BoxDecoration(
        color: Color(whiteColor),
        borderRadius: BorderRadius.circular(Dimens.dimen_15dp),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  height: ResponsiveFlutter.of(context).scale(Dimens.dimen_5dp),
                  width: ResponsiveFlutter.of(context).scale(Dimens.dimen_45dp),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(greyBC)),
                ),
              ),
              SizedBox(
                height: ResponsiveFlutter.of(buildContext)
                    .verticalScale(Dimens.dimen_15dp),
              ),
              Container(
                alignment: Alignment.center,
                child: TitleTextView(
                  widget.isForLanguage
                      ? allTranslations.text(Languages)!
                      : allTranslations.text(selecteType)!,
                  fontSize:
                      ResponsiveFlutter.of(context).fontSize(Dimens.font_18dp),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: ResponsiveFlutter.of(buildContext)
                    .verticalScale(Dimens.dimen_15dp),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(
                            ResponsiveFlutter.of(buildContext)
                                .verticalScale(Dimens.dimen_10dp)),
                        height: ResponsiveFlutter.of(buildContext)
                            .verticalScale(Dimens.dimen_40dp),
                        width: ResponsiveFlutter.of(buildContext)
                            .verticalScale(Dimens.dimen_40dp),
                        child: Radio(
                            value: "English",
                            activeColor: Color(primaryColor),
                            groupValue: selectedGroupValue,
                            onChanged: (value) {
                              setState(() {
                                selectedGroupValue = value as String;
                                widget.onDoneTap!(selectedGroupValue!);
                              });
                              Future.delayed(Duration(milliseconds: 300))
                                  .then((value) {
                                Navigator.of(buildContext).pop();
                              });
                            }),
                      ),
                      Expanded(
                        child: TitleTextView(allTranslations.text(English)!),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(
                            ResponsiveFlutter.of(buildContext)
                                .verticalScale(Dimens.dimen_10dp)),
                        height: ResponsiveFlutter.of(buildContext)
                            .verticalScale(Dimens.dimen_40dp),
                        width: ResponsiveFlutter.of(buildContext)
                            .verticalScale(Dimens.dimen_40dp),
                        child: Radio(
                            value: "Hindi",
                            activeColor: Color(primaryColor),
                            groupValue: selectedGroupValue,
                            onChanged: (value) {
                              setState(() {
                                selectedGroupValue = value as String;
                                widget.onDoneTap!(selectedGroupValue!);
                                Future.delayed(
                                        const Duration(milliseconds: 300))
                                    .then((value) {
                                  setState(() {
                                    Navigator.pop(buildContext);
                                  });
                                });
                              });
                            }),
                      ),
                      Expanded(
                        child: TitleTextView(allTranslations.text(Hindi)!),
                      )
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
