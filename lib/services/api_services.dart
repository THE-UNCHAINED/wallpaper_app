import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/photo_model.dart';
import '../utils/constants.dart';

class ApiServices {
  Future<List<PhotoModel>> getWallpapers() async {
    List<PhotoModel> photos = [];

    final response = await http.get(
      Uri.parse(Constants.apiUrl),
      headers: {"Authorization": Constants.apiKey},
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      data['photos'].forEach((element) {
        PhotoModel photoModel = PhotoModel.jsonToMap(element);
        photos.add(photoModel);
      });
    } else {
      print("Error: ${response.statusCode}");
    }

    return photos;
  }
}
