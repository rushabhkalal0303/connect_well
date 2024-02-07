import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../custom/ShowCustomDialog.dart';
import '../custom/titleTextView.dart';
import '../localization/languageTranslation.dart';

import '../ui/LoginView/view/loginView.dart';
import 'ResponsiveFlutter.dart';
import 'colours.dart';

import 'constant.dart';
import 'dimens.dart';
import 'image_constants.dart';
import 'package:http/http.dart' as http;

DateTime selectedDate = DateTime.now();
String formattedDate = "";
DateTime? chosenDateTime;
BuildContext? _progressContext;
ValueNotifier<bool> notificationCount = ValueNotifier<bool>(false);
NumberFormat numberFormat = NumberFormat.decimalPattern('hi');

bool isIFSCCodeValidated(String number) {
  RegExp regExp = RegExp(
    r"^[A-Z]{4}0[A-Z0-9]{6}$",
    caseSensitive: false,
    multiLine: false,
  );
  return regExp.hasMatch(number);
}

bool isValid(
    String emailString, String passwordString, BuildContext context) {
  if (emailString.isEmpty) {
    showCustomDialog(context, CommonValues.appName,
        "Please enter email address", false, "Okay", "");
    return false;
  } else if (!isValidEmail(emailString)) {
    showCustomDialog(context, CommonValues.appName,
        "Please enter valid email address", false, "Okay", "");
    return false;
  } else if (passwordString.isEmpty) {
    showCustomDialog(context, CommonValues.appName, "Please enter password",
        false, "Okay", "");
    return false;
  }
  return true;
}

bool isPanCardNumberFormatValidated(String number) {
  RegExp regExp = new RegExp(
    r"[A-Z]{5}[0-9]{4}[A-Z]{1}",
    caseSensitive: false,
    multiLine: false,
  );
  return regExp.hasMatch(number);
}

void CallNextScreen(BuildContext context, StatefulWidget nextScreen) {
  // AnalyticsService().setEventName(nextScreen.toStringShort());
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => nextScreen,
          settings: RouteSettings(name: nextScreen.toString())));
}

void CallNextScreenClearOld(BuildContext context, StatefulWidget nextScreen) {
  // AnalyticsService().setEventName(nextScreen.toStringShort());
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
        builder: (context) => nextScreen,
        settings: RouteSettings(name: nextScreen.toString())),
  );
}

void CallNextScreenAndClearStack(
    BuildContext context, StatefulWidget nextScreen) {
  //AnalyticsService().setEventName(nextScreen.toStringShort());
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (context) => nextScreen,
          settings: RouteSettings(name: nextScreen.toString())),
      (Route<dynamic> route) => false);
}

Future CallNextScreenWithResult(
    BuildContext context, StatefulWidget nextScreen) async {
  // AnalyticsService().setEventName(nextScreen.toStringShort());
  var action = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => nextScreen,
          settings: RouteSettings(name: nextScreen.toString())));

  return action;
}

void printLog(String msg) {
  print(msg);
}

SizedBox heightSizedBox(double height) {
  return SizedBox(
    height: height,
  );
}

SizedBox widthSizedBox(double width) {
  return SizedBox(
    width: width,
  );
}

customDotIndicator(
    int currentIndex, int totalIndex, BuildContext context, int colorCode) {
  return SizedBox(
    height: ResponsiveFlutter.of(context).scale(Dimens.dimen_8dp),
    child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return currentIndex == index + 1
              ? Container(
                  height: ResponsiveFlutter.of(context).scale(Dimens.dimen_8dp),
                  width: ResponsiveFlutter.of(context).scale(Dimens.dimen_16dp),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                      color: Color(primaryColor)),
                )
              : Container(
                  height: ResponsiveFlutter.of(context).scale(Dimens.dimen_8dp),
                  width: ResponsiveFlutter.of(context).scale(Dimens.dimen_8dp),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(colorCode).withOpacity(0.2)),
                );
        },
        separatorBuilder: (context, index) {
          return widthSizedBox(
              ResponsiveFlutter.of(context).scale(Dimens.dimen_7dp));
        },
        itemCount: totalIndex),
  );
}

