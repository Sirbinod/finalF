import 'package:flutter/material.dart';
import 'package:friendlocator/Model/place.dart';
import 'package:friendlocator/styleguide.dart';

class PlaceWidget extends StatelessWidget {
  final Place place;

  const PlaceWidget({Key key, this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20),
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24))),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              child: Image.asset(
                place.imagePath,
                height: 150,
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          place.title,
                          style: placeTitleTextStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FittedBox(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.location_on),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                place.location,
                                style: placeLocationTextStyle,
                              ),
                            ],
                          ),
                        ),
                        FittedBox(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.phone),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                place.phone,
                                style: placeLocationTextStyle,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // Expanded(
                  //   flex: 1,
                  //   child: Text(
                  //     event.duration.toUpperCase(),
                  //     textAlign: TextAlign.right,
                  //     style: eventLocationTextStyle.copyWith(
                  //       fontWeight: FontWeight.w900,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
