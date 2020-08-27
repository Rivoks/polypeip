class Event {
  final String id;
  final String name;
  final String description;
  final String img;
  final int totalRate;
  final int nbTotalRate;
  final DateTime date;

  Event({
    this.id,
    this.name,
    this.description,
    this.img,
    this.totalRate,
    this.nbTotalRate,
    this.date,
  });

  factory Event.fromJson(Map<String, dynamic> event) => Event(
        id: event['_id'],
        name: event['name'],
        description: event['description'],
        img: event['img'],
        totalRate: event['totalRate'],
        nbTotalRate: event['nbTotalRate'],
        date: DateTime.parse(event['date']),
      );
}