AppBar commonAppBar(
  BuildContext context, {
  Color? bgColor,
  Color? fontColor,
  IconData? leadingIcon,
  String? leadingImage,
  String? toolbarTitle,
  Widget? toolbarWidget,
  Function()? onLeadingPressed,
  Function()? onCloseTap,
  List<Widget>? actions,
  Color? leadingIconColor,
  double? elevation,
  bool shouldGradientColor = false,
  GlobalKey? gKey,
}) {
  return AppBar(
    backgroundColor: bgColor,
    elevation: elevation != null ? elevation : Dimens.dimen_0dp,
    automaticallyImplyLeading: leadingIcon != null,
    // brightness: Brightness.dark,
    leading: leadingIcon != null || leadingImage != null
        ? GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              alignment: Alignment.center,
              child: leadingIcon != null
                  ? Icon(
                      leadingIcon,
                      color: leadingIconColor != null
                          ? leadingIconColor
                          : Color(primaryColor),
                      size: ResponsiveFlutter.of(context)
                          .scale(Dimens.dimen_24dp),
                    )
                  : leadingImage != null
                      ? Wrap(
                          children: [
                            SvgPicture.asset(
                              leadingImage,
                              key: gKey,
                            )
                          ],
                        )
                      : null,
            ),
            onTap: onLeadingPressed,
          )
        : null,
    title: toolbarWidget != null
        ? toolbarWidget
        : (toolbarTitle != null && toolbarTitle.isNotEmpty)
            ? TitleTextView(
                toolbarTitle,
                color:
                    fontColor != null ? fontColor : Color(secondPrimaryColor),
                fontSize:
                    ResponsiveFlutter.of(context).fontSize(Dimens.font_18dp),
                fontName: FontName.InterBold,
                fontWeight: FontWeight.w700,
              )
            : Container(),
    // Image.asset(
    //   ImagesName.LOGO,
    //   width: ResponsiveFlutter.of(context).scale(Dimens.dimen_100dp),
    // ),
    actions: actions != null ? actions : null,
    centerTitle: true,
    flexibleSpace: shouldGradientColor
        ? Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                  0.37,
                  1
                ],
                    colors: <Color>[
                  Color(primaryColor),
                  Color(primaryColor),
                ])),
          )
        : Container(),
  );
}

bool isValidEmail(String email) {
  // Regular expression for a simple email validation
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  return emailRegex.hasMatch(email);
}

void showCustomDialog(BuildContext context, String title, String content,
    bool hasSecondButton, String positiveText, String negativeText,
    {Function()? onPositiveClick,
    Function()? onNegativeClick,
    Function(BuildContext)? onRetakeAction,
    bool isDisplayImage = false}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return ShowCustomDialog(
          title,
          content,
          positiveText,
          onPositivePressed: () {
            Navigator.of(ctx).pop();
            if (onRetakeAction != null) {
              onRetakeAction(ctx);
            }
          },
          negativeTitle: negativeText,
          onNegativePressed: () {
            Navigator.of(ctx).pop();
            if (onNegativeClick != null) {
              onNegativeClick();
            }
          },
          isDisplayImage: isDisplayImage,
        );
      });
}

iosDatePicker(BuildContext context, Function(String, DateTime) onCallBack,
    DateTime? inputDate) async {
  inputDate != null ? selectedDate = inputDate : null;
  showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height * 0.3,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  onCallBack(formattedDate, chosenDateTime!);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.only(
                    right:
                        ResponsiveFlutter.of(context).scale(Dimens.dimen_10dp),
                    top: ResponsiveFlutter.of(context).scale(Dimens.dimen_3dp),
                    left:
                        ResponsiveFlutter.of(context).scale(Dimens.dimen_10dp),
                  ),
                  child: TitleTextView(
                    "Done",
                    fontSize: ResponsiveFlutter.of(context)
                        .fontSize(Dimens.font_20dp),
                    fontWeight: FontWeight.w600,
                    color: Color(blackColor),
                  ),
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (value) {
                    chosenDateTime = value;
                    if (chosenDateTime != null) {
                      formattedDate =
                          DateFormat('dd/MM/yyyy').format(chosenDateTime!);
                    }
                    print(formattedDate);
                  },
                  initialDateTime: selectedDate,
                  minimumYear: 1900,
                  maximumYear: selectedDate.year,
                ),
              ),
            ],
          ),
        );
      });
}

