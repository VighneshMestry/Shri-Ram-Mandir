// ignore_for_file: public_member_api_docs, sort_constructors_first
class Event {
  final String id;
  final String title;
  final List<String> imageUrls;
  final String description;
  final int year;
  Event({
    required this.id,
    required this.title,
    required this.imageUrls,
    required this.description,
    required this.year,
  });



  Event copyWith({
    String? id,
    String? title,
    List<String>? imageUrls,
    String? description,
    int? year,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrls: imageUrls ?? this.imageUrls,
      description: description ?? this.description,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'imageUrls': imageUrls,
      'description': description,
      'year': year,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] as String,
      title: map['title'] as String,
      imageUrls: List<String>.from((map['imageUrls'] as List<String>)),
      description: map['description'] as String,
      year: map['year'] as int,
    );
  }

  @override
  String toString() {
    return 'Event(id: $id, title: $title, imageUrls: $imageUrls, description: $description, year: $year)';
  }
}
