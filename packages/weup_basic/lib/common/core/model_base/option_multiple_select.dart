class OptionMultipleSelect<T> {
  int? id;
  late String title;
  late bool isCheck;
  T data;

  OptionMultipleSelect({
    required this.title,
    required this.data,
    this.isCheck = false,
    this.id,
  });

}
