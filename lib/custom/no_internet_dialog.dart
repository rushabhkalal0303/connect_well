import 'package:connect_well/custom/titleTextView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/ResponsiveFlutter.dart';
import '../utils/colours.dart';
import '../utils/commonMethods.dart';
import '../utils/constant.dart';
import '../utils/dimens.dart';
import '../utils/image_constants.dart';
import 'FilledButtonView.dart';

class NoInternetDialog extends StatelessWidget {
  NoInternetDialog(this.onRetryPressed);

  Function()? onRetryPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImages.noInternetConnection,
            height: 250,
          ),
          SizedBox(height: 20),
          TitleTextView(
            'No Internet Connection!',
            fontSize: ResponsiveFlutter.of(context).fontSize(Dimens.font_24dp),
            fontName: FontName.InterBold,
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TitleTextView(
              'Your internet connection is down. please fix it and then you can continue using ${CommonValues.appName}',
              textAlign: TextAlign.center,
              fontSize:
                  ResponsiveFlutter.of(context).fontSize(Dimens.font_18dp),
              color: Color(greyColor5),
              fontName: FontName.InterRegular,
              height: 1.2,
            ),
          ),
          SizedBox(height: 40),
          FilledButtonView(
            "Retry",
            fontWeight: FontWeight.w600,
            color: Color(primaryColor),
            textColor: Color(whiteColor),
            onPressed: () async {
              bool hasInternet = await isInternetAvailable();
              if (hasInternet) {
                onRetryPressed!();
              }
            },
            horizontalPadding: 40,
            borderRad: ResponsiveFlutter.of(context).scale(Dimens.dimen_100dp),
          ),
        ],
      ),
    );
  }
}
