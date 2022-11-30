// Create a dart dataclass with filed: date and number_of_students

// Create a class MDMInput with fields: date and number_of_students
class MDMInput {
  // Create a final DateTime date
  final DateTime date;
  // Create a final int number_of_students
  final int numberofstudents;

  // Create a constructor for the class
  MDMInput(this.date, this.numberofstudents);
}

class MDMRouteInfo {
  final String title;
  final String class_type;

  MDMRouteInfo({required this.title, required this.class_type});

  // Create a map with key: String and value: dynamic
  Map<String, String> toMap() {
    return {
      'title': title,
      'class_type': class_type,
    };
  }

  // Create a factory method fromMap
  factory MDMRouteInfo.fromMap(Map<String, String> map) {
    return MDMRouteInfo(
      title: map['title']!,
      class_type: map['class_type']!,
    );
  }
}