Future<bool> isInternetAvailable() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}

String convertIntoSpecificFormat(
    String value, String inputFormat, String outputFormat) {
  if (value.isEmpty) return "";
  String outputValue = value;
  try {
    DateFormat dateFormat = new DateFormat(inputFormat);
    dateFormat.locale;
    outputValue = new DateFormat(outputFormat)
        .format(new DateFormat(inputFormat).parse(value).toLocal());
  } on Exception catch (e) {
    print(e);
  }
  return outputValue;
}

void hideProgressDialog() {
  if (_progressContext != null) {
    Navigator.of(_progressContext!).pop(true);
    _progressContext = null;
  }
}

void showProgressbarDialog(BuildContext context,
    {Color? loaderColor, String? text}) {
  if (_progressContext == null) {
    displayProgressDialog(
        context: context,
        barrierDismissible: false,
        builder: (con) {
          _progressContext = con;
          return WillPopScope(
              onWillPop: () async => false,
              child: Center(
                child: Container(
                  child: SpinKitWave(
                    color: Color(whiteColor),
                  ),
                ),
              ));
        });
  }
}

double calculatePercentage(double percentage, double totalValue) {
  return (percentage / 100) * totalValue;
}

Future<T?>? displayProgressDialog<T>(
    {@required BuildContext? context,
    bool barrierDismissible = true,
    Widget? child,
    WidgetBuilder? builder,
    bool useRootNavigator = true}) {
  assert(child == null || builder == null);
  assert(useRootNavigator != null);
  assert(debugCheckHasMaterialLocalizations(context!));

  final ThemeData theme = Theme.of(context!);
  return showGeneralDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    pageBuilder: (BuildContext? buildContext, Animation<double>? animation,
        Animation<double>? secondaryAnimation) {
      final Widget pageChild = child ?? Builder(builder: builder!);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        }),
      );
    },
    useRootNavigator: useRootNavigator,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black12.withOpacity(0.6),
    transitionDuration: const Duration(seconds: 1),
  );
}

Future<bool> checkImageSize(String path) async {
  print("PATH---$path");
  var bytes = await getFileSize(path);
  if (bytes > 5000000) {
    return true;
  } else {
    return false;
  }
}

Future<int> getFileSize(String filepath) async {
  var file = File(filepath);
  int bytes = await file.length();
  print("PATH---$bytes");
  return bytes;
}

Future<void> _openUrl(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

Widget customBox(String svg, String title, BuildContext context,
    {bool isPadding = false}) {
  return Container(
    width: isPadding
        ? MediaQuery.of(context).size.width / 2 -
            ResponsiveFlutter.of(context).scale(Dimens.dimen_22dp)
        : 0,
    padding: EdgeInsets.symmetric(
        vertical: ResponsiveFlutter.of(context).scale(Dimens.dimen_20dp)),
    decoration: BoxDecoration(
        color: Color(lightPrimaryColor),
        borderRadius: BorderRadius.all(Radius.circular(
            ResponsiveFlutter.of(context).scale(Dimens.dimen_12dp)))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(svg),
        heightSizedBox(ResponsiveFlutter.of(context).scale(Dimens.dimen_20dp)),
        TitleTextView(
          title,
          fontName: FontName.InterSemiBold,
          color: Color(secondPrimaryColor),
          fontSize: ResponsiveFlutter.of(context).fontSize(Dimens.font_18dp),
          fontWeight: FontWeight.w500,
        )
      ],
    ),
  );
}

// String formatNumberWithCommas(double number) {
//   final formatter = NumberFormat("#,##0", "en_IN");
//   return formatter.format(number);
// }

String formatNumberWithCommas(double? number) {
  final formatter = NumberFormat("##,##,###", "en_IN");
  return formatter.format(number);
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }

  String capitalizeFirstLetterOfEachWord() {
    if (this.isEmpty) return this;

    List<String> words = this.split(' ');
    List<String> capitalizedWords = words.map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).toList();

    return capitalizedWords.join(' ');
  }
}

Future<String?> getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor;
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.id;
  }
}

