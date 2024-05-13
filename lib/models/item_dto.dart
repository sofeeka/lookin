class ItemDTO {
  ItemDTO({
    required this.id,
    required this.imagePath,
  });

  ItemDTO.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as int,
          imagePath: json['imagePath']! as String,
        );

  ItemDTO copyWith({
    int? id,
    String? imagePath,
  }) {
    return ItemDTO(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'imagePath': imagePath,
    };
  }

  final int id;
  final String imagePath;
}
