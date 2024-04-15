import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musait/bloc/auth/auth_bloc.dart';
import 'package:musait/widgets/home_main.dart';
import 'package:musait/widgets/input_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidden = true;
  bool isSign = true;
  bool loading = false;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSucess) {
          Navigator.of(context).pop(); // Close the dialog
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const HomeMain();
              },
            ),
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  state.error,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          Navigator.of(context).pop();
        }
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Container(
                  height: 196.h,
                  width: 335.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitFadingCircle(
                        color: Colors.blue,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Идет проверка...",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: const Color(0xff002055),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        textAlign: TextAlign.center,
                        "Пожалуйста, подождите немного...",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff707B81),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {}
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20.h,
              horizontal: 20.w,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    Center(
                      child: Container(
                        width: 250.w,
                        child: Column(
                          children: [
                            Text(
                              "Здравствуйте!",
                              style: GoogleFonts.roboto(
                                fontSize: 32,
                                color: Color(0xff2B2B2B),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              isSign
                                  ? "Для входа в свой аккаунт введите пожалуйста, свои данные!"
                                  : "Зарегистрируйтесь чтобы продолжить",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                color: Color(0xff474747),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (!isSign)
                      InputWidget(
                        controller: nameController,
                        label: "Имя",
                        text: "Введите ваше имя",
                        type: TextInputType.name,
                        obscure: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Введите пожалуйста свое имя";
                          } else if (value.length < 1) {
                            return "Имя не может быть меньше 1 символа";
                          }
                          return null;
                        },
                      ),
                    InputWidget(
                      controller: emailController,
                      label: "Логин",
                      text: "Ваш e-mail",
                      type: TextInputType.emailAddress,
                      obscure: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Введите пожалуйста свой e-mail";
                        } else if (!value.contains("@")) {
                          return "Введите правильную почту";
                        }
                        return null;
                      },
                    ),
                    InputWidget(
                      controller: passwordController,
                      icon: Icons.remove_red_eye_outlined,
                      onTap: () {
                        setState(() {
                          hidden = !hidden;
                        });
                      },
                      obscure: hidden ? true : false,
                      label: "Пароль",
                      text: "Введите пароль",
                      type: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Введите пожалуйста свой пароль";
                        } else if (value.length < 6) {
                          return "Ваш пароль должен состоять минимум из 6 символов, иметь минимум одну заглавную букву и одно специальное значение";
                        } else if (!value.contains(
                          RegExp(r'[A-Z]'),
                        )) {
                          return "Ваш пароль должен состоять минимум из 6 символов, иметь минимум одну заглавную букву и одно специальное значение";
                        } else if (!value.contains(
                          RegExp(r'[!@#\$%^&*(),.?":{}|<>]'),
                        )) {
                          return "Ваш пароль должен состоять минимум из 6 символов, иметь минимум одну заглавную букву и одно специальное значе";
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 8.h,
                        left: 180.w,
                      ),
                      child: Text(
                        "Восстановить пароль",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(
                            0xff707B81,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_form.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                isSign
                                    ? LogInRequested(
                                        emailController.text,
                                        passwordController.text,
                                      )
                                    : SignUpRequested(
                                        nameController.text,
                                        emailController.text,
                                        passwordController.text,
                                      ),
                              );
                        } else {}
                      },
                      child: Container(
                        height: 50.h,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            isSign ? "Войти" : "Создать аккаунт",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.r,
                          ),
                          color: const Color(
                            0xff006EE9,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isSign = !isSign;
                        });
                      },
                      child: Text(
                        isSign
                            ? "Еще нет аккаунта? Создайте новый!"
                            : "Уже есть аккаунт? Войдите!",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
