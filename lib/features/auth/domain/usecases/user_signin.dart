import 'package:bloc_goroute/core/error/failer.dart';
import 'package:bloc_goroute/core/usecase/usecase_interface.dart';
import 'package:bloc_goroute/core/common/entities/user.dart';
import 'package:bloc_goroute/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserLogin implements UseCase<User, UserSignInParameters> {
  final AuthRepository authRepository;

  UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignInParameters params) async {
    return authRepository.signInWithEmailAndPassword(
        email: params.email, password: params.password);
  }
}

class UserSignInParameters {
  final String email;
  final String password;

  UserSignInParameters({
    required this.email,
    required this.password,
  });
}
