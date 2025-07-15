import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:mess_sync_app/constants/app_colors.dart';
import 'package:mess_sync_app/widgets/custom_icon_widget.dart';

class QuickAddMenuWidget extends StatelessWidget {
  final VoidCallback onClose;

  const QuickAddMenuWidget({
    super.key,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildMenuItem(
          context,
          'Add Inventory Item',
          'inventory_2',
          AppTheme.lightTheme.colorScheme.primary,
          () => _handleMenuAction(context, 'inventory'),
        ),
        SizedBox(height: 2.h),
        _buildMenuItem(
          context,
          'Create User Account',
          'person_add',
          AppTheme.successColor,
          () => _handleMenuAction(context, 'user'),
        ),
        SizedBox(height: 2.h),
        _buildMenuItem(
          context,
          'Post Announcement',
          'campaign',
          AppTheme.warningColor,
          () => _handleMenuAction(context, 'announcement'),
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    String icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppTheme.lightTheme.colorScheme.shadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: icon,
                color: color,
                size: 20,
              ),
            ),
            SizedBox(width: 3.w),
            Text(
              title,
              style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuAction(BuildContext context, String action) {
    onClose();

    String message;
    switch (action) {
      case 'inventory':
        message = 'Opening inventory management...';
        break;
      case 'user':
        message = 'Opening user creation form...';
        break;
      case 'announcement':
        message = 'Opening announcement composer...';
        break;
      default:
        message = 'Action not implemented yet';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
