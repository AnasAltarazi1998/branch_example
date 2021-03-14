class login_model {
  int id;
  String name;
  String email;
  String password;
  String university;
  String img;
  String communityName;
  int studyYear;
  String startYear;
  String age;

  login_model(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.university,
      this.img,
      this.communityName,
      this.studyYear,
      this.startYear,
      this.age});

  login_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    university = json['university'];
    img = json['img'];
    communityName = json['community_name'];
    studyYear = json['study_year'];
    startYear = json['start_year'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['university'] = this.university;
    data['img'] = this.img;
    data['community_name'] = this.communityName;
    data['study_year'] = this.studyYear;
    data['start_year'] = this.startYear;
    data['age'] = this.age;
    return data;
  }
}
