import 'package:equatable/equatable.dart';

enum UserRole {
  attendee,
  organizer,
  admin
}

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final String? bio;
  final UserRole role;
  final DateTime createdAt;
  final List<String> interests;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.bio,
    this.role = UserRole.attendee,
    required this.createdAt,
    this.interests = const [],
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    String? bio,
    UserRole? role,
    DateTime? createdAt,
    List<String>? interests,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      interests: interests ?? this.interests,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        avatarUrl,
        bio,
        role,
        createdAt,
        interests,
      ];
}
