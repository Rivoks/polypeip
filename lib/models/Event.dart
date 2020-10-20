class Event {
  final String id;
  final String name;
  final String description;
  final DateTime date;

  Event({
    this.id,
    this.name,
    this.description,
    this.date,
  });

  factory Event.fromJson(Map<String, dynamic> event) => Event(
        id: event['_id'],
        name: event['name'],
        description: event['description'],
        date: DateTime.parse(event['date']),
      );
}
