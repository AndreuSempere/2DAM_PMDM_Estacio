class CharacterModel {
  final String name;
  final String house;
  final String image;
  final String species;
  final String edad;

  CharacterModel({required this.name, required this.house, required this.image, required this.species, required this.edad});

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      name: json['name'],
      house: json['house'] ?? 'Unknown',
      species: json['species'] ?? 'Unknown',
      image: json['image'],
      edad: json['dateOfBirth'] ?? 'Unknown',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'house': house,
      'image': image,
      'species': species,
      'dateOfBirth': edad,
    };
  }
}