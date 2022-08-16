import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'service.g.dart';

@RestApi()
abstract class Service {
  factory Service(Dio dio) = _Service;
}
