class Trip {
  final String id;
  final String title;
  final String description;
  final DateTime? date;

  Trip({
    required this.id,
    required this.title,
    required this.description,
    this.date,
  });

  Trip copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
  }) {
    return Trip(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }
}