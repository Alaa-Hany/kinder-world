class Child {
  final String id;
  final String parentId;
  final String name;
  final DateTime createdAt;

  Child({
    required this.id,
    required this.parentId,
    required this.name,
    required this.createdAt,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'].toString(),
      parentId: json['parent_id'].toString(),
      name: json['name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_id': parentId,
      'name': name,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class ChildResponse {
  final Child child;

  ChildResponse({required this.child});

  factory ChildResponse.fromJson(Map<String, dynamic> json) {
    return ChildResponse(
      child: Child.fromJson(json['child'] as Map<String, dynamic>),
    );
  }
}

class ChildrenResponse {
  final List<Child> children;

  ChildrenResponse({required this.children});

  factory ChildrenResponse.fromJson(Map<String, dynamic> json) {
    final items = json['children'] as List<dynamic>? ?? [];
    return ChildrenResponse(
      children: items
          .map((item) => Child.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ChildLoginResponse {
  final bool success;
  final String childId;

  ChildLoginResponse({
    required this.success,
    required this.childId,
  });

  factory ChildLoginResponse.fromJson(Map<String, dynamic> json) {
    return ChildLoginResponse(
      success: json['success'] as bool? ?? false,
      childId: json['child_id'].toString(),
    );
  }
}
