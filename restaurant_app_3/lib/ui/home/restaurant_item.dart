import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_2/provider/favorite_provider.dart';
import '../../model/restaurant_model.dart';
import '../detail/detailpage.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant? restaurant;
  const RestaurantItem({Key? key, required this.restaurant}) : super(key: key);

  String getImage(id) {
    return "https://restaurant-api.dicoding.dev/images/small/$id";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorited(restaurant!.id.toString()),
          builder: (context, snapshot) {
            var isFavorited = snapshot.data ?? false;
            return InkWell(
              onTap: () => Navigator.pushNamed(context, DetailPage.route,
                  arguments: restaurant!.id),
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          height: 100,
                          width: 120,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                            ),
                          ),
                          child: Image.network(
                              getImage(restaurant!.pictureId.toString())),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                restaurant!.name.toString(),
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    restaurant!.city.toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Text(
                                    restaurant!.rating.toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                          isFavorited
                              ? Icons.favorite_rounded
                              : Icons.favorite_outline_rounded,
                          color: Colors.red),
                      onPressed: () {
                        var snackBarTrue = SnackBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          content: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Add restaurant to favorite',
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ),
                        );
                        var snackBarFalse = SnackBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          content: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Delete restaurant from favorite',
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ),
                        );
                        isFavorited
                            ? provider.deleteFavorite(restaurant!.id.toString())
                            : provider.addFavorite(restaurant!);
                        isFavorited
                            ? ScaffoldMessenger.of(context)
                                .showSnackBar(snackBarFalse)
                            : ScaffoldMessenger.of(context)
                                .showSnackBar(snackBarTrue);
                      },
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
