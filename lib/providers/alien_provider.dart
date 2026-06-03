import 'package:flutter/material.dart';
import '../models/alien_model.dart';

class AlienProvider extends ChangeNotifier {
  List<Alien> _aliens = [
    Alien(
      id: 'four_arms',
      name: 'Four Arms',
      description: 'Superstrong alien with incredible power',
      imagePath: 'assets/aliens/four_arms.png',
      ability: 'Strength Punch',
      power: 95,
      speed: 40,
      defense: 85,
      specialAbilityPower: 150,
      isUnlocked: true,
      unlockCost: 0,
    ),
    Alien(
      id: 'heatblast',
      name: 'Heatblast',
      description: 'Fire-based alien with thermal powers',
      imagePath: 'assets/aliens/heatblast.png',
      ability: 'Pyro Bomb',
      power: 80,
      speed: 75,
      defense: 60,
      specialAbilityPower: 120,
      isUnlocked: true,
      unlockCost: 0,
    ),
    Alien(
      id: 'xlr8',
      name: 'XLR8',
      description: 'Fast alien with incredible velocity',
      imagePath: 'assets/aliens/xlr8.png',
      ability: 'Speed Burst',
      power: 65,
      speed: 100,
      defense: 50,
      specialAbilityPower: 100,
      isUnlocked: true,
      unlockCost: 0,
    ),
    Alien(
      id: 'wildvine',
      name: 'Wildvine',
      description: 'Plant-based alien with nature control',
      imagePath: 'assets/aliens/wildvine.png',
      ability: 'Vine Whip',
      power: 70,
      speed: 55,
      defense: 80,
      specialAbilityPower: 110,
      isUnlocked: false,
      unlockCost: 500,
    ),
    Alien(
      id: 'grey_matter',
      name: 'Grey Matter',
      description: 'Genius brain alien for puzzles',
      imagePath: 'assets/aliens/grey_matter.png',
      ability: 'Tech Hack',
      power: 20,
      speed: 70,
      defense: 30,
      specialAbilityPower: 80,
      isUnlocked: false,
      unlockCost: 600,
    ),
    Alien(
      id: 'upgrade',
      name: 'Upgrade',
      description: 'Tech-based transformation alien',
      imagePath: 'assets/aliens/upgrade.png',
      ability: 'Tech Merge',
      power: 75,
      speed: 60,
      defense: 70,
      specialAbilityPower: 115,
      isUnlocked: false,
      unlockCost: 700,
    ),
    Alien(
      id: 'ghostfreak',
      name: 'Ghostfreak',
      description: 'Spectral alien with intangibility',
      imagePath: 'assets/aliens/ghostfreak.png',
      ability: 'Phase Through',
      power: 60,
      speed: 85,
      defense: 40,
      specialAbilityPower: 105,
      isUnlocked: false,
      unlockCost: 800,
    ),
    Alien(
      id: 'diamond_head',
      name: 'Diamondhead',
      description: 'Crystal alien with hardness defense',
      imagePath: 'assets/aliens/diamondhead.png',
      ability: 'Crystal Barrier',
      power: 85,
      speed: 50,
      defense: 95,
      specialAbilityPower: 125,
      isUnlocked: false,
      unlockCost: 900,
    ),
  ];

  Alien? _currentAlien;

  List<Alien> get aliens => _aliens;
  Alien? get currentAlien => _currentAlien;

  void setCurrentAlien(Alien alien) {
    _currentAlien = alien;
    notifyListeners();
  }

  void unlockAlien(String alienId) {
    final index = _aliens.indexWhere((a) => a.id == alienId);
    if (index != -1) {
      _aliens[index] = Alien(
        id: _aliens[index].id,
        name: _aliens[index].name,
        description: _aliens[index].description,
        imagePath: _aliens[index].imagePath,
        ability: _aliens[index].ability,
        power: _aliens[index].power,
        speed: _aliens[index].speed,
        defense: _aliens[index].defense,
        specialAbilityPower: _aliens[index].specialAbilityPower,
        isUnlocked: true,
        unlockCost: _aliens[index].unlockCost,
      );
      notifyListeners();
    }
  }

  List<Alien> getUnlockedAliens() {
    return _aliens.where((alien) => alien.isUnlocked).toList();
  }
}
