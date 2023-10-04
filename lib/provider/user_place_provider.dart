import 'dart:io';

import 'package:favorite_places/model/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as SysPath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      db.execute(
          'CREATE TABLE user_places(id int AUTO_INCREMENT PRIMARY KEY, title TEXT, image TEXT)');
    },
    version: 1,
  );

  return db;
}

class UserPlaceNotifier extends StateNotifier<List<Place>> {
  UserPlaceNotifier() : super([]);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places = data.map((row) {
      return Place(
        title: row['title'] as String,
        image: File(row['image'] as String),
      );
    }).toList();

    state = places;
  }

  void addPlace(String title, File? image) async {
    File? copiedImage;
    if (image != null) {
      final appDir = await SysPath.getApplicationDocumentsDirectory();
      final imageName = path.basename(image.path);
      copiedImage = await image.copy('${appDir.path}/$imageName');
    }

    final db = await _getDatabase();
    db.insert(
      'user_places',
      {
        'title': title,
        'image': copiedImage?.path ?? '',
      },
    );
    final place = Place(title: title, image: copiedImage);
    state = [place, ...state];
  }
}

final userPlaceProvider =
    StateNotifierProvider<UserPlaceNotifier, List<Place>>((ref) {
  return UserPlaceNotifier();
});
