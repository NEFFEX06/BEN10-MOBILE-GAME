import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'providers/game_provider.dart';
import 'providers/alien_provider.dart';
import 'providers/mission_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/game_screen.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Ben10MobileGame());
}

class Ben10MobileGame extends StatelessWidget {
  const Ben10MobileGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => GameProvider()),
            ChangeNotifierProvider(create: (_) => AlienProvider()),
            ChangeNotifierProvider(create: (_) => MissionProvider()),
          ],
          child: MaterialApp(
            title: 'Ben 10: Alien Force',
            theme: AppTheme.darkTheme,
            home: child,
            routes: {
              '/home': (context) => const HomeScreen(),
              '/game': (context) => const GameScreen(),
            },
          ),
        );
      },
      child: const SplashScreen(),
    );
  }
}
