class Task {
  final int? id;
  final String title;
  final String description;
  final String status;

  Task({this.id, required this.title, required this.description, required this.status});

  Task copy({int? id, String? title, String? description, String? status}) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
    };
  }

  static Task fromJson(Map<String, Object?> json) {
    return Task(
      id: json['id'] as int?,
      title: json['title'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
    );
  }
}
