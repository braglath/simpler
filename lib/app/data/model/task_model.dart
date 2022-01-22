final String tableTask = 'tasks';

//? column names in our database
class TaskFields {
  static final List<String> values = [
    id,
    projectId,
    projectTitle,
    task,
    status
  ];

  static final String id = '_id'; //? by default in sql we have _ in id
  static final String projectId = 'projectId';
  static final String projectTitle = 'projectTitle';
  static final String task = 'task';
  static final String status = 'status';
}

class Task {
  final int? id;
  final int projectId;
  final String projectTitle;
  final String task;
  final String status;

  const Task({
    this.id,
    required this.projectId,
    required this.projectTitle,
    required this.task,
    required this.status,
  });

  Task copy({
    int? id,
    int? projectId,
    String? projectTitle,
    String? task,
    String? status,
  }) =>
      Task(
        id: id ?? this.id,
        projectId: projectId ?? this.projectId,
        projectTitle: projectTitle ?? this.projectTitle,
        task: task ?? this.task,
        status: status ?? this.status,
      );

  static Task fromJson(Map<String, Object?> json) => Task(
      id: json[TaskFields.id] as int?,
      projectId: json[TaskFields.projectId] as int,
      projectTitle: json[TaskFields.projectTitle] as String,
      task: json[TaskFields.task] as String,
      status: json[TaskFields.status] as String);

  Map<String, Object?> toJson() => {
        TaskFields.id: id,
        TaskFields.projectId: projectId,
        TaskFields.projectTitle: projectTitle,
        TaskFields.task: task,
        TaskFields.status: status
      };
}
