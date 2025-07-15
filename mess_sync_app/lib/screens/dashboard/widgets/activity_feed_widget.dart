import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:mess_sync_app/constants/app_colors.dart';
import 'package:mess_sync_app/widgets/custom_icon_widget.dart';

class ActivityFeedWidget extends StatelessWidget {
  final List<Map<String, dynamic>> activities;

  const ActivityFeedWidget({
    super.key,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(4.w),
        itemCount: activities.length,
        separatorBuilder: (context, index) => Divider(
          height: 3.h,
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
        itemBuilder: (context, index) {
          final activity = activities[index];
          return _buildActivityItem(activity);
        },
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User Avatar
        Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: ClipOval(),
        ),
        SizedBox(width: 3.w),

        // Activity Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      activity["user"] as String,
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    activity["timestamp"] as String,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.5.h),
              Text(
                activity["action"] as String,
                style: AppTheme.lightTheme.textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        // Activity Type Icon
        Container(
          padding: EdgeInsets.all(1.5.w),
          decoration: BoxDecoration(
            color: _getActivityTypeColor(activity["type"] as String)
                .withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: CustomIconWidget(
            iconName: _getActivityTypeIcon(activity["type"] as String),
            color: _getActivityTypeColor(activity["type"] as String),
            size: 14,
          ),
        ),
      ],
    );
  }

  String _getActivityTypeIcon(String type) {
    switch (type) {
      case 'approval':
        return 'check_circle';
      case 'update':
        return 'edit';
      case 'resolution':
        return 'task_alt';
      case 'inventory':
        return 'inventory_2';
      default:
        return 'info';
    }
  }

  Color _getActivityTypeColor(String type) {
    switch (type) {
      case 'approval':
        return AppTheme.successColor;
      case 'update':
        return AppTheme.lightTheme.colorScheme.primary;
      case 'resolution':
        return AppTheme.warningColor;
      case 'inventory':
        return AppTheme.lightTheme.colorScheme.secondary;
      default:
        return AppTheme.lightTheme.colorScheme.onSurfaceVariant;
    }
  }
}
