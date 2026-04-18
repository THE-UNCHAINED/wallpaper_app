import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wallpaper_app/models/photo_model.dart';

class FullScreen extends StatelessWidget {
  final PhotoModel photo;
  const FullScreen({super.key, required this.photo});

  Future<void> setWallpaper(BuildContext context) async {
    try {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Processing Image...")));

      var response = await http.get(Uri.parse(photo.url));

      Directory directory = await getTemporaryDirectory();
      String filePath = '${directory.path}/my_wallpaper.jpg';

      File file = File(filePath);

      await file.writeAsBytes(response.bodyBytes);

      int location = WallpaperManager.HOME_SCREEN;

      bool result = await WallpaperManager.setWallpaperFromFile(
        filePath,
        location,
      );

      if (!context.mounted) return;

      if (result) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Wallpaper Updated!")));
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),

      body: Stack(
        children: [
          Hero(
            tag: photo.id,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(photo.url, fit: BoxFit.cover),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.8),
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () => setWallpaper(context), // Call the function
              child: Text(
                "Set as Wallpaper",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
