// models/student_model.dart
class Student {
  String? id;
  String name;
  String rollNumber;
  String department;
  String dateOfBirth;
  int studiedYear;
  String joinDate;
  String createdAt;
  String updatedAt;
  String? imageUrl;

  Student({
    this.id,
    required this.name,
    required this.rollNumber,
    required this.department,
    required this.dateOfBirth,
    required this.studiedYear,
    required this.joinDate,
    required this.createdAt,
    required this.updatedAt,
    this.imageUrl,
  });

  // Convert to Map for Firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'rollNumber': rollNumber,
      'department': department,
      'dateOfBirth': dateOfBirth,
      'studiedYear': studiedYear,
      'joinDate': joinDate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'imageUrl': imageUrl,
    };
  }

  // Create Student from Firebase data
  factory Student.fromJson(String id, Map<dynamic, dynamic> json) {
    return Student(
      id: id,
      name: json['name'] ?? '',
      rollNumber: json['rollNumber'] ?? '',
      department: json['department'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      studiedYear: json['studiedYear'] ?? 0,
      joinDate: json['joinDate'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      imageUrl: json['imageUrl'],
    );
  }

  // Copy with method for updates
  Student copyWith({
    String? id,
    String? name,
    String? rollNumber,
    String? department,
    String? dateOfBirth,
    int? studiedYear,
    String? joinDate,
    String? createdAt,
    String? updatedAt,
    String? imageUrl,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      rollNumber: rollNumber ?? this.rollNumber,
      department: department ?? this.department,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      studiedYear: studiedYear ?? this.studiedYear,
      joinDate: joinDate ?? this.joinDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}