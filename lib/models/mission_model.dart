class Mission {
  final String id;
  final String title;
  final String description;
  final String storyText;
  final String requiredAlienId;
  final int rewardCoins;
  final int difficulty;
  final bool isCompleted;
  final String enemyName;
  final double enemyHealth;
  final double enemyDamage;
  final bool canSkipStory;

  Mission({
    required this.id,
    required this.title,
    required this.description,
    required this.storyText,
    required this.requiredAlienId,
    required this.rewardCoins,
    required this.difficulty,
    required this.isCompleted,
    required this.enemyName,
    required this.enemyHealth,
    required this.enemyDamage,
    required this.canSkipStory,
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      storyText: json['storyText'] ?? '',
      requiredAlienId: json['requiredAlienId'] ?? '',
      rewardCoins: json['rewardCoins'] ?? 0,
      difficulty: json['difficulty'] ?? 1,
      isCompleted: json['isCompleted'] ?? false,
      enemyName: json['enemyName'] ?? '',
      enemyHealth: json['enemyHealth']?.toDouble() ?? 100.0,
      enemyDamage: json['enemyDamage']?.toDouble() ?? 10.0,
      canSkipStory: json['canSkipStory'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'storyText': storyText,
      'requiredAlienId': requiredAlienId,
      'rewardCoins': rewardCoins,
      'difficulty': difficulty,
      'isCompleted': isCompleted,
      'enemyName': enemyName,
      'enemyHealth': enemyHealth,
      'enemyDamage': enemyDamage,
      'canSkipStory': canSkipStory,
    };
  }
}
