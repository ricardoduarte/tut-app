import 'package:tut/data/data_source/remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:tut/data/mapper/mapper.dart';
import 'package:tut/data/network/network_info.dart';
import 'package:tut/domain/model.dart';
import 'package:tut/domain/repository.dart';
import 'package:tut/data/request/request.dart';
import 'package:tut/data/network/failure.dart';

class RepositoryImpl implements Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      // call the api
      final response = await _remoteDataSource.login(loginRequest);
      if (response.status == 0) { // success
        return Right(response.toDomain());
      }
      else {
        return Left(Failure(409, response.message ?? 'An error occurred while connecting to API'));
      }
    }
    else {
      // return connection error
      return Left(Failure(501, 'Please check your internet connection'));
    }
  }
  
}