Widget buildDropdownSearch(BuildContext context, dynamic model, dynamic list,
    String title, dynamic selectedItem, bool showSearchBox,
    {Function(dynamic)? onChange, double? boxHeight}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: ResponsiveFlutter.of(context).scale(Dimens.dimen_38dp),
        child: DropdownSearch<dynamic>(
          items: list,
          itemAsString: (item) {
            return item;
          },
          selectedItem: selectedItem,
          onChanged: onChange,
          onBeforePopupOpening: (selectedItem) async {
            FocusManager.instance.primaryFocus?.unfocus();
            bool abc = true;
            return abc;
          },
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              fillColor: Color(whiteColor),
              filled: true,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: ResponsiveFlutter.of(context).scale(Dimens.dimen_1dp),
                horizontal:
                    ResponsiveFlutter.of(context).scale(Dimens.dimen_16dp),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(
                      ResponsiveFlutter.of(context).scale(Dimens.dimen_10dp))),
                  borderSide: BorderSide(color: Color(borderGrey))),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(
                      ResponsiveFlutter.of(context).scale(Dimens.dimen_10dp))),
                  borderSide: BorderSide(color: Color(borderGrey))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(
                      ResponsiveFlutter.of(context).scale(Dimens.dimen_10dp))),
                  borderSide: BorderSide(color: Color(borderGrey))),
            ),
          ),
          dropdownButtonProps: DropdownButtonProps(
            alignment: Alignment.centerRight,
            // padding: EdgeInsets.all(
            //     ResponsiveFlutter.of(context).scale(Dimens.dimen_5dp)),
            icon: Icon(Icons.keyboard_arrow_down_sharp),
            color: Color(primaryColor),
          ),
          popupProps: PopupProps.modalBottomSheet(
              showSearchBox: showSearchBox,
              searchFieldProps: TextFieldProps(
                  textInputAction: TextInputAction.search,
                  textCapitalization: TextCapitalization.words,
                  style: TextStyle(
                    fontSize: ResponsiveFlutter.of(context)
                        .fontSize(Dimens.edit_font_15dp),
                    color: Color(fontColor),
                    fontFamily: FontName.InterRegular,
                    height: 1.2,
                  ),
                  cursorColor: Color(fontColor),
                  expands: false,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: ResponsiveFlutter.of(context)
                            .scale(Dimens.dimen_12dp),
                        vertical: ResponsiveFlutter.of(context)
                            .scale(Dimens.dimen_12dp)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimens.dimen_10dp),
                      borderSide: BorderSide(color: Color(borderGreyColor)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimens.dimen_10dp),
                        borderSide: BorderSide(color: Color(borderGreyColor))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimens.dimen_10dp),
                        borderSide: BorderSide(color: Color(borderGreyColor))),
                    hintText: "Search ${title.toLowerCase()}",
                    isDense: true,
                    hintStyle: TextStyle(
                        color: Color(borderGreyColor),
                        fontFamily: FontName.InterRegular),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveFlutter.of(context)
                          .scale(Dimens.dimen_16dp))),
              modalBottomSheetProps: ModalBottomSheetProps(
                backgroundColor: Color(whiteColor),
                elevation: 5,
                useSafeArea: false,
                constraints: BoxConstraints(
                    maxHeight:
                        boxHeight ?? MediaQuery.of(context).size.height * .7),
                barrierColor: Color(greyColor5).withOpacity(0.2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimens.dimen_15dp),
                        topRight: Radius.circular(Dimens.dimen_15dp))),
              ),
              listViewProps: const ListViewProps(
                padding: EdgeInsets.all(10),
                shrinkWrap: true,
                itemExtent: 40,
              ),
              emptyBuilder: (context, searchEntry) {
                return searchEntry.isNotEmpty
                    ? ListView.builder(
                        itemCount: list.length,
                        shrinkWrap: true,
                        itemBuilder: (cont, index) {
                          return list[index]
                                  .name!
                                  .toLowerCase()
                                  .trim()
                                  .contains(searchEntry.toLowerCase().trim())
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ResponsiveFlutter.of(context)
                                          .scale(Dimens.dimen_18dp),
                                      vertical: ResponsiveFlutter.of(context)
                                          .scale(Dimens.dimen_4dp)),
                                  child: GestureDetector(
                                    onTap: () {
                                      selectedItem = list[index];
                                      print("SOHAN$selectedItem");
                                      onChange!(selectedItem);
                                      Navigator.pop(context);
                                    },
                                    child: TitleTextView(
                                      list[index].name!.trim(),
                                      color: Color(fontColor),
                                      fontName: FontName.InterMedium,
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(Dimens.font_15dp),
                                    ),
                                  ),
                                )
                              : Container();
                        })
                    : Center(
                        child: TitleTextView("No data found",
                            color: Color(greyColor5),
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(1.7),
                            fontName: FontName.InterRegular,
                            height: 1.5),
                      );
              },
              itemBuilder: (context, item, flag) {
                print("SEARCING$item");
                print("===AAAitem===${item.name}");
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: selectedItem != null &&
                              selectedItem.name.toString().trim() ==
                                  item.name.toString().trim()
                          ? Color(lightPrimaryColor)
                          : Colors.white),
                  padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveFlutter.of(context)
                          .scale(Dimens.dimen_18dp),
                      vertical: ResponsiveFlutter.of(context)
                          .scale(Dimens.dimen_6dp)),
                  child: TitleTextView(
                    getStringFromList(item).trim(),
                    fontSize: ResponsiveFlutter.of(context)
                        .fontSize(Dimens.font_15dp),
                  ),
                );
              },
              title: Container(
                padding: EdgeInsets.symmetric(vertical: Dimens.dimen_10dp),
                child: TitleTextView(
                  title,
                  textAlign: TextAlign.center,
                  fontSize:
                      ResponsiveFlutter.of(context).fontSize(Dimens.font_18dp),
                  color: Color(fontColor),
                  fontWeight: FontWeight.bold,
                  fontName: FontName.InterBold,
                ),
              )),
          dropdownBuilder: _customDropDownExampleMultiSelection,
        ),
      ),
    ],
  );
}

