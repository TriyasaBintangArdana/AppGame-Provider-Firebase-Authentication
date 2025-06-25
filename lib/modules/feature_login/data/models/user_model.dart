import 'package:app_games/modules/feature_login/domain/entities/authentication_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? uid;
  final String? name;
  final String? email;
  final int? balance;
  final DateTime? createdAt;
  final String? photoUrl;

  const UserModel({
    this.uid,
    this.name,
    this.email,
    this.balance,
    this.createdAt,
    this.photoUrl,
  });

  AuthenticationUser toEntity() {
    return AuthenticationUser(
      uid: uid,
      email: email,
      name: name,
      balance: balance,
      createdAt: createdAt,
      photoUrl: photoUrl,
    );
  }

  factory UserModel.fromEntity(AuthenticationUser user) {
    return UserModel(
      uid: user.uid,
      name: user.name,
      email: user.email,
      balance: user.balance,
      photoUrl: user.photoUrl,
      createdAt: user.createdAt,
    );
  }

  factory UserModel.fromFirestore(Map<String, dynamic> map) {
    final createdAtRaw = map['created_at'];
  DateTime? createdAt;

  if (createdAtRaw is Timestamp) {
    createdAt = createdAtRaw.toDate();
  } else if (createdAtRaw is int) {
    createdAt = DateTime.fromMillisecondsSinceEpoch(createdAtRaw);
  }
    return UserModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      balance: map['balance'] != null ? map['balance'] as int : null,
      createdAt: createdAt,
      photoUrl: map['photo_url'] != null ? map['photo_url'] as String : null,
    );
  }

  @override
  List<Object?> get props {
    return [
      uid,
      name,
      email,
      balance,
      createdAt,
      photoUrl,
    ];
  }
}