enum TaskStatus {
  all(value: null, display: 'All'),
  complete(value: true, display: 'Complete'),
  inComplete(value: false, display: 'Incomplete');

  final bool? value;
  final String? display;
  const TaskStatus({this.value, this.display});
}
