// lib/models/user.dart
class User {
  final int? userId;  // matches user_id in backend
  final String name;
  final String email;
  final String telephoneNumber;  // we'll handle the BIGINT as String in Flutter
  final int tCoin;  // matches t_coin in backend
  
  User({
    this.userId,
    required this.name,
    required this.email,
    required this.telephoneNumber,
    this.tCoin = 0,  // default value matching backend
  });

  // Convert JSON (from backend) to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      telephoneNumber: json['telephone_number'].toString(), // Convert BIGINT to String
      tCoin: json['t_coin'] ?? 0,
    );
  }

  // Convert User object to JSON (to send to backend)
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'telephone_number': telephoneNumber,
      't_coin': tCoin,
    };
  }

  // Create a copy of User with modified fields
  User copyWith({
    int? userId,
    String? name,
    String? email,
    String? telephoneNumber,
    int? tCoin,
  }) {
    return User(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      telephoneNumber: telephoneNumber ?? this.telephoneNumber,
      tCoin: tCoin ?? this.tCoin,
    );
  }
}