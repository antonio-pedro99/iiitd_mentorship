class Mentor {
  final String name;
  final String bio;
  final int stars;
  final String photoUrl;
  final List<String>? topics;
  final String? branch;
  final String? company;
  final String? position;
  final int? batch;
  final bool? availableForVideoCall;
  final bool? availableForMeetup;
  final bool? availableForChat;

  Mentor(
      {required this.bio,
      required this.name,
      required this.photoUrl,
      required this.stars,
      this.topics,
      this.branch,
      this.company,
      this.position,
      this.batch,
      this.availableForVideoCall,
      this.availableForMeetup,
      this.availableForChat});

  factory Mentor.fromJson(Map<String, dynamic> json) {
    return Mentor(
        bio: json['bio'],
        name: json['name'],
        photoUrl: json['photoUrl'],
        stars: json['stars']);
  }

  static List<Mentor> fromJsonList(List<dynamic> jsonList) {
    List<Mentor> mentors = [];
    for (var json in jsonList) {
      mentors.add(Mentor.fromJson(json));
    }
    return mentors;
  }

  Map<String, dynamic> toJson() => {
        'bio': bio,
        'name': name,
        'photoUrl': photoUrl,
        'stars': stars,
      };
  static List<Mentor> getMentors() {
    final items = <Mentor>[];

    items.add(Mentor(
        bio:
            "Computer Science Student at UEM, with a passion for technology and innovation. I love to learn new things and share my knowledge with others.",
        name: "Antonio Pedro",
        photoUrl:
            "https://images.unsplash.com/photo-1531384441138-2736e62e0919?auto=format&fit=crop&q=80&w=1587&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        stars: 5));

    items.add(Mentor(
        bio:
            "Software Engineer at Google, my passion is to help others and share my knowledge.",
        name: "John Doe",
        photoUrl:
            "https://images.unsplash.com/photo-1531384441138-2736e62e0919?auto=format&fit=crop&q=80&w=1587&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        stars: 2));

    items.add(Mentor(
        bio:
            "A mentor with a lot of experience in the field, I love to help others and share my knowledge. I'm a Software Engineer at Google.",
        name: "Nick Fury",
        photoUrl:
            "https://images.unsplash.com/photo-1531384441138-2736e62e0919?auto=format&fit=crop&q=80&w=1587&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        stars: 2));

    items.add(Mentor(
        bio:
            "If you want to learn about the latest technologies, I'm the right person to help you. I'm a Software Engineer at Google.",
        name: "Kurt Cobain",
        photoUrl:
            "https://images.unsplash.com/photo-1531384441138-2736e62e0919?auto=format&fit=crop&q=80&w=1587&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        stars: 2));

    items.add(Mentor(
        bio:
            "I'm a Software Engineer at Google, I love to help others and share my knowledge.",
        name: "John Doe",
        photoUrl:
            "https://images.unsplash.com/photo-1531384441138-2736e62e0919?auto=format&fit=crop&q=80&w=1587&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        stars: 2));

    items.add(Mentor(
        bio:
            "I'm a Software Engineer at Google, I love to help others and share my knowledge.",
        name: "John Doe",
        photoUrl:
            "https://images.unsplash.com/photo-1531384441138-2736e62e0919?auto=format&fit=crop&q=80&w=1587&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        stars: 2));

    return items;
  }
}
