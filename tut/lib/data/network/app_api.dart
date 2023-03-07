import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tut/app/constant.dart';
import 'package:tut/data/responses/responses.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST('/customers/login')
  Future<AuthenticationResponse> login();
}