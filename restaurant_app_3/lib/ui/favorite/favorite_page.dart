import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/favorite_provider.dart';
import '../home/restaurant_item.dart';

class FavoritePage extends StatelessWidget{
  static const route = '/favorite';
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Favorites"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Consumer<FavoriteProvider>(
                builder: (context, state, child){
                  if (state.state == ResultState.noData){
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.favorites.length,
                      itemBuilder: (context, index) {
                        return RestaurantItem(
                          restaurant: state.favorites[index],
                        );
                      },
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.only(top: 20),
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: const Text("Tidak ada data yang ditemukan",textAlign: TextAlign.center, style: TextStyle(fontSize: 20,),),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}