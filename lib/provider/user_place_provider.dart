import 'dart:io';

import 'package:favorite_places/model/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPlaceNotifier extends StateNotifier<List<Place>> {
  UserPlaceNotifier() : super([]);

  void addPlace(String title, File? image) {
    final place = Place(title: title, image: image);
    state = [place, ...state];
  }
}

final userPlaceProvider =
    StateNotifierProvider<UserPlaceNotifier, List<Place>>((ref) {
  return UserPlaceNotifier();
});
