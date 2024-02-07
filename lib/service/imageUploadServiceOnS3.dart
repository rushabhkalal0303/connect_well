import 'dart:convert';
import 'dart:io';

import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:connect_well/service/policy.dart';
import 'package:http/http.dart' as http;

class ImageUploadServiceOnS3 {
  var _accessKeyId = 'AKIAXG4IOMWCCVR3UKVS';
  var _secretKeyId = 'AXRC8OMReP1sA7uDsPKQv5X1hUyi9HzVRSJffvQq';
  var _region = 'ap-south-1';
  var _bucketName = 'raf-uploads';
  var _s3Endpoint = 'https://raf-uploads.s3.ap-south-1.amazonaws.com';


  Future<String> uploadFile(File inputFile) async {
    final length = await inputFile.length();
    String fileName = inputFile.path.split('/').last;
    print("File Name $fileName");
    final uri = Uri.parse(_s3Endpoint);
    final req = http.MultipartRequest("POST", uri);
    final multipartFile = http.MultipartFile(
        'file', http.ByteStream.fromBytes(inputFile.readAsBytesSync()), length,
        filename: fileName);

    final policy = Policy.fromS3PresignedPost(
        fileName, _bucketName, _accessKeyId, 15, length,
        region: _region);
    final key =
        SigV4.calculateSigningKey(_secretKeyId, policy.datetime, _region, 's3');
    final signature = SigV4.calculateSignature(key, policy.encode());

    print("Bucket Name $_bucketName");

    req.files.add(multipartFile);
    req.fields['key'] = policy.key;
    req.fields['acl'] = 'public-read';
    req.fields['X-Amz-Credential'] = policy.credential;
    req.fields['X-Amz-Algorithm'] = 'AWS4-HMAC-SHA256';
    req.fields['X-Amz-Date'] = policy.datetime;
    req.fields['Policy'] = policy.encode();
    req.fields['X-Amz-Signature'] = signature;

    var imgURL = "";

    try {
      print("Bucket Name Request Sent");
      final res = await req.send();
      print("AWS s3 REs == ${res.stream}");
      print("AWS s3 StatusCode == ${res.statusCode}");

      if (res.statusCode == 204) {
        imgURL = "$_s3Endpoint/$fileName";
        print("File URL = $imgURL");
      }

      res.stream.transform(utf8.decoder).listen((value) {
        print("AWS s3 Value == $value");
      });
    } catch (e) {
      print(e.toString());
    }

    return imgURL;
  }
}
