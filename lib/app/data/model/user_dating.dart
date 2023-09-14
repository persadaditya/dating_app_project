class UserDating {
  UserDating({
      this.age, 
      this.description, 
      this.images, 
      this.likeCount, 
      this.location, 
      this.name, 
      this.tags,});

  UserDating.fromJson(dynamic json) {
    age = json['age'];
    description = json['description'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    likeCount = json['likeCount'];
    location = json['location'];
    name = json['name'];
    tags = json['tags'] != null ? json['tags'].cast<String>() : [];
  }
  int? age;
  String? description;
  List<String>? images;
  int? likeCount;
  String? location;
  String? name;
  List<String>? tags;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['age'] = age;
    map['description'] = description;
    map['images'] = images;
    map['likeCount'] = likeCount;
    map['location'] = location;
    map['name'] = name;
    map['tags'] = tags;

    return map;
  }

}