class Alien {
  final String id;
  final String name;
  final String description;
  final String imagePath;
  final String ability;
  final double power;
  final double speed;
  final double defense;
  final double specialAbilityPower;
  final bool isUnlocked;
  final int unlockCost;

  Alien({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.ability,
    required this.power,
    required this.speed,
    required this.defense,
    required this.specialAbilityPower,
    required this.isUnlocked,
    required this.unlockCost,
  });

  factory Alien.fromJson(Map<String, dynamic> json) {
    return Alien(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imagePath: json['imagePath'] ?? '',
      ability: json['ability'] ?? '',
      power: json['power']?.toDouble() ?? 0.0,
      speed: json['speed']?.toDouble() ?? 0.0,
      defense: json['defense']?.toDouble() ?? 0.0,
      specialAbilityPower: json['specialAbilityPower']?.toDouble() ?? 0.0,
      isUnlocked: json['isUnlocked'] ?? false,
      unlockCost: json['unlockCost'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imagePath': imagePath,
      'ability': ability,
      'power': power,
      'speed': speed,
      'defense': defense,
      'specialAbilityPower': specialAbilityPower,
      'isUnlocked': isUnlocked,
      'unlockCost': unlockCost,
    };
  }
}
