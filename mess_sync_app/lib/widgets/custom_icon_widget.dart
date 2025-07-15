import 'package:flutter/material.dart';

class CustomIconWidget extends StatelessWidget {
  final String iconName;
  final Color color;
  final double size;

  const CustomIconWidget({
    Key? key,
    required this.iconName,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      _getIcon(iconName),
      color: color,
      size: size,
    );
  }

  IconData _getIcon(String name) {
    switch (name) {
      case 'check_circle':
        return Icons.check_circle;
      case 'pending_actions':
        return Icons.pending_actions;
      case 'people':
        return Icons.people;
      case 'warning':
        return Icons.warning;
      case 'attach_money':
        return Icons.attach_money;
      case 'emergency':
        return Icons.emergency;
      case 'construction':
        return Icons.construction;
      case 'close':
        return Icons.close;
      case 'add':
        return Icons.add;
      case 'person_add':
        return Icons.person_add;
      case 'inventory_2':
        return Icons.inventory_2;
      case 'hotel':
        return Icons.hotel;
      case 'report_problem':
        return Icons.report_problem;
      default:
        return Icons.help_outline;
    }
  }
}
