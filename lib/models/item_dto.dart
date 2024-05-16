class ItemDTO {
  ItemDTO({
    required this.id,
    required this.userId,
    required this.imagePath,
  });

  ItemDTO.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as int,
          userId: json['userId'] as String,
          imagePath: json['imagePath']! as String,
        );

  ItemDTO copyWith({
    int? id,
    String? userId,
    String? imagePath,
  }) {
    return ItemDTO(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'userId': userId,
      'imagePath': imagePath,
    };
  }

  final int id;
  final String userId;
  final String imagePath;
}
