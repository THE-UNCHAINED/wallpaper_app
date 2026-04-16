import 'package:flutter/widgets.dart';

class PhotoModel {
  final String url;
  final String photographer;
  final int id;
  PhotoModel({required this.url, required this.photographer, required this.id});

  factory PhotoModel.jsonToMap(Map<String, dynamic> jsonData) {
    return PhotoModel(
      url: jsonData['src']['large'],
      photographer: jsonData['photographer'],
      id: jsonData['id'],
    );
  }
}
