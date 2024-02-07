import 'package:connect_well/custom/titleTextView.dart';
import 'package:connect_well/utils/ResponsiveFlutter.dart';
import 'package:connect_well/utils/colours.dart';
import 'package:connect_well/utils/dimens.dart';
import 'package:connect_well/utils/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/commonMethods.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    bool showFloatingActionButton = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 4,
        backgroundColor: Color(redappColor),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Stack(
          children: [
            Image.asset(AppImages.signViewVectors),
            Positioned(
              top: ResponsiveFlutter.of(context).scale(Dimens.dimen_65dp),
              left: ResponsiveFlutter.of(context).scale(Dimens.dimen_55dp),
              child: SvgPicture.asset(AppImages.companyWhiteLogo),
            ),
          ],
        ),
      ),
      body: newBuildBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: !showFloatingActionButton,
        child: Container(
          padding: EdgeInsets.only(
              left: ResponsiveFlutter.of(context).scale(Dimens.dimen_20dp),
              right: ResponsiveFlutter.of(context).scale(Dimens.dimen_20dp),
              bottom: ResponsiveFlutter.of(context).scale(Dimens.dimen_15dp)),
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
              if (isValid(emailController.text.trim(),
                  passwordController.text.trim(), context)) {

              }
            },
            child: Padding(
              padding: EdgeInsets.all(
                ResponsiveFlutter.of(context).scale(Dimens.dimen_10dp),
              ),
              child: TitleTextView(
                "Login",
                fontSize:
                    ResponsiveFlutter.of(context).fontSize(Dimens.font_20dp),
                color: Color(whiteColor),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget newBuildBody() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Color(redappColor),
      child: Container(
        decoration: BoxDecoration(
          color: Color(whiteColor),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(
              ResponsiveFlutter.of(context).scale(Dimens.dimen_25dp),
            ),
            topLeft: Radius.circular(
              ResponsiveFlutter.of(context).scale(Dimens.dimen_25dp),
            ),
          ),
        ),
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: ResponsiveFlutter.of(context)
                          .scale(Dimens.dimen_50dp),
                      right: ResponsiveFlutter.of(context)
                          .scale(Dimens.dimen_50dp),
                      top: ResponsiveFlutter.of(context)
                          .scale(Dimens.dimen_40dp)),
                  child: Column(
                    children: [
                      TitleTextView(
                        "Login",
                        color: Color(blackColor),
                        fontWeight: FontWeight.bold,
                        fontSize: ResponsiveFlutter.of(context)
                            .fontSize(Dimens.font_36dp),
                      ),
                      SizedBox(
                        height: ResponsiveFlutter.of(context)
                            .scale(Dimens.dimen_5dp),
                      ),
                      TitleTextView(
                        "Please fill your details to access your account",
                        fontSize: ResponsiveFlutter.of(context)
                            .fontSize(Dimens.font_18dp),
                        color: Color(lableTextColor),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
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
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black, // Color when focused
                            ),
                          ),
                          suffixIcon: SvgPicture.asset(
                            AppImages.icMailBox,
                          ),
                          suffixIconConstraints: BoxConstraints(
                            maxHeight: ResponsiveFlutter.of(context)
                                .scale(Dimens.dimen_25dp),
                            maxWidth: ResponsiveFlutter.of(context)
                                .scale(Dimens.dimen_25dp),
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
                      child: TextFormField(
                        controller: passwordController,
                        validator: (val) =>
                            val!.length < 6 ? 'Password too short.' : null,
                        // onSaved: (val) => _password = val,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Color(lableTextColor),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black, // Color when focused
                            ),
                          ),
                          suffixIcon: SvgPicture.asset(
                            AppImages.icEye,
                          ),
                          suffixIconConstraints: BoxConstraints(
                            maxHeight: ResponsiveFlutter.of(context)
                                .scale(Dimens.dimen_25dp),
                            maxWidth: ResponsiveFlutter.of(context)
                                .scale(Dimens.dimen_25dp),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(
                            top: ResponsiveFlutter.of(context)
                                .scale(Dimens.dimen_20dp),
                            right: ResponsiveFlutter.of(context)
                                .scale(Dimens.dimen_15dp)),
                        width: double.infinity,
                        child: TitleTextView(
                          "Forgot Password?",
                          textAlign: TextAlign.right,
                          color: Color(redappColor),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(whiteColor),
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                  color: Color(redappColor),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(ResponsiveFlutter.of(context)
                          .scale(Dimens.dimen_20dp)),
                      bottomRight: Radius.circular(ResponsiveFlutter.of(context)
                          .scale(Dimens.dimen_20dp)))),
              child: Stack(
                children: [
                  Image.asset(
                    AppImages.signViewVectors,
                  ),
                  Center(child: SvgPicture.asset(AppImages.companyWhiteLogo))
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(whiteColor),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(
                      ResponsiveFlutter.of(context).scale(Dimens.dimen_25dp),
                    ),
                    topLeft: Radius.circular(
                      ResponsiveFlutter.of(context).scale(Dimens.dimen_25dp),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: ResponsiveFlutter.of(context)
                              .scale(Dimens.dimen_50dp),
                          right: ResponsiveFlutter.of(context)
                              .scale(Dimens.dimen_50dp),
                          top: ResponsiveFlutter.of(context)
                              .scale(Dimens.dimen_40dp)),
                      child: Column(
                        children: [
                          TitleTextView(
                            "Login",
                            color: Color(blackColor),
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveFlutter.of(context)
                                .fontSize(Dimens.font_36dp),
                          ),
                          SizedBox(
                            height: ResponsiveFlutter.of(context)
                                .scale(Dimens.dimen_5dp),
                          ),
                          TitleTextView(
                            "Please fill your details to access your account",
                            fontSize: ResponsiveFlutter.of(context)
                                .fontSize(Dimens.font_18dp),
                            color: Color(lableTextColor),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
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
                              labelStyle:
                                  TextStyle(color: Color(lableTextColor)),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black, // Color when focused
                                ),
                              ),
                              suffixIcon: SvgPicture.asset(
                                AppImages.icMailBox,
                              ),
                              suffixIconConstraints: BoxConstraints(
                                maxHeight: ResponsiveFlutter.of(context)
                                    .scale(Dimens.dimen_25dp),
                                maxWidth: ResponsiveFlutter.of(context)
                                    .scale(Dimens.dimen_25dp),
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
                            obscureText: obscureText,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle:
                                  TextStyle(color: Color(lableTextColor)),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black, // Color when focused
                                ),
                              ),
                              suffixIcon: SvgPicture.asset(
                                AppImages.icEye,
                              ),
                              suffixIconConstraints: BoxConstraints(
                                maxHeight: ResponsiveFlutter.of(context)
                                    .scale(Dimens.dimen_25dp),
                                maxWidth: ResponsiveFlutter.of(context)
                                    .scale(Dimens.dimen_25dp),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(
                                top: ResponsiveFlutter.of(context)
                                    .scale(Dimens.dimen_20dp),
                                right: ResponsiveFlutter.of(context)
                                    .scale(Dimens.dimen_15dp)),
                            width: double.infinity,
                            child: TitleTextView(
                              "Forgot Password?",
                              textAlign: TextAlign.right,
                              color: Color(redappColor),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
