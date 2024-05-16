class ItemDTO {
  ItemDTO({
    required this.id,
    required this.sectionId,
    required this.userId,
    required this.imagePath,
  });

  ItemDTO.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as int,
          sectionId: json['sectionId'] as int,
          userId: json['userId'] as String,
          imagePath: json['imagePath']! as String,
        );

  ItemDTO copyWith({
    int? id,
    int? sectionId,
    String? userId,
    String? imagePath,
  }) {
    return ItemDTO(
      id: id ?? this.id,
      sectionId: sectionId ?? this.sectionId,
      userId: userId ?? this.userId,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'sectionId': sectionId,
      'userId': userId,
      'imagePath': imagePath,
    };
  }

  final int id;
  final int sectionId;
  final String userId;
  final String imagePath;
}
