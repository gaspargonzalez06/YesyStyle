import 'package:equatable/equatable.dart';

enum RSVPStatus {
  going,
  maybe,
  notGoing,
  waitlist
}

class RSVP extends Equatable {
  final String id;
  final String eventId;
  final String userId;
  final String userName;
  final String? userAvatar;
  final RSVPStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? notes;
  final int? guestCount;

  const RSVP({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.notes,
    this.guestCount,
  });

  RSVP copyWith({
    String? id,
    String? eventId,
    String? userId,
    String? userName,
    String? userAvatar,
    RSVPStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? notes,
    int? guestCount,
  }) {
    return RSVP(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
      guestCount: guestCount ?? this.guestCount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        eventId,
        userId,
        userName,
        userAvatar,
        status,
        createdAt,
        updatedAt,
        notes,
        guestCount,
      ];
}
