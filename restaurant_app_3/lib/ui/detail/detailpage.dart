import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './detail_item.dart';
import '../../provider/restaurant_detail_provider.dart';

class DetailPage extends StatefulWidget {
  static const route = '/detail_page';
  final String? id;
  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailPage createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(context, id: widget.id),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Restaurant Detail"),
        ),
        body: SingleChildScrollView(
          child: Consumer<RestaurantDetailProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.state == ResultState.hasData) {
                return const DetailItem();
              } else if (state.state == ResultState.noData) {
                return Center(
                  child: Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height,
                    child:
                        const Text("No Result", style: TextStyle(fontSize: 18)),
                  ),
                );
              } else {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height,
                        child: const Text("No Connection",
                            style: TextStyle(fontSize: 18)),
                      ),
                      Text(state.message.toString()),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        child: const Text('Refresh'),
                        onPressed: () => state.refresh(),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            textStyle: const TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
