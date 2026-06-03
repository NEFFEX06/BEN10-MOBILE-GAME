import 'package:flutter/material.dart';
import '../models/mission_model.dart';

class MissionProvider extends ChangeNotifier {
  List<Mission> _missions = [
    Mission(
      id: 'mission_1',
      title: 'Four Arms Challenge',
      description: 'Use Four Arms to defeat the Metal Golem',
      storyText: 'A mysterious metal creature is destroying the city! Only Four Arms\' strength can stop it.',
      requiredAlienId: 'four_arms',
      rewardCoins: 500,
      difficulty: 1,
      isCompleted: false,
      enemyName: 'Metal Golem',
      enemyHealth: 200,
      enemyDamage: 15,
      canSkipStory: true,
    ),
    Mission(
      id: 'mission_2',
      title: 'Heatblast Inferno',
      description: 'Use Heatblast to melt the ice fortress',
      storyText: 'An ice fortress has frozen the city! Heatblast\'s fire is the only way to free it.',
      requiredAlienId: 'heatblast',
      rewardCoins: 600,
      difficulty: 2,
      isCompleted: false,
      enemyName: 'Frost Giant',
      enemyHealth: 250,
      enemyDamage: 20,
      canSkipStory: true,
    ),
    Mission(
      id: 'mission_3',
      title: 'Speed Race',
      description: 'Use XLR8 to chase the sonic villain',
      storyText: 'A speedster villain is stealing from the city! Only XLR8 can catch them.',
      requiredAlienId: 'xlr8',
      rewardCoins: 550,
      difficulty: 2,
      isCompleted: false,
      enemyName: 'Sonic Villain',
      enemyHealth: 180,
      enemyDamage: 25,
      canSkipStory: true,
    ),
    Mission(
      id: 'mission_4',
      title: 'Nature\s Wrath',
      description: 'Use Wildvine to control the mutant plants',
      storyText: 'Genetically modified plants are taking over! Wildvine must restore balance.',
      requiredAlienId: 'wildvine',
      rewardCoins: 700,
      difficulty: 3,
      isCompleted: false,
      enemyName: 'Plant Monster',
      enemyHealth: 300,
      enemyDamage: 18,
      canSkipStory: true,
    ),
    Mission(
      id: 'mission_5',
      title: 'Tech Genius Required',
      description: 'Use Grey Matter to hack the AI defense system',
      storyText: 'A rogue AI is controlling all tech devices! Only Grey Matter\'s brain can stop it.',
      requiredAlienId: 'grey_matter',
      rewardCoins: 800,
      difficulty: 3,
      isCompleted: false,
      enemyName: 'Rogue AI',
      enemyHealth: 220,
      enemyDamage: 22,
      canSkipStory: true,
    ),
    Mission(
      id: 'mission_6',
      title: 'Upgrade Protocol',
      description: 'Use Upgrade to merge with alien technology',
      storyText: 'An alien machine is terrorizing the city! Upgrade must merge with it to control it.',
      requiredAlienId: 'upgrade',
      rewardCoins: 850,
      difficulty: 4,
      isCompleted: false,
      enemyName: 'Alien Machine',
      enemyHealth: 350,
      enemyDamage: 28,
      canSkipStory: true,
    ),
    Mission(
      id: 'mission_7',
      title: 'Ghostly Encounter',
      description: 'Use Ghostfreak to phase through obstacles',
      storyText: 'A spectral entity is haunting the city! Ghostfreak must phase through its defenses.',
      requiredAlienId: 'ghostfreak',
      rewardCoins: 900,
      difficulty: 4,
      isCompleted: false,
      enemyName: 'Spectral Entity',
      enemyHealth: 280,
      enemyDamage: 20,
      canSkipStory: true,
    ),
    Mission(
      id: 'mission_8',
      title: 'Diamond Defense',
      description: 'Use Diamondhead to protect the city',
      storyText: 'A powerful asteroid is heading towards Earth! Diamondhead\'s hardness is our only hope.',
      requiredAlienId: 'diamond_head',
      rewardCoins: 1000,
      difficulty: 5,
      isCompleted: false,
      enemyName: 'Asteroid Creature',
      enemyHealth: 400,
      enemyDamage: 30,
      canSkipStory: true,
    ),
    Mission(
      id: 'mission_final',
      title: 'The Ultimatrix',
      description: 'Find the legendary Ultimatrix',
      storyText: 'All aliens converge to find the legendary Ultimatrix hidden in an ancient temple.',
      requiredAlienId: '',
      rewardCoins: 5000,
      difficulty: 10,
      isCompleted: false,
      enemyName: 'Temple Guardian',
      enemyHealth: 500,
      enemyDamage: 35,
      canSkipStory: false,
    ),
    Mission(
      id: 'mission_thanos',
      title: 'Battle with Thanos',
      description: 'The Ultimate Battle for the Universe',
      storyText: 'Thanos has arrived! With the Ultimatrix, Ben 10 must face his greatest challenge yet.',
      requiredAlienId: '',
      rewardCoins: 10000,
      difficulty: 20,
      isCompleted: false,
      enemyName: 'Thanos',
      enemyHealth: 1000,
      enemyDamage: 50,
      canSkipStory: false,
    ),
  ];

  Mission? _currentMission;

  List<Mission> get missions => _missions;
  Mission? get currentMission => _currentMission;

  void setCurrentMission(Mission mission) {
    _currentMission = mission;
    notifyListeners();
  }

  void completeMission(String missionId) {
    final index = _missions.indexWhere((m) => m.id == missionId);
    if (index != -1) {
      _missions[index] = Mission(
        id: _missions[index].id,
        title: _missions[index].title,
        description: _missions[index].description,
        storyText: _missions[index].storyText,
        requiredAlienId: _missions[index].requiredAlienId,
        rewardCoins: _missions[index].rewardCoins,
        difficulty: _missions[index].difficulty,
        isCompleted: true,
        enemyName: _missions[index].enemyName,
        enemyHealth: _missions[index].enemyHealth,
        enemyDamage: _missions[index].enemyDamage,
        canSkipStory: _missions[index].canSkipStory,
      );
      notifyListeners();
    }
  }

  List<Mission> getCompletedMissions() {
    return _missions.where((mission) => mission.isCompleted).toList();
  }

  List<Mission> getAvailableMissions() {
    return _missions.where((mission) => !mission.isCompleted).toList();
  }
}
