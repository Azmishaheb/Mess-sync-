import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:mess_sync_app/constants/app_colors.dart';
import 'package:mess_sync_app/widgets/custom_icon_widget.dart';

class PriorityActionCardWidget extends StatelessWidget {
  final String title;
  final int count;
  final String description;
  final String icon;
  final Color color;
  final bool isUrgent;
  final VoidCallback? onTap;

  const PriorityActionCardWidget({
    super.key,
    required this.title,
    required this.count,
    required this.description,
    required this.icon,
    required this.color,
    required this.isUrgent,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: isUrgent
              ? Border.all(color: color.withValues(alpha: 0.3), width: 1.5)
              : null,
          boxShadow: [
            BoxShadow(
              color: AppTheme.lightTheme.colorScheme.shadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2.5.w),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CustomIconWidget(
                    iconName: icon,
                    color: color,
                    size: 24,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: AppTheme.lightTheme.textTheme.titleMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isUrgent)
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 0.5.h),
                              decoration: BoxDecoration(
                                color: AppTheme.lightTheme.colorScheme.error
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'URGENT',
                                style: AppTheme.lightTheme.textTheme.labelSmall
                                    ?.copyWith(
                                  color: AppTheme.lightTheme.colorScheme.error,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        description,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$count ${count == 1 ? 'item' : 'items'}',
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  children: [
                    if (title.contains('Approval'))
                      _buildActionButton(
                        'check',
                        AppTheme.successColor,
                        () => _handleQuickAction(context, 'approve'),
                      ),
                    if (title.contains('Approval')) SizedBox(width: 2.w),
                    if (title.contains('Approval'))
                      _buildActionButton(
                        'close',
                        AppTheme.lightTheme.colorScheme.error,
                        () => _handleQuickAction(context, 'deny'),
                      ),
                    if (!title.contains('Approval'))
                      _buildActionButton(
                        'arrow_forward',
                        AppTheme.lightTheme.colorScheme.primary,
                        onTap,
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
      String iconName, Color color, VoidCallback? onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: CustomIconWidget(
          iconName: iconName,
          color: color,
          size: 16,
        ),
      ),
    );
  }

  void _handleQuickAction(BuildContext context, String action) {
    final actionText = action == 'approve' ? 'approved' : 'denied';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Request $actionText successfully'),
        backgroundColor: action == 'approve'
            ? AppTheme.successColor
            : AppTheme.lightTheme.colorScheme.error,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
