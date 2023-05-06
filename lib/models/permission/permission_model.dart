import 'package:flutter/material.dart';

class PermissionModel {
  PermissionModel({
    this.title = '',
    this.icon = const Icon(Icons.abc),
    this.description = '',
    this.isRequired = false,
    this.isExpanded = false,
  });

  String title;
  dynamic icon;
  String description;
  bool isRequired;
  bool isExpanded;

  PermissionModel copyWith({
    String title = '',
    Icon icon = const Icon(Icons.abc),
    String description = '',
    bool isRequired = false,
    bool isExpanded = false,
  }) {
    return PermissionModel(
      title: title,
      icon: icon,
      description: description,
      isRequired: isRequired,
      isExpanded: isExpanded,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'icon': icon,
      'description': description,
      'isRequired': isRequired,
      'isExpanded': isExpanded,
    };
  }
}
