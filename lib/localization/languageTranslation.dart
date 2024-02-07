import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connect_well/localization/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const List<String> _kSupportedLanguages = ["en",'hi'];
const String _kDefaultLanguage = "en";

class LanguageTranslation {
  Locale? _locale;
  Map<dynamic, dynamic>? _localizedValues;
  Map<String, String> _cache = {};
  Iterable<Locale> supportedLocales() => _kSupportedLanguages.map<Locale>((lang) => Locale(lang, ''));

  String? text(String key) {
    // Return the requested string
//    String string = '** $key not found';
    String string = '';

    if (_localizedValues != null) {
      // Check if the requested [key] is in the cache
      if (_cache[key] != null){
        return _cache[key];
      }

      // Iterate the key until found or not
      bool found = true;
      Map<dynamic, dynamic> _values = _localizedValues!;
      List<String> _keyParts = key.split('.');
      int _keyPartsLen = _keyParts.length;
      int index = 0;
      int lastIndex = _keyPartsLen - 1;

      while(index < _keyPartsLen && found){
        var value = _values[_keyParts[index]];

        if (value == null) {
          // Not found => STOP
          found = false;
          break;
        }

        // Check if we found the requested key
        if (value is String && index == lastIndex){
          string = value;

          // Add to cache
          _cache[key] = string;
          break;
        }

        // go to next subKey
        _values = value;
        index++;
      }
    }

    return string;
  }

  String get currentLanguage => _locale == null ? '' : _locale!.languageCode;
  Locale get locale => _locale!;

  ///
  /// One-time initialization
  ///
  Future<void> init() async {

    if (_locale == null){
      print("Called init");
      var temp = await preferences.getPreferredLanguage();
      await setNewLanguage(temp.toString());
    }else{
      print("Locale available $_locale");
    }
    return null;
  }

  ///
  /// Routine to change the language
  ///
  Future<void> setNewLanguage([String? newLanguage]) async {

    String language = newLanguage != null ? newLanguage : "en";
    log("init language $language");
    if (language == null){
      language = await preferences.getPreferredLanguage();
    }

    // If not in the preferences, get the current locale (as defined at the device settings level)
    if (language == ''){
      String currentLocale = Platform.localeName.toLowerCase();
      log("Current Locale $currentLocale");
      if (currentLocale.length > 2){
        if (currentLocale[2] == "-" || currentLocale[2] == "_"){
          language = currentLocale.substring(0, 2);
        }
      }
    }else{
      preferences.setPreferredLanguage(language);
      log("Current Locale $language");
    }

    // Check if we are supporting the language
    // if not consider the default one
    if (!_kSupportedLanguages.contains(language)){

      language = _kDefaultLanguage;
      log("Default LanguageXYZ $language");
    }

    // Set the Locale

    log("Default Language $_kDefaultLanguage");
    _locale = Locale(language, "");

    log("LanguageCode is this ${_locale!.languageCode}");
    // Load the language strings
    String jsonContent = await rootBundle.loadString("assets/Locale/${_locale!.languageCode}.json");
    // String jsonContent = await rootBundle.loadString("assets/Locale/en.json");
    _localizedValues = json.decode(jsonContent);

    // Clear the cache
    _cache = {};

    return null;
  }

  /// ==========================================================
  /// Singleton Factory
  ///
  static final LanguageTranslation _translations = LanguageTranslation._internal();
  factory LanguageTranslation() {
    return _translations;
  }
  LanguageTranslation._internal();
}

LanguageTranslation allTranslations = LanguageTranslation();