import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:musait/repos/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        UserCredential userCredential =
            await authRepository.signUpWithEmailAndPassword(
          event.email,
          event.password,
        );
        await authRepository.updateUserName(event.name);
        User? updatedUser = await authRepository.getCurrentUser();
        emit(AuthSucess(updatedUser!));
      } catch (e) {
        if (e is FirebaseAuthException) {
          print('Firebase Auth Error Code: ${e.code}');
          print('Firebase Auth Error Message: ${e.message}');
        }
        emit(
          AuthFailure(
            e.toString(),
          ),
        );
        print(e.toString());
      }
    });
    on<LogInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        UserCredential userCredential = await authRepository
            .logInWithEmailAndPassword(event.email, event.password);
        User? updatedUser = await authRepository.getCurrentUser();
        emit(AuthSucess(updatedUser!));
      } catch (e) {
        if (e is FirebaseAuthException) {
          print('Firebase Auth Error Code: ${e.code}');
          print('Firebase Auth Error Message: ${e.message}');
        }
        emit(
          AuthFailure(
            e.toString(),
          ),
        );
        print(e.toString());
      }
    });
  }
}
