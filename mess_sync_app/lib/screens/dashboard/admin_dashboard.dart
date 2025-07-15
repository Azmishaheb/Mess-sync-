import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:mess_sync_app/constants/app_colors.dart';
import 'package:mess_sync_app/widgets/custom_icon_widget.dart';
import './widgets/activity_feed_widget.dart';
import './widgets/metric_card_widget.dart';
import './widgets/priority_action_card_widget.dart';
import './widgets/quick_add_menu_widget.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isRefreshing = false;
  bool _showQuickAddMenu = false;

  // Mock data for dashboard metrics
  final Map<String, dynamic> dashboardData = {
    "adminName": "Colonel Arindom",
    "messStatus": "Operational",
    "metrics": {
      "pendingApprovals": 12,
      "activeDiningMembers": 247,
      "inventoryAlerts": 8,
      "monthlyRevenue": "\$45,280"
    },
    "priorityActions": [
      {
        "id": 1,
        "type": "user_approval",
        "title": "User Approval Requests",
        "count": 5,
        "description": "New registration requests pending",
        "icon": "person_add",
        "color": 0xFFF39C12,
        "urgent": true
      },
      {
        "id": 2,
        "type": "inventory_alert",
        "title": "Low Stock Alerts",
        "count": 8,
        "description": "Items below minimum threshold",
        "icon": "inventory_2",
        "color": 0xFFE74C3C,
        "urgent": true
      },
      {
        "id": 3,
        "type": "room_requests",
        "title": "Room Requests",
        "count": 3,
        "description": "Pending room allocation requests",
        "icon": "hotel",
        "color": 0xFF3498DB,
        "urgent": false
      },
      {
        "id": 4,
        "type": "complaints",
        "title": "Unresolved Complaints",
        "count": 2,
        "description": "Complaints requiring attention",
        "icon": "report_problem",
        "color": 0xFFE67E22,
        "urgent": false
      }
    ],
    "recentActivity": [
      {
        "id": 1,
        "user": "Major Nazmul",
        "avatar":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
        "action": "Approved inventory purchase request",
        "timestamp": "2 hours ago",
        "type": "approval"
      },
      {
        "id": 2,
        "user": "Captain Ramisa",
        "avatar":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
        "action": "Updated dining menu for tomorrow",
        "timestamp": "4 hours ago",
        "type": "update"
      },
      {
        "id": 3,
        "user": "Lieutenant Tahmid",
        "avatar":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
        "action": "Resolved room allocation complaint",
        "timestamp": "6 hours ago",
        "type": "resolution"
      },
      {
        "id": 4,
        "user": "Sergeant Piplu",
        "avatar":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
        "action": "Added new inventory items to stock",
        "timestamp": "8 hours ago",
        "type": "inventory"
      }
    ]
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
    });
  }

  void _toggleQuickAddMenu() {
    setState(() {
      _showQuickAddMenu = !_showQuickAddMenu;
    });
  }

  void _navigateToScreen(String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Tab Bar Header
            Container(
              color: AppTheme.lightTheme.colorScheme.surface,
              child: Column(
                children: [
                  // Greeting Header
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good Morning,',
                                style: AppTheme.lightTheme.textTheme.bodyMedium
                                    ?.copyWith(
                                  color: AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                dashboardData["adminName"] as String,
                                style: AppTheme.lightTheme.textTheme.titleLarge
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 1.h),
                          decoration: BoxDecoration(
                            color: AppTheme.successColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomIconWidget(
                                iconName: 'check_circle',
                                color: AppTheme.successColor,
                                size: 16,
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                dashboardData["messStatus"] as String,
                                style: AppTheme.lightTheme.textTheme.labelMedium
                                    ?.copyWith(
                                  color: AppTheme.successColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Tab Bar
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Dashboard'),
                      Tab(text: 'Inventory'),
                      Tab(text: 'Users'),
                      Tab(text: 'Reports'),
                    ],
                  ),
                ],
              ),
            ),
            // Tab Bar View
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Dashboard Tab (Active)
                  _buildDashboardTab(),
                  // Other tabs with placeholder content
                  _buildPlaceholderTab('Inventory Management'),
                  _buildPlaceholderTab('User Management'),
                  _buildPlaceholderTab('Reports & Analytics'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          FloatingActionButton(
            onPressed: _toggleQuickAddMenu,
            child: AnimatedRotation(
              turns: _showQuickAddMenu ? 0.125 : 0,
              duration: const Duration(milliseconds: 200),
              child: CustomIconWidget(
                iconName: _showQuickAddMenu ? 'close' : 'add',
                color: AppTheme.lightTheme.colorScheme.onSecondary,
                size: 24,
              ),
            ),
          ),
          if (_showQuickAddMenu)
            Positioned(
              bottom: 80,
              right: 0,
              child: QuickAddMenuWidget(
                onClose: _toggleQuickAddMenu,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDashboardTab() {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Metrics Row
            Row(
              children: [
                Expanded(
                  child: MetricCardWidget(
                    title: 'Pending Approvals',
                    value: (dashboardData["metrics"]["pendingApprovals"] as int)
                        .toString(),
                    icon: 'pending_actions',
                    color: AppTheme.warningColor,
                    onTap: () => _navigateToScreen('/admin-dashboard'),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: MetricCardWidget(
                    title: 'Active Members',
                    value:
                        (dashboardData["metrics"]["activeDiningMembers"] as int)
                            .toString(),
                    icon: 'people',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    onTap: () => _navigateToScreen('/admin-dashboard'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: MetricCardWidget(
                    title: 'Inventory Alerts',
                    value: (dashboardData["metrics"]["inventoryAlerts"] as int)
                        .toString(),
                    icon: 'warning',
                    color: AppTheme.lightTheme.colorScheme.error,
                    onTap: () => _navigateToScreen('/admin-dashboard'),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: MetricCardWidget(
                    title: 'Monthly Revenue',
                    value: dashboardData["metrics"]["monthlyRevenue"] as String,
                    icon: 'attach_money',
                    color: AppTheme.successColor,
                    onTap: () => _navigateToScreen('/admin-dashboard'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),

            // Priority Actions Section
            Text(
              'Priority Actions',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: (dashboardData["priorityActions"] as List).length,
              separatorBuilder: (context, index) => SizedBox(height: 2.h),
              itemBuilder: (context, index) {
                final action = (dashboardData["priorityActions"] as List)[index]
                    as Map<String, dynamic>;
                return PriorityActionCardWidget(
                  title: action["title"] as String,
                  count: action["count"] as int,
                  description: action["description"] as String,
                  icon: action["icon"] as String,
                  color: Color(action["color"] as int),
                  isUrgent: action["urgent"] as bool,
                  onTap: () => _navigateToScreen('/admin-dashboard'),
                );
              },
            ),

            SizedBox(height: 3.h),

            // Recent Activity Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Activity',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () => _navigateToScreen('/admin-dashboard'),
                  child: Text('View All'),
                ),
              ],
            ),
            SizedBox(height: 1.h),

            ActivityFeedWidget(
              activities:
                  dashboardData["recentActivity"] as List<Map<String, dynamic>>,
            ),

            SizedBox(height: 3.h),

            // Emergency Contact Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.error
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.error
                      .withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'emergency',
                    color: AppTheme.lightTheme.colorScheme.error,
                    size: 24,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Emergency Contact',
                          style: AppTheme.lightTheme.textTheme.titleSmall
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Duty Officer: +1 (555) 123-4567',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.lightTheme.colorScheme.error,
                      foregroundColor: AppTheme.lightTheme.colorScheme.onError,
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                    ),
                    child: Text('Call'),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h), // Extra space for FAB
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderTab(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'construction',
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 48,
          ),
          SizedBox(height: 2.h),
          Text(
            title,
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          SizedBox(height: 1.h),
          Text(
            'Coming Soon',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
