import 'dart:convert';

class Category_ {
  final String name;
  final String image;
  final String? id;

  Category_({
    required this.name,
    required this.image,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'id': id,
    };
  }

  factory Category_.fromMap(Map<String, dynamic> map) {
    return Category_(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Category_.fromJson(String source) =>
      Category_.fromMap(json.decode(source));
}
