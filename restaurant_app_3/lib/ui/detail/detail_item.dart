import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/restaurant_detail_provider.dart';

class DetailItem extends StatelessWidget {
  const DetailItem({Key? key}) : super(key: key);

  String getImage(id) {
    return "https://restaurant-api.dicoding.dev/images/small/$id";
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RestaurantDetailProvider>(context);
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
            ),
          ),
          child: Image.network(
              getImage(state.result!.restaurant!.pictureId.toString())),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Text(
                state.result!.restaurant!.name.toString(),
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.location_city,
                    color: Colors.grey,
                  ),
                  Text(
                    state.result!.restaurant!.city.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.location_on,
                    color: Colors.grey,
                  ),
                  Text(
                    state.result!.restaurant!.address.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Description",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                state.result!.restaurant!.description.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Categories",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children:
                    state.result!.restaurant!.categories!.map((categories) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.green[50],
                    ),
                    child: Text(
                      categories.name.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Foods",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                height: 70.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: state.result!.restaurant!.menus!.foods!.map(
                    (foods) {
                      return Container(
                        width: 170,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                foods.name.toString(),
                                style: const TextStyle(color: Colors.black),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.green[50],
                                ),
                                child: const Text(
                                  "RP xxxxxxx",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Drinks",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                height: 70.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: state.result!.restaurant!.menus!.drinks!.map(
                    (drinks) {
                      return Container(
                        width: 170,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                drinks.name.toString(),
                                style: const TextStyle(color: Colors.black),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.green[50],
                                ),
                                child: const Text(
                                  "RP xxxxxxx",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Reviews",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                height: 150.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: state.result!.restaurant!.customerReviews!.map(
                    (reviews) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.15,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 10, right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.date_range,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      reviews.date.toString(),
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    )
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.grey[100],
                                  ),
                                  child: Text(
                                    reviews.name.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(reviews.review.toString())
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
