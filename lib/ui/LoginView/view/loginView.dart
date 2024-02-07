import 'package:connect_well/custom/customEditBox.dart';
import 'package:connect_well/custom/notification_serviced.dart';
import 'package:connect_well/custom/titleTextView.dart';
import 'package:connect_well/ui/LoginView/helpers/loginScreenHelpers.dart';
import 'package:connect_well/ui/SignupView/view/signupView.dart';
import 'package:connect_well/utils/ResponsiveFlutter.dart';
import 'package:connect_well/utils/colours.dart';
import 'package:connect_well/utils/commonMethods.dart';
import 'package:connect_well/utils/dimens.dart';
import 'package:connect_well/utils/image_constants.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  NotificationServices notificationServices = NotificationServices();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    // notificationServices.requestNotificationPermission();
    // notificationServices.getDeviceToken().then((value) {
    //   print("Device Token is ${value}");
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool showFlotingActionButton =
        MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: buildBody(),
      floatingActionButton: Visibility(
        visible: !showFlotingActionButton,
        child: Container(
          margin: EdgeInsets.only(
              bottom: ResponsiveFlutter.of(context).scale(Dimens.dimen_50dp)),
          child: RichText(
            text: TextSpan(
              text: "Don't have an account? ",
              style: TextStyle(
                color: Color(lableTextColor),
                fontSize: ResponsiveFlutter.of(context)
                    .fontSize(Dimens.edit_font_15dp),
              ),
              children: [
                TextSpan(
                  text: "Create Now",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: ResponsiveFlutter.of(context)
                        .fontSize(Dimens.edit_font_15dp),
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      CallNextScreen(context, SignUpView());
                    },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildBody() {
    return SafeArea(
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: ResponsiveFlutter.of(context)
                            .scale(Dimens.dimen_35dp),
                      ),
                      child: SvgPicture.asset(AppImages.loginScreenBackground),
                    ),
                    Positioned(
                      top: ResponsiveFlutter.of(context)
                          .scale(Dimens.dimen_150dp),
                      left: ResponsiveFlutter.of(context)
                          .scale(Dimens.dimen_75dp),
                      child: SvgPicture.asset(
                        AppImages.companyLogo,
                        width: ResponsiveFlutter.of(context)
                            .scale(Dimens.dimen_180dp), // Set the desired width
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 0,
                ),
                TitleTextView(
                  "Login",
                  fontWeight: FontWeight.bold,
                  color: Color(blackColor),
                  fontSize:
                      ResponsiveFlutter.of(context).fontSize(Dimens.font_36dp),
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: ResponsiveFlutter.of(context)
                            .scale(Dimens.dimen_50dp),
                        right: ResponsiveFlutter.of(context)
                            .scale(Dimens.dimen_50dp),
                      ),
                      child: Center(
                        child: TitleTextView(
                          fontSize: ResponsiveFlutter.of(context)
                              .fontSize(Dimens.font_18dp),
                          "Please fill your detail to access your active directory.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: ResponsiveFlutter.of(context)
                            .scale(Dimens.dimen_15dp),
                        left: ResponsiveFlutter.of(context)
                            .scale(Dimens.dimen_20dp),
                        right: ResponsiveFlutter.of(context)
                            .scale(Dimens.dimen_20dp),
                      ),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Color(lableTextColor)),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black, // Color when focused
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: ResponsiveFlutter.of(context)
                            .scale(Dimens.dimen_15dp),
                        left: ResponsiveFlutter.of(context)
                            .scale(Dimens.dimen_20dp),
                        right: ResponsiveFlutter.of(context)
                            .scale(Dimens.dimen_20dp),
                      ),
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Color(lableTextColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black, // Color when focused
                            ),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {},
                            child: TitleTextView(
                              "Forgot?",
                              color: Color(redappColor),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          suffixIconConstraints: BoxConstraints(
                            maxHeight: ResponsiveFlutter.of(context)
                                .scale(Dimens.dimen_25dp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height:
                      ResponsiveFlutter.of(context).scale(Dimens.dimen_20dp),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left:
                        ResponsiveFlutter.of(context).scale(Dimens.dimen_20dp),
                    right:
                        ResponsiveFlutter.of(context).scale(Dimens.dimen_20dp),
                  ),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(redappColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          ResponsiveFlutter.of(context).scale(Dimens.dimen_6dp),
                        ),
                      ),
                    ),
                    onPressed: () {
                      FlutterError.onError =
                          FirebaseCrashlytics.instance.recordFlutterError;
                      if (isValid(emailController.text.trim(),
                          passwordController.text.trim(), context)) {
                        print("READY FOR HOME PAGE");
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(
                        ResponsiveFlutter.of(context).scale(Dimens.dimen_10dp),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: ResponsiveFlutter.of(context)
                              .fontSize(Dimens.font_20dp),
                          color: Color(whiteColor)
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
