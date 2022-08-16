import 'package:json_annotation/json_annotation.dart';

part 'list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class ListResponse<T> {
  final T items;
  final int? total;

  ListResponse({required this.items, this.total});

  factory ListResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ListResponseFromJson(json, fromJsonT);
}
