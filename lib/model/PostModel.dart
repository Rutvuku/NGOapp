class PostModel {
  String id;
  String title;
  String date;
  String time;
  String creator;
  String location;
  String tagline;
  List<dynamic> participants;
  String createdAt;
  bool completed;
  int v;

  PostModel({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.creator,
    required this.location,
    required this.tagline,
    required this.participants,
    required this.createdAt,
    required this.completed,
    required this.v,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['_id'],
      title: json['title'],
      date: json['date'],
      time: json['time'],
      creator: json['creator'],
      location: json['location'],
      tagline: json['tagline'],
      participants: json['participants'],
      completed: json['completed'],
      createdAt: json['createdAt'],
      v: json['__v']

    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'date': date,
      'time': time,
      'creator': creator,
      'location': location,
      'tagline': tagline,
      'participants': participants,
      'createdAt': createdAt,
      'completed': completed,
      '__v': v,
    };
  }
}
