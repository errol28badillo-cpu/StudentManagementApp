# Student Manager

This Flutter project allows users to manage student records, including saving, displaying, editing, and deleting student information.

## Features

- Add new student records
- Edit existing student records
- Delete student records
- View detailed information about each student
- Display a list of all students

## Project Structure

```
student_manager
├── lib
│   ├── main.dart                     # Entry point of the application
│   ├── models
│   │   └── student.dart              # Defines the Student model
│   ├── screens
│   │   ├── home_screen.dart          # Displays the list of students
│   │   ├── add_edit_student_screen.dart # Form for adding/editing students
│   │   └── student_detail_screen.dart # Displays detailed student information
│   ├── widgets
│   │   ├── student_list.dart         # Presents a scrollable list of students
│   │   └── student_form.dart         # Reusable form for student information
│   └── services
│       └── student_service.dart      # Handles data operations for students
├── pubspec.yaml                      # Project configuration file
└── README.md                        # Project documentation
```

## Setup Instructions

1. Clone the repository:
   ```
   git clone <repository-url>
   ```

2. Navigate to the project directory:
   ```
   cd student_manager
   ```

3. Install the dependencies:
   ```
   flutter pub get
   ```

4. Run the application:
   ```
   flutter run
   ```

## Usage Guidelines

- Upon launching the app, you will see the home screen displaying the list of students.
- Use the button to add a new student or tap on an existing student to edit or view details.
- The app allows you to manage student records efficiently with a user-friendly interface.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any suggestions or improvements.