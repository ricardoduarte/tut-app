import 'package:dartz/dartz.dart';
import 'package:tut/data/network/failure.dart';
import 'package:tut/data/request/request.dart';
import 'package:tut/domain/model/model.dart';
import 'package:tut/domain/repository/repository.dart';
import 'package:tut/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) async {
    await _repository.login(LoginRequest(input.email, input.password, 'imei', 'deviceType'));
  }
  
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}
