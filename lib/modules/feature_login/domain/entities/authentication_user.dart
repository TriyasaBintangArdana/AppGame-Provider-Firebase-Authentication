import 'package:equatable/equatable.dart';

class AuthenticationUser extends Equatable{
   final String? uid;
  final String? name;
  final String? email;
  final int? balance;
  final DateTime? createdAt;
  final String? photoUrl;


  const AuthenticationUser({
   this.uid,
    this.name,
    this.email,
    this.balance,
    this.createdAt,
    this.photoUrl,
  });

  factory AuthenticationUser.fromJson(Map<String, dynamic> json) {
  return AuthenticationUser(
    uid: json['uid'] as String?,
    name: json['name'] as String?,
    email: json['email'] as String?,
    balance: json['balance'] as int?,
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'])
        : null,
    photoUrl: json['photoUrl'] as String?,
  );
}
Map<String, dynamic> toJson() {
  return {
    'uid': uid,
    'name': name,
    'email': email,
    'balance': balance,
    'createdAt': createdAt?.toIso8601String(),
    'photoUrl': photoUrl,
  };
}

  @override
  List<Object?> get props => [ 
      uid,
      name,
      email,
      balance,
      createdAt,
      photoUrl,];

  
}