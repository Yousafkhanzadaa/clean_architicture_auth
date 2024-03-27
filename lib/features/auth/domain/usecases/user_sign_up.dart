import 'package:bloc_goroute/core/error/failer.dart';
import 'package:bloc_goroute/core/usecase/usecase_interface.dart';
import 'package:bloc_goroute/core/common/entities/user.dart';
import 'package:bloc_goroute/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<User, UserSignUpParameters> {
  final AuthRepository authRepository;

  UserSignUp({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(UserSignUpParameters params) async {
    return await authRepository.signUpWithEmailAndPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpParameters {
  final String email;
  final String password;
  final String name;

  UserSignUpParameters({
    required this.email,
    required this.password,
    required this.name,
  });
}
