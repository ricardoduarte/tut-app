import 'package:tut/data/data_source/remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:tut/data/mapper/mapper.dart';
import 'package:tut/data/network/error_handler.dart';
import 'package:tut/data/network/network_info.dart';
import 'package:tut/domain/model/model.dart';
import 'package:tut/domain/repository/repository.dart';
import 'package:tut/data/request/request.dart';
import 'package:tut/data/network/failure.dart';

class RepositoryImpl implements Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        // call the api
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.success) { // success
          return Right(response.toDomain());
        }
        else {
          return Left(Failure(response.status ?? ApiInternalStatus.failure, response.message ?? ResponseMessage.unknown));
        }
      }
      catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
      
    }
    else {
      // return connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
  
}