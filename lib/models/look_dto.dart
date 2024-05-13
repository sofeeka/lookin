import 'item_dto.dart';

class LookDTO {
  LookDTO({
    required this.id,
    this.name,
    required this.items,
  });

  factory LookDTO.fromJson(Map<String, Object?> json) {
    var itemsJson = json['items'] as List<dynamic>;
    List<ItemDTO> items =
        itemsJson.map((itemJson) => ItemDTO.fromJson(itemJson)).toList();

    return LookDTO(
      id: json['id']! as int,
      name: json['name'] as String?,
      items: items,
    );
  }

  LookDTO copyWith({
    int? id,
    String? name,
    List<ItemDTO>? items,
  }) {
    return LookDTO(
      id: id ?? this.id,
      name: name ?? this.name,
      items: items ?? this.items,
    );
  }

  Map<String, Object?> toJson() {
    List<Map<String, Object?>> itemsJson =
        items.map((item) => item.toJson()).toList();

    return {
      'id': id,
      'name': name,
      'items': itemsJson,
    };
  }

  final int id;
  final String? name;
  final List<ItemDTO> items;
}
