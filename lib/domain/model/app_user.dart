import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppUser extends Equatable {
  final String id;
  final String email;
  final String avatarUrl;
  final String fullName;

  const AppUser.empty({
    this.id = '',
    this.email = '',
    this.avatarUrl = '',
    this.fullName = '',
  });

//<editor-fold desc="Data Methods">
  const AppUser({
    required this.id,
    required this.email,
    required this.avatarUrl,
    required this.fullName,
  });

  @override
  List<Object?> get props => [id, email, avatarUrl, fullName];

  @override
  String toString() {
    return 'AppUser{ email: $email, avatarUrl: $avatarUrl, fullName: $fullName,}';
  }

  AppUser copyWith({
    String? email,
    String? avatarUrl,
    String? fullName,
  }) {
    return AppUser(
      id: id,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      fullName: fullName ?? this.fullName,
    );
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as String,
      email: map['email'] as String,
      avatarUrl: map['avatarUrl'] as String,
      fullName: map['fullName'] as String,
    );
  }

  factory AppUser.fromFirebaseUser(User user) {
    return AppUser(
      id: user.uid,
      email: user.email ?? '',
      avatarUrl: user.photoURL ?? '',
      fullName: user.displayName ?? '',
    );
  }

//</editor-fold>
}