Future showLockedProfileDilouge(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              contentPadding: EdgeInsets.zero,
              content: Container(
                color: Colors.white,
                margin: EdgeInsets.only(
                  right: ResponsiveFlutter.of(context).scale(Dimens.dimen_20dp),
                  left: ResponsiveFlutter.of(context).scale(Dimens.dimen_20dp),
                  top: ResponsiveFlutter.of(context).scale(Dimens.dimen_20dp),
                  bottom:
                      ResponsiveFlutter.of(context).scale(Dimens.dimen_20dp),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(AppImages.iconLocked),
                    SizedBox(
                      height: ResponsiveFlutter.of(context)
                          .scale(Dimens.dimen_10dp),
                    ),
                    Text(
                      "Oops!",
                      style: TextStyle(
                        fontSize: ResponsiveFlutter.of(context)
                            .fontSize(Dimens.font_24dp),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: ResponsiveFlutter.of(context)
                          .scale(Dimens.dimen_10dp),
                    ),
                    TitleTextView(
                      textAlign: TextAlign.center,
                      "Your account has been locked due to unpaid invoices. Kindly get in touch with support in case of any issues -  +91 98253 93922",
                      fontSize: ResponsiveFlutter.of(context)
                          .fontSize(Dimens.font_14dp),
                    ),
                    SizedBox(
                      height: ResponsiveFlutter.of(context)
                          .scale(Dimens.dimen_10dp),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: OutlinedButton(
                        onPressed: () {
                          print("Refresh button");
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                ResponsiveFlutter.of(context)
                                    .scale(Dimens.dimen_12dp)),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(ResponsiveFlutter.of(context)
                              .scale(Dimens.dimen_15dp)),
                          child: TitleTextView(
                            "Refresh",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(primaryColor),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ResponsiveFlutter.of(context)
                          .scale(Dimens.dimen_10dp),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: OutlinedButton(
                        onPressed: () {
                          CallNextScreenAndClearStack(context, LoginView());
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                ResponsiveFlutter.of(context)
                                    .scale(Dimens.dimen_12dp)),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                            ResponsiveFlutter.of(context)
                                .scale(Dimens.dimen_15dp),
                          ),
                          child: Text("Back to Login",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(primaryColor))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ResponsiveFlutter.of(context)
                          .scale(Dimens.dimen_10dp),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

Widget buildDropdownSearchWithKey(
    BuildContext context,
    dynamic model,
    dynamic list,
    String title,
    dynamic selectedItem,
    bool showSearchBox,
    GlobalKey<DropdownSearchState> dropdownKey,
    {Function(dynamic)? onChange}) {
  printLog("$model DATA List ${list.length}");
  return SafeArea(
      bottom: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: ResponsiveFlutter.of(context).scale(Dimens.dimen_38dp),
            child: DropdownSearch<dynamic>(
              items: list,
              key: dropdownKey,
              itemAsString: (item) {
                return item;
              },
              selectedItem: selectedItem,
              onChanged: onChange,
              onBeforePopupOpening: (selectedItem) async {
                FocusManager.instance.primaryFocus?.unfocus();
                bool abc = true;
                return abc;
              },
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  fillColor: Color(whiteColor),
                  filled: true,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical:
                        ResponsiveFlutter.of(context).scale(Dimens.dimen_1dp),
                    horizontal:
                        ResponsiveFlutter.of(context).scale(Dimens.dimen_16dp),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(
                          ResponsiveFlutter.of(context)
                              .scale(Dimens.dimen_10dp))),
                      borderSide: BorderSide(color: Color(borderGrey))),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(
                          ResponsiveFlutter.of(context)
                              .scale(Dimens.dimen_10dp))),
                      borderSide: BorderSide(color: Color(borderGrey))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(
                          ResponsiveFlutter.of(context)
                              .scale(Dimens.dimen_10dp))),
                      borderSide: BorderSide(color: Color(borderGrey))),
                ),
              ),
              dropdownButtonProps: DropdownButtonProps(
                alignment: Alignment.centerRight,
                // padding: EdgeInsets.all(
                //     ResponsiveFlutter.of(context).scale(Dimens.dimen_5dp)),
                icon: Icon(Icons.keyboard_arrow_down_sharp),
                color: Color(primaryColor),
              ),
              popupProps: PopupProps.modalBottomSheet(
                  showSearchBox: showSearchBox,
                  searchFieldProps: TextFieldProps(
                      textInputAction: TextInputAction.search,
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(
                        fontSize: ResponsiveFlutter.of(context)
                            .fontSize(Dimens.edit_font_15dp),
                        color: Color(fontColor),
                        fontFamily: FontName.InterRegular,
                        height: 1.2,
                      ),
                      cursorColor: Color(fontColor),
                      expands: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: ResponsiveFlutter.of(context)
                                .scale(Dimens.dimen_12dp),
                            vertical: ResponsiveFlutter.of(context)
                                .scale(Dimens.dimen_12dp)),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimens.dimen_10dp),
                          borderSide: BorderSide(color: Color(borderGreyColor)),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimens.dimen_10dp),
                            borderSide:
                                BorderSide(color: Color(borderGreyColor))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimens.dimen_10dp),
                            borderSide:
                                BorderSide(color: Color(borderGreyColor))),
                        hintText: "Search ${title.toLowerCase()}",
                        isDense: true,
                        hintStyle: TextStyle(
                            color: Color(borderGreyColor),
                            fontFamily: FontName.InterRegular),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveFlutter.of(context)
                              .scale(Dimens.dimen_16dp))),
                  modalBottomSheetProps: ModalBottomSheetProps(
                    backgroundColor: Color(whiteColor),
                    elevation: 5,
                    useSafeArea: false,
                    barrierColor: Color(greyColor5).withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimens.dimen_15dp),
                            topRight: Radius.circular(Dimens.dimen_15dp))),
                  ),
                  emptyBuilder: (context, searchEntry) {
                    return searchEntry.isNotEmpty
                        ? ListView.builder(
                            itemCount: list.length,
                            shrinkWrap: true,
                            itemBuilder: (cont, index) {
                              return list[index]
                                      .name!
                                      .toLowerCase()
                                      .trim()
                                      .contains(
                                          searchEntry.toLowerCase().trim())
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ResponsiveFlutter.of(context)
                                                  .scale(Dimens.dimen_18dp),
                                          vertical:
                                              ResponsiveFlutter.of(context)
                                                  .scale(Dimens.dimen_4dp)),
                                      child: GestureDetector(
                                        onTap: () {
                                          selectedItem = list[index];
                                          print("SOHAN$selectedItem");
                                          onChange!(selectedItem);
                                          Navigator.pop(context);
                                        },
                                        child: TitleTextView(
                                          list[index].name!.trim(),
                                          color: Color(fontColor),
                                          fontName: FontName.InterMedium,
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(Dimens.font_15dp),
                                        ),
                                      ),
                                    )
                                  : Container();
                            })
                        : Center(
                            child: TitleTextView("No data found",
                                color: Color(greyColor5),
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(1.7),
                                fontName: FontName.InterRegular,
                                height: 1.5),
                          );
                  },
                  itemBuilder: (context, item, flag) {
                    print("SEARCING$item");
                    print("===AAAitem===${item.name}");
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: selectedItem != null &&
                                  selectedItem.name.toString().trim() ==
                                      item.name.toString().trim()
                              ? Color(lightPrimaryColor)
                              : Colors.white),
                      padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveFlutter.of(context)
                              .scale(Dimens.dimen_18dp),
                          vertical: ResponsiveFlutter.of(context)
                              .scale(Dimens.dimen_6dp)),
                      child: TitleTextView(
                        getStringFromList(item).trim(),
                        fontSize: ResponsiveFlutter.of(context)
                            .fontSize(Dimens.font_15dp),
                      ),
                    );
                  },
                  listViewProps: const ListViewProps(
                    padding: EdgeInsets.all(10),
                    shrinkWrap: true,
                    itemExtent: 40,
                  ),
                  title: Container(
                    padding: EdgeInsets.symmetric(vertical: Dimens.dimen_10dp),
                    child: TitleTextView(
                      title,
                      textAlign: TextAlign.center,
                      fontSize: ResponsiveFlutter.of(context)
                          .fontSize(Dimens.font_18dp),
                      color: Color(fontColor),
                      fontWeight: FontWeight.bold,
                      fontName: FontName.InterBold,
                    ),
                  )),
              dropdownBuilder: _customDropDownExampleMultiSelection,
            ),
          ),
        ],
      ));
}

