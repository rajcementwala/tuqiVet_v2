import '../api_constants.dart';

class User {
  User({
    required this.id,
    required this.email,
    required this.name,
    required this.gender,
    required this.status,
  });

  int id;
  String name;
  String email;
  String gender;
  String status;

  static List<User> fromMapList(List<dynamic> list) {
    return list
        .map((element) => User.fromMap(Map<String, dynamic>.from(element)))
        .toList();
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      email: map[ApiConstants.email],
      gender: map[ApiConstants.gender],
      id: map[ApiConstants.id],
      name: map[ApiConstants.name],
      status: map[ApiConstants.status],
    );
  }
}
