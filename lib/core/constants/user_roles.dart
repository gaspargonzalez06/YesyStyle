enum UserRole {
  client,
  organizer,
  admin,
}

class UserRoleManager {
  static UserRole _currentRole = UserRole.client;

  static UserRole get currentRole => _currentRole;

  static void setRole(UserRole role) {
    _currentRole = role;
  }

  static bool get isClient => _currentRole == UserRole.client;
  static bool get isOrganizer => _currentRole == UserRole.organizer;
  static bool get isAdmin => _currentRole == UserRole.admin;

  static String getRoleName(UserRole role) {
    switch (role) {
      case UserRole.client:
        return 'Cliente';
      case UserRole.organizer:
        return 'Organizador';
      case UserRole.admin:
        return 'Administrador';
    }
  }

  static String getCurrentRoleName() => getRoleName(_currentRole);
}
