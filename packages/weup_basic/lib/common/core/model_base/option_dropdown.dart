class BaseOptionDropdown<T> {
  String? id;
  String? name;
  String? image;
  T data;

  BaseOptionDropdown({this.id, this.name, this.image, required this.data});
}
