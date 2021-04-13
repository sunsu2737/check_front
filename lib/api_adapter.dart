import 'dart:convert';

class Student {
  String name;
  String phone;

  Student({
    this.name,
    this.phone,
  });
  factory Student.fromJson(Map<String, dynamic> parsedJson) {
    return Student(
      name: parsedJson['name'],
      phone: parsedJson['phone'],
    );
  }
}

String parseJson(String responseBody) {
  final parsed = json.decode(responseBody);
  Student student = new Student.fromJson(parsed);
  return student.name;
}
