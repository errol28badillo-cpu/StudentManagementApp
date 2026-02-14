import 'package:flutter/material.dart';
import 'student.dart';
import 'student_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Errol Student Grade'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final StudentManager _studentManager = StudentManager();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  List<Student> _displayedStudents = [];

  @override
  void initState() {
    super.initState();
    _displayedStudents = _studentManager.students;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _displayedStudents = _studentManager.searchStudents(_searchController.text);
    });
  }

  void _addOrEditStudent({Student? student, int? index}) {
    if (student != null) {
      _nameController.text = student.name;
      _idController.text = student.id;
    } else {
      _nameController.clear();
      _idController.clear();
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(student == null ? 'Add Student' : 'Edit Student'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: 'ID'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (student == null) {
                  _studentManager.addStudent(Student(
                    name: _nameController.text,
                    id: _idController.text,
                  ));
                } else if (index != null) {
                  _studentManager.editStudent(index, Student(
                    name: _nameController.text,
                    id: _idController.text,
                  ));
                }
                _displayedStudents = _studentManager.searchStudents(_searchController.text);
              });
              Navigator.pop(context);
            },
            child: Text(student == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  void _deleteStudent(int index) {
    setState(() {
      _studentManager.deleteStudent(index);
      _displayedStudents = _studentManager.searchStudents(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _displayedStudents.length,
              itemBuilder: (context, index) {
                final student = _displayedStudents[index];
                return ListTile(
                  title: Text(student.name),
                  subtitle: Text('ID: ${student.id}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _addOrEditStudent(student: student, index: index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteStudent(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditStudent(),
        tooltip: 'Add Student',
        child: const Icon(Icons.add),
      ),
    );
  }
}
