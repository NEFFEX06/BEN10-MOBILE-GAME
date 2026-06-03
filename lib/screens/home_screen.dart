import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/game_provider.dart';
import '../providers/alien_provider.dart';
import '../providers/mission_provider.dart';
import '../utils/theme.dart';
import 'mission_list_screen.dart';
import 'alien_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF0F2847),
                      const Color(0xFF0A1628),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ben 10',
                      style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    Text(
                      'Alien Force',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w300,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // Stats Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatCard(
                          'Coins',
                          '${context.watch<GameProvider>().coins}',
                          Icons.monetization_on,
                        ),
                        _buildStatCard(
                          'Score',
                          '${context.watch<GameProvider>().totalScore}',
                          Icons.star,
                        ),
                        _buildStatCard(
                          'Aliens',
                          '${context.watch<AlienProvider>().getUnlockedAliens().length}/8',
                          Icons.groups,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              
              // Main Menu Buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    _buildMenuButton(
                      context,
                      'Play Mission',
                      'Start Story Campaign',
                      Icons.play_circle_fill,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MissionListScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 15.h),
                    _buildMenuButton(
                      context,
                      'Select Alien',
                      'Transform & Explore',
                      Icons.transform,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AlienSelectionScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 15.h),
                    _buildMenuButton(
                      context,
                      'Free Roam',
                      'Explore the World',
                      Icons.explore,
                      () {
                        // TODO: Implement Free Roam
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Free Roam Coming Soon!')),
                        );
                      },
                    ),
                    SizedBox(height: 15.h),
                    _buildMenuButton(
                      context,
                      'Upgrades',
                      'Unlock New Aliens',
                      Icons.upgrade,
                      () {
                        // TODO: Implement Upgrades
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Upgrades Coming Soon!')),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              
              // Game Stats
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: AppTheme.cardBackground,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppTheme.primaryColor,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Progress',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      _buildProgressItem(
                        'Missions Completed',
                        context.watch<MissionProvider>().getCompletedMissions().length,
                        context.watch<MissionProvider>().missions.length,
                      ),
                      SizedBox(height: 10.h),
                      _buildProgressItem(
                        'Aliens Unlocked',
                        context.watch<AlienProvider>().getUnlockedAliens().length,
                        8,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.primaryColor, size: 32.sp),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuButton(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppTheme.primaryColor,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.primaryColor, size: 32.sp),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.primaryColor,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressItem(String label, int current, int total) {
    double progress = current / total;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppTheme.textSecondary,
              ),
            ),
            Text(
              '$current/$total',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 5.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8.h,
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
          ),
        ),
      ],
    );
  }
}
