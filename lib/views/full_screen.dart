import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/photo_model.dart';

class FullScreen extends StatelessWidget {
  final PhotoModel photo;
  const FullScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),

      body: Hero(
        tag: photo.id,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.network(photo.url, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
