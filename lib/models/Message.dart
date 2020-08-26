class Message {
  final String id;
  final String subject;
  final String content;
  final DateTime date;

  Message({
    this.id,
    this.subject,
    this.content,
    this.date,
  });

  factory Message.fromJson(Map<String, dynamic> message) => Message(
        id: message['_id'],
        subject: message['subject'],
        content: message['content'],
        date: message['date'],
      );
}
