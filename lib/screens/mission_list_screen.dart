import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/mission_provider.dart';
import '../providers/alien_provider.dart';
import '../utils/theme.dart';
import 'mission_detail_screen.dart';

class MissionListScreen extends StatefulWidget {
  const MissionListScreen({Key? key}) : super(key: key);

  @override
  State<MissionListScreen> createState() => _MissionListScreenState();
}

class _MissionListScreenState extends State<MissionListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Missions'),
        elevation: 0,
      ),
      body: Consumer2<MissionProvider, AlienProvider>(
        builder: (context, missionProvider, alienProvider, _) {
          final missions = missionProvider.missions;
          
          return ListView.builder(
            padding: EdgeInsets.all(15.w),
            itemCount: missions.length,
            itemBuilder: (context, index) {
              final mission = missions[index];
              final isCompleted = mission.isCompleted;
              
              return Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MissionDetailScreen(
                          mission: mission,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(15.w),
                    decoration: BoxDecoration(
                      color: isCompleted 
                          ? Colors.green.withOpacity(0.1)
                          : AppTheme.cardBackground,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isCompleted
                            ? Colors.green
                            : AppTheme.primaryColor,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                mission.title,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: _getDifficultyColor(mission.difficulty),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                'Lvl ${mission.difficulty}',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          mission.description,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.local_fire_department,
                                  color: AppTheme.primaryColor,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  mission.enemyName,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.monetization_on,
                                  color: Colors.amber,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  '+${mission.rewardCoins}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber,
                                  ),
                                ),
                              ],
                            ),
                            if (isCompleted)
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 20.sp,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Color _getDifficultyColor(int difficulty) {
    if (difficulty <= 2) return Colors.green;
    if (difficulty <= 5) return Colors.orange;
    if (difficulty <= 10) return Colors.red;
    return Colors.purple;
  }
}
