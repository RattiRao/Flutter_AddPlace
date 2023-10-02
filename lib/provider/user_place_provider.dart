import 'dart:io';

import 'package:favorite_places/model/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as SysPath;
import 'package:path/path.dart' as path;

class UserPlaceNotifier extends StateNotifier<List<Place>> {
  UserPlaceNotifier() : super([]);

  Future<void> addPlace(String title, File? image) async {
    File? copiedImage;
    if (image != null) {
      final appDir = await SysPath.getApplicationDocumentsDirectory();
      final imageName = path.basename(image.path);
      copiedImage = await image.copy('${appDir.path}/$imageName');
    }

    final place = Place(title: title, image: copiedImage);
    state = [place, ...state];
  }
}

final userPlaceProvider =
    StateNotifierProvider<UserPlaceNotifier, List<Place>>((ref) {
  return UserPlaceNotifier();
});
