class User {
  String name;
  int cycle;
  int gender;

  User({required this.name, required this.cycle, required this.gender});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'], cycle: json['cycle'], gender: json['gender']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'cycle': cycle, 'gender': gender};
  }
}
