import 'package:favorite_places/model/place.dart';
import 'package:favorite_places/screen/place_details.dart';
import 'package:flutter/material.dart';

class PlaceList extends StatelessWidget {
  const PlaceList({super.key, required this.places});
  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          'No places added yet',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      );
    }
    return ListView.builder(
        itemCount: places.length,
        itemBuilder: (ctx, index) {
          Place place = places[index];
          return ListTile(
            contentPadding: const EdgeInsets.all(8),
            leading: CircleAvatar(
              radius: 26,
              backgroundColor: const Color.fromARGB(178, 191, 182, 182),
              backgroundImage:
                  place.image != null ? FileImage(place.image!) : null,
            ),
            title: Text(
              place.title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return PlaceDetailsScreen(place: place);
              }));
            },
          );
        });
  }
}