Widget _customDropDownExampleMultiSelection(
    BuildContext context, dynamic selectedItem) {
  print('selectedItem${selectedItem}');
  if (selectedItem == null) {
    return TitleTextView(
      "Select",
      color: Color(borderGreyColor),
      fontSize: ResponsiveFlutter.of(context).fontSize(Dimens.edit_font_15dp),
      height: 1.2,
    );
  }
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: TitleTextView(
      selectedItem.name,
      color: Color(fontColor),
      fontName: FontName.InterMedium,
      fontSize: ResponsiveFlutter.of(context).fontSize(Dimens.edit_font_15dp),
      height: 1.2,
    ),
  );
}

getShortForm(var number) {
  var f = NumberFormat.compact(locale: "en_US");
  return f.format(number);
}

class OneDotInputFormatter extends TextInputFormatter {
  final RegExp _regex = RegExp(r'^\d*\.?\d*$');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (!_regex.hasMatch(newValue.text)) {
      // Invalid input, prevent it
      return oldValue;
    }
    return newValue;
  }
}

String getStringFromList(dynamic selectedItem) {
  return selectedItem;
  String label = "";

  return label;
}

void openYouTubeVideo(String videoUrl) async {
  if (await canLaunch(videoUrl)) {
    await launch(videoUrl);
  } else {
    print('Could not launch $videoUrl');
  }
}

