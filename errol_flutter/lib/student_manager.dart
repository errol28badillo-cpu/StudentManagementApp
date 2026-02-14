import 'student.dart';

class StudentManager {
  final List<Student> _students = [];

  List<Student> get students => List.unmodifiable(_students);

  void addStudent(Student student) {
    _students.add(student);
  }

  void editStudent(int index, Student student) {
    if (index >= 0 && index < _students.length) {
      _students[index] = student;
    }
  }

  void deleteStudent(int index) {
    if (index >= 0 && index < _students.length) {
      _students.removeAt(index);
    }
  }

  List<Student> searchStudents(String query) {
    return _students
        .where((student) =>
            student.name.toLowerCase().contains(query.toLowerCase()) ||
            student.id.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}