class Topic {
  String? title;
  String? description;
  String? imageUrl;
  String? id;

  Topic({this.title, this.description, this.imageUrl, this.id});

  static List<Topic> topics() {
    return <Topic>[
      Topic(
          title: "Flutter",
          description:
              "Flutter is a UI toolkit for building fast, beautiful, natively compiled applications for mobile, web, and desktop with one programing language and single codebase.",
          imageUrl: "https://flutter.dev/images/flutter-logo-sharing.png",
          id: "1"),
      Topic(
          title: "Dart",
          description:
              "Dart is a client-optimized language for fast apps on any platform. It is developed by Google and is used to build mobile, desktop, backend and web applications.",
          imageUrl: "https://dart.dev/assets/shared/dart/icon/64.png",
          id: "2"),
      Topic(
          title: "Firebase",
          description:
              "Firebase is a platform developed by Google for creating mobile and web applications. It was originally an independent company founded in 2011. In 2014, Google acquired the platform and it is now their flagship offering for app development.",
          imageUrl:
              "https://firebase.google.com/images/brand-guidelines/logo-built_white.png",
          id: "3"),
    ];
  }
}
