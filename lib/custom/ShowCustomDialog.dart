import 'titleTextView.dart';
import 'package:flutter/material.dart';

import '../utils/ResponsiveFlutter.dart';
import '../utils/colours.dart';
import '../utils/dimens.dart';

class ShowCustomDialog extends StatelessWidget {
  String title;
  String msg;
  String positiveTitle;
  String? negativeTitle;
  bool isDisplayImage = true;
  Function()? onPositivePressed;
  Function()? onNegativePressed;

  ShowCustomDialog(
    this.title,
    this.msg,
    this.positiveTitle,
    {
      this.negativeTitle,
      this.onPositivePressed,
      this.onNegativePressed,
      this.isDisplayImage = true
    }
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.dimen_10dp),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
      ),
      onWillPop: () async => false
    );
  }

  Widget dialogContent(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.dimen_10dp),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Dimens.dimen_20dp,
          horizontal: Dimens.dimen_10dp
        ),
        decoration: BoxDecoration(
          color: Color(whiteColor),
          borderRadius: BorderRadius.circular(Dimens.dimen_10dp),
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                /*Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: ResponsiveFlutter.of(context).scale(Dimens.dimen_10dp),
                    bottom: ResponsiveFlutter.of(context).scale(Dimens.dimen_10dp),
                  ),
                  decoration: BoxDecoration(
                    color: Color(fontColor),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimens.dimen_10dp),
                      topRight: Radius.circular(Dimens.dimen_10dp),
                    ),
                  ),
                  child: true ?
                  Image.asset(
                    ImagesName.LOGO,
                    height: ResponsiveFlutter.of(context).scale(Dimens.dimen_25dp),
                  ) :
                  TitleTextView(
                    title,
                    textAlign: TextAlign.center,
                    color: Color(whiteColor),
                  ),
                ),
                // SizedBox(height: Dimens.dimen_20dp),*/
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: ResponsiveFlutter.of(context).scale(Dimens.dimen_10dp),
                    horizontal: ResponsiveFlutter.of(context).scale(Dimens.dimen_10dp)
                  ),
                  child: TitleTextView(
                    (msg!=null) ?
                    msg :
                    "",
                    textAlign: TextAlign.center,
                    color: Color(fontColor),
                  ),
                ),
                SizedBox(height: Dimens.dimen_10dp),
                // Divider(
                //   height: Dimens.dimen_1dp,
                //   color: Color(fontColor),
                // ),
                Container(
                  padding: EdgeInsets.only(
                    top: ResponsiveFlutter.of(context).scale(Dimens.dimen_5dp),
                    bottom: ResponsiveFlutter.of(context).scale(Dimens.dimen_5dp),
                    left: ResponsiveFlutter.of(context).scale(Dimens.dimen_15dp),
                    right: ResponsiveFlutter.of(context).scale(Dimens.dimen_15dp),
                  ),
                  decoration: BoxDecoration(
                    // color: Color(fontColor),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Dimens.dimen_10dp),
                      bottomRight: Radius.circular(Dimens.dimen_10dp),
                    ),
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment:  negativeTitle!=null && negativeTitle!.isNotEmpty ?
                      MainAxisAlignment.spaceEvenly :
                      MainAxisAlignment.center,
                      children: <Widget>[
                        negativeTitle!=null && negativeTitle!.isNotEmpty ?
                        Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: onNegativePressed,
                              child: Container(
                                padding: EdgeInsets.all(
                                  ResponsiveFlutter.of(context).scale(Dimens.dimen_10dp)
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimens.dimen_10dp),
                                  border: Border.all(
                                    color: Color(primaryColor),
                                    width: Dimens.dimen_1dp
                                  )
                                ),
                                alignment: Alignment.center,
                                child: TitleTextView(
                                  negativeTitle!,
                                  color: Color(primaryColor),
                                  textAlign: TextAlign.center,
                                  fontSize: ResponsiveFlutter.of(context).fontSize(Dimens.font_15dp)
                                ),
                              ),
                            )
                        ) : Container(),
                        /*Visibility(
                          visible: negativeTitle!=null && negativeTitle!.isNotEmpty,
                          child: VerticalDivider(
                            width: Dimens.dimen_1dp,
                            color: Color(whiteColor),
                          ),
                        ),*/
                        Visibility(
                          visible: negativeTitle!=null && negativeTitle!.isNotEmpty,
                          child: SizedBox(
                            width: Dimens.dimen_15dp,
                          ),
                        ),
                        Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: onPositivePressed,
                              child: Container(
                                padding: EdgeInsets.all(
                                    ResponsiveFlutter.of(context).scale(Dimens.dimen_10dp)
                                ),
                                decoration: BoxDecoration(
                                  color: Color(redappColor),
                                  borderRadius: BorderRadius.circular(Dimens.dimen_10dp),
                                ),
                                alignment: Alignment.center,
                                child: TitleTextView(
                                  positiveTitle,
                                  color: Color(whiteColor),
                                  textAlign: TextAlign.center,
                                  fontSize: ResponsiveFlutter.of(context).fontSize(Dimens.font_15dp)
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}

