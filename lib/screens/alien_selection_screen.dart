import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/alien_provider.dart';
import '../utils/theme.dart';

class AlienSelectionScreen extends StatefulWidget {
  const AlienSelectionScreen({Key? key}) : super(key: key);

  @override
  State<AlienSelectionScreen> createState() => _AlienSelectionScreenState();
}

class _AlienSelectionScreenState extends State<AlienSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Alien'),
        elevation: 0,
      ),
      body: Consumer<AlienProvider>(
        builder: (context, alienProvider, _) {
          final unlockedAliens = alienProvider.getUnlockedAliens();
          
          return GridView.builder(
            padding: EdgeInsets.all(15.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.w,
              mainAxisSpacing: 15.h,
              childAspectRatio: 0.8,
            ),
            itemCount: unlockedAliens.length,
            itemBuilder: (context, index) {
              final alien = unlockedAliens[index];
              
              return InkWell(
                onTap: () {
                  alienProvider.setCurrentAlien(alien);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${alien.name} Selected!'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.cardBackground,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppTheme.primaryColor,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Character Name
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Text(
                          alien.name,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // Placeholder for Character Image
                      Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppTheme.primaryColor,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.person,
                            size: 50.sp,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                      // Stats
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Column(
                          children: [
                            _buildStatRow('Power', alien.power.toInt()),
                            _buildStatRow('Speed', alien.speed.toInt()),
                            _buildStatRow('Defense', alien.defense.toInt()),
                          ],
                        ),
                      ),
                      // Select Button
                      Padding(
                        padding: EdgeInsets.all(8.w),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              alienProvider.setCurrentAlien(alien);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              backgroundColor: AppTheme.primaryColor,
                            ),
                            child: Text(
                              'Select',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildStatRow(String label, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: AppTheme.textSecondary,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            '$value',
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
