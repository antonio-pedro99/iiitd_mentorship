class DBUser {
  String? college;
  String? yearOfGraduation;
  bool? adminApproval;
  String? yearOfJoining;
  String? branch;
  String? uid;
  String? photoUrl;
  String? name;
  String? course;
  String? company;
  bool? isMentor;
  String? email;
  bool? isProfileComplete;
  List<String>? topics; // Added topics property

  DBUser({
    this.college,
    this.yearOfGraduation,
    this.adminApproval,
    this.yearOfJoining,
    this.branch,
    this.uid,
    this.photoUrl,
    this.name,
    this.course,
    this.company,
    this.isMentor,
    this.email,
    this.isProfileComplete,
    this.topics, // Added topics parameter in the constructor
  });

  DBUser.fromJson(Map<String, dynamic> json) {
    college = json['college'];
    yearOfGraduation = json['yearOfGraduation'];
    adminApproval = json['adminApproval'];
    yearOfJoining = json['yearOfJoining'];
    branch = json['branch'];
    uid = json['uid'];
    photoUrl = json['photoUrl'];
    name = json['name'];
    course = json['course'];
    company = json['company'];
    isMentor = json['isMentor'];
    email = json['email'];
    isProfileComplete = json['isProfileComplete'];
    topics = json['topics'] != null
        ? List<String>.from(json['topics'])
        : null; // Added topics assignment
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['college'] = college;
    data['yearOfGraduation'] = yearOfGraduation;
    data['adminApproval'] = adminApproval;
    data['yearOfJoining'] = yearOfJoining;
    data['branch'] = branch;
    data['uid'] = uid;
    data['photoUrl'] = photoUrl;
    data['name'] = name;
    data['course'] = course;
    data['company'] = company;
    data['isMentor'] = isMentor;
    data['email'] = email;
    data['isProfileComplete'] = isProfileComplete;
    data['topics'] = topics; // Added topics assignment
    return data;
  }
}
