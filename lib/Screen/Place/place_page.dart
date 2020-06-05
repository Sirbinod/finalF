import 'package:flutter/material.dart';
import 'package:friendlocator/Model/category.dart';
import 'package:friendlocator/Model/place.dart';
import 'package:friendlocator/Screen/Place/place_page_background.dart';
import 'package:friendlocator/Screen/Place/place_widget.dart';
import '../../app_state.dart';
import 'category_widget.dart';
import 'package:provider/provider.dart';

class PlacePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Helpline place"),
        backgroundColor: Colors.pink,
      ),
      body: ChangeNotifierProvider<AppState>(
        create: (_) => AppState(),
        child: Stack(
          children: <Widget>[
            PlacePageBackground(
              screenHeight: MediaQuery.of(context).size.height,
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Consumer<AppState>(
                        builder: (context, appState, _) =>
                            SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              for (final category in categories)
                                CategoryWidget(category: category)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Consumer<AppState>(
                        builder: (context, appState, _) => Column(
                          children: <Widget>[
                            for (final place in places.where((e) => e
                                .categoryIds
                                .contains(appState.selectedCategoryId)))
                              GestureDetector(
                                // onTap: () {
                                //   Navigator.of(context).push(
                                //     MaterialPageRoute(
                                //         // builder: (context) => EventDetailsPage(event: event),
                                //         ),
                                //   );
                                // },
                                child: PlaceWidget(
                                  place: place,
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
