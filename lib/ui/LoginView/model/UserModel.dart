class UserModel {
  int? status;
  String? message;
  Data? data;

  UserModel({this.status, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? status;
  String? name;
  String? mobile;
  String? emailAddress;
  String? lang;
  String? dob;
  String? lastLogin;
  String? logoutTimestamp;
  String? createdTimestamp;
  String? updatedTimestamp;
  int? otp;
  int? mhId;
  String? mhName;
  String? mhNumber;
  int? isAccountLocked;
  String? deviceToken;
  String? deviceType;
  String? deviceId;
  String? tonnageOfTruckAllowed;
  int? userTypeId;
  List<Useraddresses>? useraddresses;
  String? accessToken;
  bool? isRegistered;
  var monthTarget;
  var quarterTarget;
  var yearTarget;

  Data(
      {this.id,
        this.status,
        this.name,
        this.mobile,
        this.emailAddress,
        this.lang,
        this.dob,
        this.lastLogin,
        this.logoutTimestamp,
        this.createdTimestamp,
        this.updatedTimestamp,
        this.otp,
        this.mhId,
        this.mhName,
        this.mhNumber,
        this.isAccountLocked,
        this.deviceToken,
        this.deviceType,
        this.deviceId,
        this.tonnageOfTruckAllowed,
        this.userTypeId,
        this.useraddresses,
        this.accessToken,
        this.isRegistered,
        this.monthTarget,
        this.quarterTarget,
        this.yearTarget});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    name = json['name'];
    mobile = json['mobile'];
    emailAddress = json['emailAddress'];
    lang = json['lang'];
    dob = json['dob'];
    lastLogin = json['lastLogin'];
    logoutTimestamp = json['logoutTimestamp'];
    createdTimestamp = json['createdTimestamp'];
    updatedTimestamp = json['updatedTimestamp'];
    otp = json['otp'];
    mhId = json['mh_id'];
    mhName = json['mh_name'];
    mhNumber = json['mh_number'];
    isAccountLocked = json['isAccountLocked'];
    deviceToken = json['deviceToken'];
    deviceType = json['deviceType'];
    deviceId = json['deviceId'];
    tonnageOfTruckAllowed = json['tonnageOfTruckAllowed'];
    userTypeId = json['userTypeId'];
    if (json['useraddresses'] != null) {
      useraddresses = <Useraddresses>[];
      json['useraddresses'].forEach((v) {
        useraddresses!.add(new Useraddresses.fromJson(v));
      });
    }
    accessToken = json['accessToken'];
    isRegistered = json['isRegistered'];
    monthTarget = json['monthTarget'];
    quarterTarget = json['quarterTarget'];
    yearTarget = json['yearTarget'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['emailAddress'] = this.emailAddress;
    data['lang'] = this.lang;
    data['dob'] = this.dob;
    data['lastLogin'] = this.lastLogin;
    data['logoutTimestamp'] = this.logoutTimestamp;
    data['createdTimestamp'] = this.createdTimestamp;
    data['updatedTimestamp'] = this.updatedTimestamp;
    data['otp'] = this.otp;
    data['mh_id'] = this.mhId;
    data['mh_name'] = this.mhName;
    data['mh_number'] = this.mhNumber;
    data['isAccountLocked'] = this.isAccountLocked;
    data['deviceToken'] = this.deviceToken;
    data['deviceType'] = this.deviceType;
    data['deviceId'] = this.deviceId;
    data['tonnageOfTruckAllowed'] = this.tonnageOfTruckAllowed;
    data['userTypeId'] = this.userTypeId;
    if (this.useraddresses != null) {
      data['useraddresses'] =
          this.useraddresses!.map((v) => v.toJson()).toList();
    }
    data['accessToken'] = this.accessToken;
    data['isRegistered'] = this.isRegistered;
    data['monthTarget'] = this.monthTarget;
    data['quarterTarget'] = this.quarterTarget;
    data['yearTarget'] = this.yearTarget;
    return data;
  }
}

class Useraddresses {
  int? id;
  int? status;
  String? addressLine1;
  String? landmark;
  int? pincode;
  String? createdTimestamp;
  String? updatedTimestamp;
  int? userId;
  int? stateId;
  int? cityId;
  City? city;

  Useraddresses(
      {this.id,
        this.status,
        this.addressLine1,
        this.landmark,
        this.pincode,
        this.createdTimestamp,
        this.updatedTimestamp,
        this.userId,
        this.stateId,
        this.cityId,
        this.city});

  Useraddresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    addressLine1 = json['addressLine1'];
    landmark = json['landmark'];
    pincode = json['pincode'];
    createdTimestamp = json['createdTimestamp'];
    updatedTimestamp = json['updatedTimestamp'];
    userId = json['userId'];
    stateId = json['stateId'];
    cityId = json['cityId'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['addressLine1'] = this.addressLine1;
    data['landmark'] = this.landmark;
    data['pincode'] = this.pincode;
    data['createdTimestamp'] = this.createdTimestamp;
    data['updatedTimestamp'] = this.updatedTimestamp;
    data['userId'] = this.userId;
    data['stateId'] = this.stateId;
    data['cityId'] = this.cityId;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}

class City {
  int? id;
  int? status;
  String? cityName;
  String? cityNameH;
  String? createdTimestamp;
  String? updatedTimestamp;
  int? stateId;

  City(
      {this.id,
        this.status,
        this.cityName,
        this.cityNameH,
        this.createdTimestamp,
        this.updatedTimestamp,
        this.stateId});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    cityName = json['cityName'];
    cityNameH = json['cityName_h'];
    createdTimestamp = json['createdTimestamp'];
    updatedTimestamp = json['updatedTimestamp'];
    stateId = json['stateId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['cityName'] = this.cityName;
    data['cityName_h'] = this.cityNameH;
    data['createdTimestamp'] = this.createdTimestamp;
    data['updatedTimestamp'] = this.updatedTimestamp;
    data['stateId'] = this.stateId;
    return data;
  }
}