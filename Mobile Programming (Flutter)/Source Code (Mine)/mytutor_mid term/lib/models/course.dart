class Course {
  String? courseId;
  String? courseName;
  String? courseDesc;
  String? coursePrice;
  String? tutorId;
  String? courseSession;
  String? courseRating;

  Course(this.courseId,
      {this.courseName,
      this.courseDesc,
      this.coursePrice,
      this.tutorId,
      this.courseSession,
      this.courseRating});

  Course.fromJson(Map<String, dynamic> json) {
    courseId = json["subject_id"];
    courseName = json["subject_name"];
    courseDesc = json['subject_description'];
    coursePrice = json['subject_price'];
    tutorId = json['tutor_id'];
    courseSession = json['subject_sessions'];
    courseRating = json['subject_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject_id'] = courseId;
    data['subject_name'] = courseName;
    data['subject_description'] = courseDesc;
    data['subject_price'] = coursePrice;
    data['tutor_id'] = tutorId;
    data['subject_sessions'] = courseSession;
    data['subject_rating'] = courseRating;
    return data;
  }
}