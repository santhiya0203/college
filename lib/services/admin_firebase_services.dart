import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import '../features/admin/createStudent/data/models/student_model.dart';


class FirebaseService {
  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Students collection reference
  CollectionReference get studentsCollection => _firestore.collection('students');

  // CREATE - Add new student to Firestore
  Future<String> createStudent(Student student) async {
    try {
      // Add student to Firestore (auto-generates document ID)
      DocumentReference docRef = await studentsCollection.add(student.toJson());

      // Return the generated document ID
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create student: $e');
    }
  }

  // READ - Get all students from Firestore
  Future<List<Student>> getAllStudents() async {
    try {
      QuerySnapshot querySnapshot = await studentsCollection.get();

      List<Student> students = querySnapshot.docs.map((doc) {
        return Student.fromJson(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();

      return students;
    } catch (e) {
      throw Exception('Failed to fetch students: $e');
    }
  }

  // READ - Get single student by ID
  Future<Student?> getStudentById(String id) async {
    try {
      DocumentSnapshot doc = await studentsCollection.doc(id).get();

      if (!doc.exists) {
        return null;
      }

      return Student.fromJson(doc.id, doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to fetch student: $e');
    }
  }

  // READ - Stream of students (Real-time updates)
  Stream<List<Student>> getStudentsStream() {
    return studentsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Student.fromJson(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // UPDATE - Update student in Firestore
  Future<void> updateStudent(Student student) async {
    try {
      if (student.id == null) {
        throw Exception('Student ID is required for update');
      }

      student.updatedAt = DateTime.now().toIso8601String();

      await studentsCollection.doc(student.id).update(student.toJson());
    } catch (e) {
      throw Exception('Failed to update student: $e');
    }
  }

  // DELETE - Delete student from Firestore
  Future<void> deleteStudent(String id) async {
    try {
      // Get student data to check for image
      Student? student = await getStudentById(id);

      // Delete image from storage if exists
      if (student?.imageUrl != null && student!.imageUrl!.isNotEmpty) {
        await deleteImage(student.imageUrl!);
      }

      // Delete student document
      await studentsCollection.doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete student: $e');
    }
  }

  // UPLOAD IMAGE - Upload student image to Firebase Storage
  Future<String> uploadImage(File imageFile, String studentId) async {
    try {
      String fileName = 'students/$studentId/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageRef = _storage.ref().child(fileName);

      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  // DELETE IMAGE - Delete image from Firebase Storage
  Future<void> deleteImage(String imageUrl) async {
    try {
      Reference storageRef = _storage.refFromURL(imageUrl);
      await storageRef.delete();
    } catch (e) {
      print('Failed to delete image: $e');
    }
  }

  // SEARCH - Search students by name (Firestore query)
  Future<List<Student>> searchStudentsByName(String query) async {
    try {
      // Firestore doesn't support case-insensitive search directly
      // So we fetch all and filter locally
      List<Student> allStudents = await getAllStudents();
      return allStudents
          .where((student) =>
          student.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      throw Exception('Failed to search students: $e');
    }
  }

  // FILTER - Get students by department (Firestore where query)
  Future<List<Student>> getStudentsByDepartment(String department) async {
    try {
      QuerySnapshot querySnapshot = await studentsCollection
          .where('department', isEqualTo: department)
          .get();

      List<Student> students = querySnapshot.docs.map((doc) {
        return Student.fromJson(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();

      return students;
    } catch (e) {
      throw Exception('Failed to filter students: $e');
    }
  }

  // FILTER - Get students by studied year
  Future<List<Student>> getStudentsByYear(int year) async {
    try {
      QuerySnapshot querySnapshot = await studentsCollection
          .where('studiedYear', isEqualTo: year)
          .get();

      List<Student> students = querySnapshot.docs.map((doc) {
        return Student.fromJson(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();

      return students;
    } catch (e) {
      throw Exception('Failed to filter students: $e');
    }
  }

  // ORDER BY - Get students ordered by name
  Future<List<Student>> getStudentsOrderedByName() async {
    try {
      QuerySnapshot querySnapshot = await studentsCollection
          .orderBy('name', descending: false)
          .get();

      List<Student> students = querySnapshot.docs.map((doc) {
        return Student.fromJson(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();

      return students;
    } catch (e) {
      throw Exception('Failed to fetch ordered students: $e');
    }
  }

  // PAGINATION - Get students with limit
  Future<List<Student>> getStudentsWithLimit(int limit) async {
    try {
      QuerySnapshot querySnapshot = await studentsCollection
          .limit(limit)
          .get();

      List<Student> students = querySnapshot.docs.map((doc) {
        return Student.fromJson(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();

      return students;
    } catch (e) {
      throw Exception('Failed to fetch students: $e');
    }
  }

  // BATCH DELETE - Delete multiple students
  Future<void> deleteMultipleStudents(List<String> studentIds) async {
    try {
      WriteBatch batch = _firestore.batch();

      for (String id in studentIds) {
        batch.delete(studentsCollection.doc(id));
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to delete students: $e');
    }
  }

  // COUNT - Get total number of students
  Future<int> getStudentsCount() async {
    try {
      AggregateQuerySnapshot snapshot = await studentsCollection.count().get();
      return snapshot.count ?? 0;
    } catch (e) {
      throw Exception('Failed to count students: $e');
    }
  }
}