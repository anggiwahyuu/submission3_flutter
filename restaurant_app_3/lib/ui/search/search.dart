import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/restaurant_provider.dart';
import '../home/restaurant_item.dart';

class SearchPage extends StatefulWidget {
  static const route = '/search';

  const SearchPage({Key? key}) : super(key: key);
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  final _textSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => HomeProvider(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Search"),
        ),
        body: Consumer<HomeProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: state.result!.restaurants!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: RestaurantItem(
                          restaurant: state.result!.restaurants![index],
                        ),
                      );
                    },
                    padding: const EdgeInsets.only(top: kToolbarHeight + 24),
                    shrinkWrap: true,
                  ),
                  _searchFiled(context, state)
                ],
              );
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 30),
                  height: MediaQuery.of(context).size.height,
                  child: const Text(
                    "Tidak ada data yang ditemukan",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
            } else {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(state.message.toString()),
                    const SizedBox(
                      height: 25,
                    ),
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
    );
  }

  Container _searchFiled(BuildContext context, HomeProvider state) {
    return Container(
      height: kToolbarHeight + 30,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: _textSearch,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          prefixIcon: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
            color: Colors.black,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: "Search ...",
          labelText: "Search restaurant",
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0.0),
          ),
          suffixIcon: const Padding(
            padding: EdgeInsets.all(0.0),
            child: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
        ),
        onSubmitted: (value) => state.setQuery(value),
      ),
    );
  }
}
