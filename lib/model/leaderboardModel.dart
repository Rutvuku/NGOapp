class User {
  String id;
  String email;
  String password;
  String events;
  String favourites;
  String createdAt;
  String updatedAt;
  String noOfCertificate;
  String v;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.events,
    required this.favourites,
    required this.createdAt,
    required this.updatedAt,
    required this.noOfCertificate,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      password: json['password'],
      events: json['events'],
      favourites: json['favourites'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      noOfCertificate: json['noOfCertificate'],
      v: json['__v'],
    );
  }
}
