import 'package:flutter/material.dart';

enum ServiceType {
  teaParty,
  weddings,
  decorations,
  musicServices,
  eventOrganization,
  equipment,
}

class ServiceCategory {
  final String id;
  final ServiceType type;
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;
  final Color gradientStart;
  final Color gradientEnd;
  final List<String> features;
  final List<String> galleryImages;
  final String heroImage;

  const ServiceCategory({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
    required this.gradientStart,
    required this.gradientEnd,
    required this.features,
    required this.galleryImages,
    required this.heroImage,
  });

  LinearGradient get gradient => LinearGradient(
        colors: [gradientStart, gradientEnd],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}

class ServiceItem {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final String? imageUrl;

  const ServiceItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    this.imageUrl,
  });
}
