final String tableProjects = 'projects';

//? column names in our database
class ProjectFields {
  static final List<String> values = [
    id,
    isCompleted,
    title,
    avatar,
    deadline,
    createdTime,
    completedTime
  ];

  static final String id = '_id'; //? by default in sql we have _ in id
  static final String isCompleted = 'isCompleted';
  static final String title = 'title';
  static final String avatar = 'avatar';
  static final String deadline = 'deadline';
  static final String createdTime = 'createdTime';
  static final String completedTime = 'completedTime';
}

class Project {
  final int? id;
  final bool isCompleted;
  final String title;
  final String avatar;
  final DateTime deadline;
  final DateTime createdTime;
  final DateTime completedTime;

  const Project({
    this.id,
    required this.isCompleted,
    required this.title,
    required this.avatar,
    required this.deadline,
    required this.createdTime,
    required this.completedTime,
  });

  Project copy({
    int? id,
    bool? isCompleted,
    String? title,
    String? avatar,
    DateTime? deadline,
    DateTime? createdTime,
    DateTime? completedTime,
  }) =>
      Project(
        id: id ?? this.id,
        isCompleted: isCompleted ?? this.isCompleted,
        title: title ?? this.title,
        avatar: title ?? this.avatar,
        deadline: deadline ?? this.deadline,
        createdTime: createdTime ?? this.createdTime,
        completedTime: completedTime ?? this.completedTime,
      );

  static Project fromJson(Map<String, Object?> json) => Project(
      id: json[ProjectFields.id] as int?,
      isCompleted: json[ProjectFields.isCompleted] == 1,
      title: json[ProjectFields.title] as String,
      avatar: json[ProjectFields.avatar] as String,
      deadline: DateTime.parse(json[ProjectFields.deadline] as String),
      createdTime: DateTime.parse(json[ProjectFields.createdTime] as String),
      completedTime:
          DateTime.parse(json[ProjectFields.completedTime] as String));

  Map<String, Object?> toJson() => {
        ProjectFields.id: id,
        ProjectFields.isCompleted: isCompleted ? 1 : 0,
        ProjectFields.title: title,
        ProjectFields.avatar: avatar,
        ProjectFields.deadline: deadline.toIso8601String(),
        ProjectFields.createdTime: createdTime
            .toIso8601String(), //? to conver a datetime object to a string we can use .toIso8601String()
        ProjectFields.completedTime: completedTime.toIso8601String()
      };
}
