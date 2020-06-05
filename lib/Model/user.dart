class User {
  int id;
  String name;
  String mobile;
  String gender;
  String age;

  User(this.name, this.mobile, this.gender, this.age);
  Map<String, dynamic> toUserMap() {
    return {
      'name': name,
      'mobile': mobile,
      'gender': gender,
      'age': age,
    };
  }

  User.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.mobile = map['mobile'];
    this.gender = map['gender'];
    this.age = map['age'];
  }
}
