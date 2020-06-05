class Place {
  final String imagePath, title, location, phone;
  final List categoryIds;

  Place({
    this.imagePath,
    this.title,
    this.location,
    this.phone,
    this.categoryIds,
  });
}

final omHospitalPlace = Place(
    imagePath: "assets/place_images/OmHospital.jpg",
    title: "om Hospital",
    location: "Chabahil",
    phone: "01-4476225",
    categoryIds: [0, 1]);

final tuHospitalPlace = Place(
  imagePath: "assets/place_images/TeachingHospital.jpg",
  title: "TU Teaching Hospital",
  location: "Maharanjganj",
  phone: "01-4412303",
  categoryIds: [0, 1],
);

final birHospitalPlace = Place(
    imagePath: "assets/place_images/BirHospital.jpg",
    title: "Bir Hospital",
    location: "Kanti Path, Kathmandu",
    phone: "01-4221119",
    categoryIds: [0, 1]);

final headOfficePlace = Place(
    imagePath: "assets/place_images/policeH.jpg",
    title: "Nepal Police",
    location: "Sama Marg",
    phone: "01-4411210",
    categoryIds: [0, 2]);
final metroOfficePlace = Place(
    imagePath: "assets/place_images/police1.jpg",
    title: "Metro Police",
    location: "Ratna park",
    phone: "01-4231466",
    categoryIds: [0, 2]);
final fireOfficePlace = Place(
    imagePath: "assets/place_images/fire.jpg",
    title: "fire brigade",
    location: "Kathmandu",
    phone: "01-4228435",
    categoryIds: [0, 3]);
final ambulancePlace = Place(
    imagePath: "assets/place_images/ambulance.jpg",
    title: "Paropakar Ambulance",
    location: "Paropakar Marga",
    phone: "01-4260859",
    categoryIds: [0, 4]);
final heliAmbulancePlace = Place(
    imagePath: "assets/place_images/H.jpg",
    title: "Air Ambulance",
    location: "Kathmandu",
    phone: "9860939995",
    categoryIds: [0, 4]);
final maitiNepalPlace = Place(
    imagePath: "assets/place_images/maitineapl.jpg",
    title: "Maiti Nepal",
    location: "Kathmandu",
    phone: "01-4492904",
    categoryIds: [0, 5]);
final childproPlace = Place(
    imagePath: "assets/place_images/childpro.jpg",
    title: "CHild Protection",
    location: "Kathmandu",
    phone: "01-4411000",
    categoryIds: [0, 5]);

final places = [
  omHospitalPlace,
  tuHospitalPlace,
  birHospitalPlace,
  headOfficePlace,
  metroOfficePlace,
  fireOfficePlace,
  ambulancePlace,
  heliAmbulancePlace,
  maitiNepalPlace,
  childproPlace
];
