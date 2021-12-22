import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_2/menu/items.dart';
import 'package:restaurant_app_2/menu/menu_item.dart';
import 'package:restaurant_app_2/provider/restaurant_provider.dart';
import 'package:restaurant_app_2/ui/setting/setting_page.dart';

import '../favorite/favorite_page.dart';
import '../home/restaurant_item.dart';
import '../search/search.dart';

class HomePage extends StatelessWidget {
  static const route = '/homepage';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => HomeProvider(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: <Widget>[
            PopupMenuButton<MenuItem>(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                ...Items.items.map(buildItem).toList()
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, SearchPage.route),
                      child: AbsorbPointer(
                        child: TextFormField(
                          maxLines: 1,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Search....",
                            labelText: "Search Restaurant",
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Text(
                          "Restaurants",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Text(
                          "Enjoy our service",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<HomeProvider>(
                        builder: (context, state, _) {
                          if (state.state == ResultState.loading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state.state == ResultState.hasData) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.result!.restaurants!.length,
                              itemBuilder: (context, index) {
                                return RestaurantItem(
                                  restaurant: state.result!.restaurants![index],
                                );
                              },
                            );
                          } else if (state.state == ResultState.noData) {
                            return Center(
                              child: Text(state.message.toString()),
                            );
                          } else {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    color: Colors.white,
                                    height: MediaQuery.of(context).size.height,
                                    child: const Text("No Connection",
                                        style: TextStyle(fontSize: 18)),
                                  ),
                                  Text(state.message.toString()),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  ElevatedButton(
                                    child: const Text('Refresh'),
                                    onPressed: () => state.refresh(),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        textStyle: const TextStyle(
                                            color: Colors.black)),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem(
    value: item,
    child: Row(
      children: <Widget>[
        Icon(item.icon, color: Colors.grey,),
        const SizedBox(width: 12,),
        Text(item.text),
      ],
    ),
  );

  void onSelected(BuildContext context, MenuItem item){
    switch (item){
      case Items.itemSetting: 
        Navigator.pushNamed(context, SettingPage.route);
        break;
      
      case Items.itemFavorite:
        Navigator.pushNamed(context, FavoritePage.route);
        break;
    }
  }
}
