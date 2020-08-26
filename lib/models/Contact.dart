class Contact {
  final String id;
  final String name;
  final String surname;
  final String tel;
  final String email;
  final String role;

  Contact({
    this.id,
    this.name,
    this.surname,
    this.tel,
    this.email,
    this.role,
  });

  factory Contact.fromJson(Map<String, dynamic> contact) => Contact(
        id: contact['_id'],
        name: contact['name'],
        surname: contact['surname'],
        tel: contact['tel'],
        email: contact['email'],
        role: contact['role'] ? contact['role'] : 'support',
      );
}
