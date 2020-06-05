import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Category {
  final int categoryId;
  final String name;
  final IconData icon;

  Category({this.categoryId, this.name, this.icon});
}

final allCategory = Category(
  categoryId: 0,
  name: "All",
  icon: Icons.search,
);

final hospitalCategory = Category(
  categoryId: 1,
  name: "Hospital",
  icon: Icons.local_hospital,
);

final policeCategory = Category(
  categoryId: 2,
  name: "Police",
  icon: Icons.people,
);

final firebrigadeCategory = Category(
  categoryId: 3,
  name: "fire brigade",
  icon: Icons.airport_shuttle,
);
final ambulanceCategory = Category(
  categoryId: 4,
  name: "ambulance",
  icon: Icons.directions_car,
);

final ngoCategory = Category(
  categoryId: 5,
  name: "NGO",
  icon: Icons.mood,
);

final categories = [
  allCategory,
  hospitalCategory,
  policeCategory,
  firebrigadeCategory,
  ambulanceCategory,
  ngoCategory,
];
