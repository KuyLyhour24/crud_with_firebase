
class UserModel {
  String? id;
  String name;
  int age;
  String email;
  String password;
  String created_date;
  String updated_date;

  UserModel({
    this.id,
    required this.name,
    required this.age,
    required this.email,
    required this.password,
    required this.created_date,
    required this.updated_date,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'email': email,
      'password': password,
      'created_date': created_date,
      'updated_date': updated_date,
    };
  }

  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    return UserModel(
      id: id,
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      created_date: map['created_date'] ?? '',
      updated_date: map['updated_date'] ?? '',
    );
  }
}
