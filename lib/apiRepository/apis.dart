import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../globalVariable.dart';
import '../localization/preferences.dart';
import '../ui/LoginView/view/loginView.dart';
import '../utils/commonMethods.dart';
import '../utils/constant.dart';

class Apis {
  BuildContext? globalContext;

  setContext(BuildContext ctx) {
    globalContext = ctx;
  }
}

Future<String> getToken() async {
  return await preferences.getPreference(PreferenceKey.DEVICE_TOKEN, '');
}

// 1) Get API CALL WITH JSON METHOD.
Future<String?> getAPICallWithJson(String url,
    {Map<String, String>? headers, bool showLoader = true}) async {
  log("API Call _URL GET$url");
  log("API Call INITIATED....");
  // var temp = await preferences.getPreferredLanguage();
  // url = url + "?&lang=$temp";
  // print("This is the url $url");
  bool hasInternet = await isInternetAvailable();
  if (headers == null) {
    headers = Map();
  }
  headers["content-type"] = "application/json";

  if (hasInternet) {
    try {
      var response = await http.get(Uri.parse(url), headers: headers).timeout(
          Duration(seconds: CommonValues.CONNECTION_TIMEOUT), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      log("RESPONSE_POST ${response.body}");
      log("REQ_POST ${url}");
      log("RESPONSE_POST ${response.body}");
      if (response != null) {
        return response.body;
      } else {
        return null;
      }
    } on TimeoutException catch (e) {
      return null;
    } on SocketException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  } else {
    return null;
  }
}

// 2) POST API CALL WITH JSON METHOD.
Future<String?> postAPICallWithJson(String url, Map<String, dynamic> body,
    {Map<String, String>? headers, bool showLoader = true}) async {
  log("API Call _URL  $url");
  log("API Call INITIATED....");

  bool hasInternet = await isInternetAvailable();

  if (headers == null) {
    headers = Map();
  }
  headers["content-type"] = "application/json";

  if (hasInternet) {
    print("PARAMS-");
    String deviceToken =
    await preferences.getPreference(PreferenceKey.DEVICE_TOKEN, "");
    if (deviceToken.isEmpty) {
      print("device token is empty");
    } else {
      print(
          "Device tokem is not empty and here is the device token ${preferences.getPreference(PreferenceKey.DEVICE_TOKEN, "")}");
    }

    //Need to resolve this getId issue.

    // String? deviceid = await getId();
    String devicetype = Platform.isAndroid ? 'Android' : 'ios';
    // body['deviceid'] = deviceid;
    body['devicetype'] = devicetype;
    body['devicetype'] = devicetype;
    body['deviceToken'] = deviceToken;

    // if (CommonValues.loginUserData != null &&
    //     CommonValues.loginUserData!.data != null &&
    //     CommonValues.loginUserData!.data!.accessToken != null &&
    //     CommonValues.loginUserData!.data!.accessToken!.isNotEmpty) {
    //   body['accessToken'] = CommonValues.loginUserData!.data!.accessToken;
    // }

    var temp = await preferences.getPreferredLanguage();
    body['lang'] = temp;

    // body['gcmtoken'] = deviceToken;

    log("BODY ${body.toString()}");
    try {
      var response = await http
          .post(Uri.parse(url), body: json.encode(body), headers: headers)
          .timeout(Duration(seconds: CommonValues.CONNECTION_TIMEOUT),
          onTimeout: () {
            throw TimeoutException(
                'The connection has timed out, Please try again!');
          });
      if (response != null) {
        print("API Call ENDED...");
        print("RESPONSE_POST_CODE ${response.statusCode}");
        log("RESPONSE_POST ${response.body}");
        if (response.statusCode == 401) {
          hideProgressDialog();
          print("====>>>TOKENEXPIRED");
          showCustomDialog(
              GlobalVariable.navState.currentContext!,
              CommonValues.appName,
              "Your token is expired, please login again!",
              false,
              'Okay',
              "", onRetakeAction: (p0) {
            preferences.removeKeyFromPreference(PreferenceKey.USER_DATA);
            preferences
                .removeKeyFromPreference(PreferenceKey.NOTIFICATION_ALERT);
            preferences.removeKeyFromPreference(PreferenceKey.USER_DATA);
            // CommonValues.loginUserData = null;
            CallNextScreen(
                GlobalVariable.navState.currentContext!, LoginView());
          });
          return '';
        } else if (response.statusCode == 203) {
          showLockedProfileDilouge(GlobalVariable.navState.currentContext!);
        } else {
          return response.body;
        }
      } else {
        print("ABCD1234--");
        print("RESPONSE_POST iS NUll");
        return null;
      }
    } on TimeoutException catch (e) {
      return null;
    } on SocketException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  } else {
    print('INELSE');
    print("NO INTERNET");
    return null;
  }
}

// 3) POST API CALL WITH RESPONSE METHOD.
Future<String?> postAPICallWithResponse(String url, Map<String, dynamic> body,
    {Map<String, String>? headers, bool showLoader = true}) async {
  print("API Call _URL  $url");
  print("API Call INITIATED....");

  bool hasInternet = await isInternetAvailable();

  if (headers == null) {
    headers = Map();
  }
  headers["content-type"] = "application/json";

  if (hasInternet) {
    if (showLoader) {
      // return null;
    }

    // String? deviceid = await getId();
    String devicetype = Platform.isAndroid ? 'Android' : 'ios';
    String deviceToken =
    await preferences.getPreference(PreferenceKey.DEVICE_TOKEN, "");
    if (deviceToken.isEmpty) {
      print("device token is empty");
    } else {
      print(
          "Device tokem is not empty and here is the device token ${preferences.getPreference(PreferenceKey.DEVICE_TOKEN, "")}");
    }
    // body['deviceid'] = deviceid;
    body['devicetype'] = devicetype;
    body['deviceToken'] = deviceToken;
    // if (CommonValues.loginUserData != null &&
    //     CommonValues.loginUserData!.data != null &&
    //     CommonValues.loginUserData!.data!.accessToken != null &&
    //     CommonValues.loginUserData!.data!.accessToken!.isNotEmpty) {
    //   body['accessToken'] = CommonValues.loginUserData!.data!.accessToken;
    // }

    log("REQUEST_PARAMS $body");
    try {
      var response = await http
          .post(Uri.parse(url), body: jsonEncode(body), headers: headers)
          .timeout(Duration(seconds: CommonValues.CONNECTION_TIMEOUT),
          onTimeout: () {
            // APIResponseHandler().handleResponse(baseView,event, null);
            throw TimeoutException(
                'The connection has timed out, Please try again!');
          });
      if (response != null) {
        print("API Call ENDED...");
        print("RESPONSE_POST_CODE ${response.statusCode}");
        print("RESPONSE_POST ${response.body}");
        if (response.statusCode == 200) {
          return response.body;
          // APIResponseHandler().handleResponse(baseView,event, response.body);
        } else if (response.statusCode == 401) {
          hideProgressDialog();
          print("====>>>TOKENEXPIRED");
          preferences.removeKeyFromPreference(PreferenceKey.USER_DATA);
          preferences.removeKeyFromPreference(PreferenceKey.NOTIFICATION_ALERT);
          preferences.removeKeyFromPreference(PreferenceKey.USER_DATA);
          // CommonValues.loginUserData = null;
          showCustomDialog(
              GlobalVariable.navState.currentContext!,
              CommonValues.appName,
              "Your token is expired, please login again!",
              false,
              'Okay',
              "", onRetakeAction: (p0) {
            // CommonValues.loginUserData = null;
            // CallNextScreenAndClearStack(
            //     GlobalVariable.navState.currentContext!, const LoginView());
          });
          return '';
        } else if (response.statusCode == 203) {
          showLockedProfileDilouge(GlobalVariable.navState.currentContext!);
        } else {
          return null;
          // APIResponseHandler().handleResponse(baseView,event, null);
        }
      } else {
        print("RESPONSE_POST iS NUll");
        return null;
        // APIResponseHandler().handleResponse(baseView,event, null);
      }
    } on TimeoutException catch (e) {
      return null;
      // APIResponseHandler().handleResponse(baseView,event, null);
    } on SocketException catch (e) {
      return null;
      // APIResponseHandler().handleResponse(baseView,event, null);
    } on Exception catch (e) {
      return null;
      // APIResponseHandler().handleResponse(baseView,event, null);
    } catch (e) {
      return null;
    }
  } else {
    return null;
  }
}

// 4) POST API CALL WITH MULTIPART METHOD.
Future<String?> postAPICallWithMultipart(
    String url, Map<String, dynamic> body, String fileName, String filePath,
    {bool isSessionExpiredActionRequired = false,
      Map<String, dynamic>? headers}) async {
  print("REQUEST_URL $url");
  print("REQUEST_PARAMS $body");

  // String? deviceid = await getId();
  String deviceToken =
  await preferences.getPreference(PreferenceKey.DEVICE_TOKEN, "");

  if (deviceToken.isEmpty) {
    print("device token is empty");
  } else {
    print(
        "Device tokem is not empty and here is the device token ${preferences.getPreference(PreferenceKey.DEVICE_TOKEN, "")}");
  }
  print("deviceToken $deviceToken");

  String devicetype = Platform.isAndroid ? 'Android' : 'ios';

  body['deviceToken'] = deviceToken;
  // body['deviceid'] = deviceid;
  body['devicetype'] = devicetype;

  var request = await http.MultipartRequest("POST", Uri.parse(url));

  print("REQUEST_PARAMS $filePath");
  if (headers != null) {
    for (var entry in headers.entries) {
      request.headers[entry.key] = entry.value;
    }
  }

  for (var entry in body.entries) {
    request.fields[entry.key] = entry.value;
  }

  if (filePath.isNotEmpty) {
    http.MultipartFile multipartFile =
    await http.MultipartFile.fromPath(fileName, filePath);
    request.files.add(multipartFile);
  }

  try {
    var response = await request.send().timeout(
        Duration(seconds: CommonValues.CONNECTION_TIMEOUT), onTimeout: () {
      throw TimeoutException('The connection has timed out, Please try again!');
    });

    if (response != null) {
      if (response.statusCode == 200) {
        String strResponse = await response.stream.bytesToString();
        return strResponse;
      } else if (response.statusCode == 401) {
        print("yes this is the issue");
        hideProgressDialog();
        print("====>>>TOKENEXPIRED");
        showCustomDialog(
            GlobalVariable.navState.currentContext!,
            CommonValues.appName,
            "Your token is expired, please login again!",
            false,
            'Okay',
            "", onRetakeAction: (p0) {
          preferences.removeKeyFromPreference(PreferenceKey.USER_DATA);
          preferences.removeKeyFromPreference(PreferenceKey.NOTIFICATION_ALERT);
          // CommonValues.loginUserData = null;
          // CallNextScreenAndClearStack(
          //     GlobalVariable.navState.currentContext!, const LoginView());
        });
        return '';
      } else if (response.statusCode == 203) {
        showLockedProfileDilouge(GlobalVariable.navState.currentContext!);
      } else {
        print("response statusCode ${response.statusCode}");
        return null;
      }
    } else {
      print("response is null");
      return null;
    }
  } on TimeoutException catch (e) {
    print("Timeout Exception ");
    return null;
  } on SocketException catch (e) {
    print("Timeout Exception ");
    return null;
  } on Exception catch (e) {
    print("Exception ");
    return null;
  } catch (e) {
    return null;
  }
}
