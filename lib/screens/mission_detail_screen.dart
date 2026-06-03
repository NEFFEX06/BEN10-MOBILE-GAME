import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/mission_model.dart';
import '../providers/mission_provider.dart';
import '../providers/game_provider.dart';
import '../utils/theme.dart';
import 'battle_screen.dart';

class MissionDetailScreen extends StatefulWidget {
  final Mission mission;

  const MissionDetailScreen({
    Key? key,
    required this.mission,
  }) : super(key: key);

  @override
  State<MissionDetailScreen> createState() => _MissionDetailScreenState();
}

class _MissionDetailScreenState extends State<MissionDetailScreen> {
  bool _showStory = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.mission.title),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mission Info Card
              Container(
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  color: AppTheme.cardBackground,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: AppTheme.primaryColor,
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mission Info',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    _buildInfoRow('Enemy:', widget.mission.enemyName),
                    SizedBox(height: 10.h),
                    _buildInfoRow('Enemy Health:', '${widget.mission.enemyHealth.toInt()}'),
                    SizedBox(height: 10.h),
                    _buildInfoRow('Enemy Damage:', '${widget.mission.enemyDamage.toInt()}'),
                    SizedBox(height: 10.h),
                    _buildInfoRow('Reward:', '+${widget.mission.rewardCoins} Coins'),
                    SizedBox(height: 10.h),
                    _buildInfoRow('Difficulty:', 'Level ${widget.mission.difficulty}'),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Story Section
              if (_showStory && widget.mission.canSkipStory)
                Container(
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1a4d6d),
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
                        'Story',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        widget.mission.storyText,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppTheme.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                _showStory = false;
                              });
                            },
                            icon: const Icon(Icons.skip_next),
                            label: const Text('Skip Story'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                _showStory = false;
                              });
                            },
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Continue'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              if (!_showStory) ...[
                SizedBox(height: 20.h),
                // Battle Start Section
                Container(
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: AppTheme.cardBackground,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppTheme.accentColor,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ready for Battle?',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.accentColor,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Transform to an alien and face ${widget.mission.enemyName}!',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.read<MissionProvider>().setCurrentMission(widget.mission);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BattleScreen(
                                  mission: widget.mission,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.swords),
                          label: const Text('Start Battle'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            backgroundColor: AppTheme.accentColor,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppTheme.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
      ],
    );
  }
}
