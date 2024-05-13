import 'item_dto.dart';

class LookDTO {
  LookDTO({
    required this.id,
    required this.userId,
    this.name,
    required this.items,
  });

  factory LookDTO.fromJson(Map<String, dynamic> json) {
    var itemsJson = json['items'] as List<dynamic>;
    List<ItemDTO> items =
        itemsJson.map((itemJson) => ItemDTO.fromJson(itemJson)).toList();

    return LookDTO(
      id: json['id']! as int,
      userId: json['userId']! as int,
      name: json['name'] as String?,
      items: items,
    );
  }

  LookDTO copyWith({
    int? id,
    int? userId,
    String? name,
    List<ItemDTO>? items,
  }) {
    return LookDTO(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, Object?>> itemsJson =
        items.map((item) => item.toJson()).toList();

    return {
      'id': id,
      'userId': userId,
      'name': name,
      'items': itemsJson,
    };
  }

  final int id;
  final int userId;
  final String? name;
  final List<ItemDTO> items;
}
