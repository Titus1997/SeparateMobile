import 'dart:io';

import 'package:http/http.dart' as http;

class ServerHelper {

  String url = "http://10.0.2.2:5000";

  ServerHelper._();
  static final ServerHelper svhelper = ServerHelper._();

  Future<int> getDrum(File file) async {
    Map body = {
      'data': file,
    };
    final response = await http.post(this.url + '/uploader', body: body).timeout(Duration(seconds: 3));
    return response.statusCode;
  }


  Future<int> getVocal(File file) async {/*
    var request = new http.MultipartRequest("POST", url);
    request.fields['user'] = 'someone@somewhere.com';
    request.files.add(http.MultipartFile.fromPath(
      'package',
      'build/package.tar.gz',
      contentType: new MediaType('application', 'x-tar'),
    ));
  request.send().then((response) {
    if (response.statusCode == 200) print("Uploaded!");
  });
    return response.statusCode;*/
  }
}