class UserModel {
  final String uid;
  final String? email;
  final String? name;
  final String? username;

  UserModel({
    required this.uid,
    this.email,
    this.name,
    this.username,
  });
}