// contactUSDialog(BuildContext context) {
//   if (CommonValues.contactUsData != null) {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(18),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 heightSizedBox(
//                   ResponsiveFlutter.of(context).scale(Dimens.dimen_10dp),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Icon(
//                       Icons.close,
//                       color: Colors.transparent,
//                     ),
//                     SvgPicture.asset(IC_CONTACT_DIALOG),
//                     Padding(
//                       padding: EdgeInsets.only(
//                         right: ResponsiveFlutter.of(context)
//                             .scale(Dimens.dimen_8dp),
//                       ),
//                       child: GestureDetector(
//                         onTap: () => Navigator.of(context).pop(),
//                         child: Icon(
//                           Icons.close,
//                           color: Color(primaryColor),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 heightSizedBox(
//                   ResponsiveFlutter.of(context).scale(Dimens.dimen_10dp),
//                 ),
//                 TitleTextView(
//                   "allTranslations.text(contact_us)!,"
//                   color: Color(primaryColor),
//                   fontWeight: FontWeight.w600,
//                   fontSize:
//                   ResponsiveFlutter.of(context).fontSize(Dimens.font_24dp),
//                 ),
//                 TitleTextView(
//                   "allTranslations.text(get_in_touch_message)!",
//                   color: Color(greyColor5),
//                   textAlign: TextAlign.center,
//                   fontWeight: FontWeight.w400,
//                   fontSize:
//                   ResponsiveFlutter.of(context).fontSize(Dimens.font_15dp),
//                 ),
//                 heightSizedBox(
//                   ResponsiveFlutter.of(context).scale(Dimens.dimen_20dp),
//                 ),
//                 GestureDetector(
//                   behavior: HitTestBehavior.opaque,
//                   onTap: () {
//                     // _openUrl('mailto:${CommonValues.contactUsData!.data!.email}');
//                   },
//                   child: Container(
//                     margin: EdgeInsets.only(
//                       right: ResponsiveFlutter.of(context)
//                           .scale(Dimens.dimen_20dp),
//                       left: ResponsiveFlutter.of(context)
//                           .scale(Dimens.dimen_20dp),
//                       bottom: ResponsiveFlutter.of(context)
//                           .scale(Dimens.dimen_10dp),
//                     ),
//                     padding: EdgeInsets.only(
//                       top: ResponsiveFlutter.of(context)
//                           .scale(Dimens.dimen_13dp),
//                       bottom: ResponsiveFlutter.of(context)
//                           .scale(Dimens.dimen_13dp),
//                     ),
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Color(secondPrimaryColor),
//                       ),
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(
//                           12,
//                         ),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SvgPicture.asset(
//                           IC_EMAIL_NEW,
//                         ),
//                         widthSizedBox(
//                           ResponsiveFlutter.of(context)
//                               .scale(Dimens.dimen_10dp),
//                         ),
//                         TitleTextView(
//                           "CommonValues.contactUsData!.data!.email!",
//                           color: Color(secondPrimaryColor),
//                           fontWeight: FontWeight.w600,
//                           fontSize: ResponsiveFlutter.of(context)
//                               .fontSize(Dimens.font_15dp),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   behavior: HitTestBehavior.opaque,
//                   onTap: () {
//                     // _openUrl(
//                     //     'tel:${CommonValues.contactUsData!.data!.phone.toString().replaceAll(" ", "")}');
//                   },
//                   child: Container(
//                       margin: EdgeInsets.only(
//                         right: ResponsiveFlutter.of(context)
//                             .scale(Dimens.dimen_20dp),
//                         left: ResponsiveFlutter.of(context)
//                             .scale(Dimens.dimen_20dp),
//                         bottom: ResponsiveFlutter.of(context)
//                             .scale(Dimens.dimen_10dp),
//                       ),
//                       padding: EdgeInsets.only(
//                         top: ResponsiveFlutter.of(context)
//                             .scale(Dimens.dimen_13dp),
//                         bottom: ResponsiveFlutter.of(context)
//                             .scale(Dimens.dimen_13dp),
//                       ),
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Color(secondPrimaryColor),
//                         ),
//                         borderRadius: const BorderRadius.all(
//                           Radius.circular(12),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SvgPicture.asset(
//                             IC_CALL,
//                           ),
//                           widthSizedBox(
//                             ResponsiveFlutter.of(context)
//                                 .scale(Dimens.dimen_10dp),
//                           ),
//                           TitleTextView(
//                             // CommonValues.contactUsData!.data!.phone.toString(),
//                             "",
//                             color: Color(secondPrimaryColor),
//                             fontWeight: FontWeight.w600,
//                             fontSize: ResponsiveFlutter.of(context)
//                                 .fontSize(Dimens.font_15dp),
//                           ),
//                         ],
//                       )),
//                 ),
//               ],
//             ),
//           );
//         }
//     );
//   }
// }
