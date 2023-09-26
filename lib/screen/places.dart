import 'package:favorite_places/provider/user_place_provider.dart';
import 'package:favorite_places/screen/add_place.dart';
import 'package:favorite_places/widget/place_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesListScreen extends ConsumerWidget {
  const PlacesListScreen({super.key});

  void showAddPlaceScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const AddPlaceScreen();
    }));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(userPlaceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () => {showAddPlaceScreen(context)},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: PlaceList(places: places),
    );
  }
}
