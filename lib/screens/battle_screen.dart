import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';
import '../models/mission_model.dart';
import '../providers/mission_provider.dart';
import '../providers/game_provider.dart';
import '../providers/alien_provider.dart';
import '../utils/theme.dart';

class BattleScreen extends StatefulWidget {
  final Mission mission;

  const BattleScreen({
    Key? key,
    required this.mission,
  }) : super(key: key);

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen>
    with SingleTickerProviderStateMixin {
  late double _playerHealth;
  late double _enemyHealth;
  late double _totalEnemyHealth;
  late AnimationController _animationController;
  String _battleLog = 'Battle Started!\n';
  bool _battleEnded = false;
  bool _playerWon = false;
  late String _selectedAlienId;

  @override
  void initState() {
    super.initState();
    _playerHealth = 200;
    _enemyHealth = widget.mission.enemyHealth;
    _totalEnemyHealth = widget.mission.enemyHealth;
    _selectedAlienId = '';

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _showAlienSelectionDialog();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showAlienSelectionDialog() {
    final aliens = context.read<AlienProvider>().getUnlockedAliens();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBackground,
        title: Text(
          'Select Your Alien',
          style: TextStyle(color: AppTheme.primaryColor),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: aliens
                .map(
                  (alien) => ListTile(
                    title: Text(
                      alien.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Power: ${alien.power.toInt()}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedAlienId = alien.id;
                      });
                      Navigator.pop(context);
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  void _playerAttack() {
    if (_battleEnded) return;

    final random = Random();
    final damage = random.nextDouble() * 50 + 20;

    setState(() {
      _enemyHealth = max(0, _enemyHealth - damage);
      _battleLog += 'You attacked for ${damage.toInt()} damage!\n';
    });

    _animationController.forward().then((_) {
      _animationController.reset();
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      _enemyAttack();
    });
  }

  void _enemyAttack() {
    if (_battleEnded || _enemyHealth <= 0) return;

    final random = Random();
    final damage = random.nextDouble() * 30 + 10;

    setState(() {
      _playerHealth = max(0, _playerHealth - damage);
      _battleLog += '${widget.mission.enemyName} attacked for ${damage.toInt()} damage!\n';
    });

    if (_playerHealth <= 0) {
      _endBattle(false);
    }
  }

  void _specialAttack() {
    if (_battleEnded) return;

    final random = Random();
    final damage = random.nextDouble() * 100 + 50;

    setState(() {
      _enemyHealth = max(0, _enemyHealth - damage);
      _battleLog += 'Special Attack! ${damage.toInt()} damage dealt!\n';
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      _enemyAttack();
    });
  }

  void _endBattle(bool playerWon) {
    setState(() {
      _battleEnded = true;
      _playerWon = playerWon;
    });

    if (playerWon) {
      context.read<MissionProvider>().completeMission(widget.mission.id);
      context.read<GameProvider>().addCoins(widget.mission.rewardCoins);
      context.read<GameProvider>().addScore(widget.mission.difficulty * 100);
      _battleLog += '\n🎉 Victory! You won the battle!\n';
    } else {
      _battleLog += '\n💀 Defeat! You were defeated.\n';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_enemyHealth <= 0 && !_battleEnded) {
      Future.microtask(() => _endBattle(true));
    }

    return WillPopScope(
      onWillPop: () async {
        if (_battleEnded) {
          Navigator.pop(context);
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Battle'),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15.w),
          child: Column(
            children: [
              // Enemy Section
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
                      widget.mission.enemyName,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.accentColor,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Health: ${_enemyHealth.toInt()}/${_totalEnemyHealth.toInt()}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.r),
                      child: LinearProgressIndicator(
                        value: _enemyHealth / _totalEnemyHealth,
                        minHeight: 15.h,
                        backgroundColor: Colors.red.withOpacity(0.3),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _enemyHealth / _totalEnemyHealth > 0.3
                              ? Colors.red
                              : Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // VS
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  'VS',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Player Section
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
                      'Ben 10',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Health: ${_playerHealth.toInt()}/200',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.r),
                      child: LinearProgressIndicator(
                        value: _playerHealth / 200,
                        minHeight: 15.h,
                        backgroundColor: Colors.green.withOpacity(0.3),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Battle Log
              Container(
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  color: AppTheme.cardBackground,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.white12,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Battle Log',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      _battleLog,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppTheme.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Action Buttons
              if (!_battleEnded) ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _playerAttack,
                    icon: const Icon(Icons.bolt),
                    label: const Text('Attack'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      backgroundColor: AppTheme.primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _specialAttack,
                    icon: const Icon(Icons.star),
                    label: const Text('Special Attack'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      backgroundColor: AppTheme.accentColor,
                    ),
                  ),
                ),
              ] else ...[
                Container(
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: _playerWon
                        ? Colors.green.withOpacity(0.2)
                        : Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: _playerWon ? Colors.green : Colors.red,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        _playerWon ? Icons.check_circle : Icons.cancel,
                        color: _playerWon ? Colors.green : Colors.red,
                        size: 48.sp,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        _playerWon ? 'Victory!' : 'Defeat!',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: _playerWon ? Colors.green : Colors.red,
                        ),
                      ),
                      if (_playerWon) ...[
                        SizedBox(height: 10.h),
                        Text(
                          '+${widget.mission.rewardCoins} Coins',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      backgroundColor: AppTheme.primaryColor,
                    ),
                    child: const Text('Back to Missions'),
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
}
