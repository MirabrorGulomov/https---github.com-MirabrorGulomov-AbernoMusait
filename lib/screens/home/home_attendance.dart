import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:musait/bloc/location/location_bloc.dart';
import 'package:musait/repos/location_repository.dart';
import 'package:musait/screens/account/account_screen.dart';
import 'package:musait/screens/sick_leave/sick_leave_screen.dart';
import 'package:musait/widgets/home_attendance_widget.dart';
import 'package:musait/widgets/input_widget.dart';

class HomeAttendance extends StatefulWidget {
  const HomeAttendance({super.key});

  @override
  State<HomeAttendance> createState() => _HomeAttendanceState();
}

class _HomeAttendanceState extends State<HomeAttendance> {
  TextEditingController reasontController = TextEditingController();
  // static const LatLng _sucessP = LatLng(37.7859219, -122.4083105);
  static const LatLng _sucessP = LatLng(37.7792792, -122.4218166);

  Location _locationController = Location();
  LatLng? _currentP;

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permisionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permisionGranted = await _locationController.hasPermission();
    if (_permisionGranted == PermissionStatus.denied) {
      _permisionGranted = await _locationController.requestPermission();
      if (_permisionGranted != PermissionStatus.granted) {
        return;
      }
    }

    Geolocator.getPositionStream().listen((position) {
      if (position != null) {
        setState(() {
          _currentP = LatLng(position.latitude, position.longitude);
          print(_currentP);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeAttendanceWidget(
                text: "Вышел на работу",
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        content: Container(
                          height: 402.h,
                          width: 332.w,
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/location.png",
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                "Поделитесь своей локацией для того, чтобы мы убедились что вы на территории учреждения",
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff002055),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                height: 200.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.r),
                                  child: _currentP == null
                                      ? const Center(
                                          child: Text("Подождите..."),
                                        )
                                      : GoogleMap(
                                          initialCameraPosition: CameraPosition(
                                            target: _currentP!,
                                            zoom: 14,
                                          ),
                                          myLocationButtonEnabled:
                                              true, // Enable the my location button
                                          myLocationEnabled: true,
                                          markers: {
                                            Marker(
                                              markerId: const MarkerId(
                                                  "currentPosition"),
                                              icon: BitmapDescriptor
                                                  .defaultMarker,
                                              position: _currentP!,
                                            ),
                                          },
                                        ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_currentP != null) {
                                    double distance =
                                        Geolocator.distanceBetween(
                                      _currentP!.latitude,
                                      _currentP!.longitude,
                                      _sucessP.latitude,
                                      _sucessP.longitude,
                                    );
                                    Navigator.of(context).pop();
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          elevation: 0,
                                          content: Container(
                                            height: 240.h,
                                            width: 332.w,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  distance <= 500
                                                      ? "assets/images/success.png"
                                                      : "assets/images/failure.png",
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                distance <= 500
                                                    ? Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        "Молодец, хорошего Вам рабочего дня!",
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: const Color(
                                                              0xff002055),
                                                        ),
                                                      )
                                                    : Column(
                                                        children: [
                                                          Text(
                                                            textAlign: TextAlign
                                                                .center,
                                                            "Вы не на территории учреждения, пожалуйста, попробуйте еще раз когда прибудете на работу",
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: const Color(
                                                                  0xff002055),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10.h,
                                                          ),
                                                          Text(
                                                            textAlign: TextAlign
                                                                .center,
                                                            "Пока мы заблокируем некоторые функции на вашем аккаунте",
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: const Color(
                                                                  0xff002055),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                GestureDetector(
                                                  onTap: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  child: Container(
                                                    height: 40.h,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.r),
                                                      color: const Color(
                                                          0xff006EE9),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Понятно",
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Container(
                                  height: 40.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: const Color(0xff006EE9),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Поделиться",
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              HomeAttendanceWidget(
                text: "Выходной день",
                onTap: () {},
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeAttendanceWidget(
                text: "На больничном",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const SickLeaveScreen();
                      },
                    ),
                  );
                },
              ),
              HomeAttendanceWidget(
                text: "Есть причина",
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        content: Container(
                          height: 228.h,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                "Укажите причину отсутствия",
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff002055),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              InputWidget(
                                text: "Я не пришел/ла потому что",
                                label: "Опишите причину",
                                type: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Вы должны указать причину";
                                  }
                                  return null;
                                },
                                obscure: false,
                                controller: reasontController,
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 40.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: const Color(0xff006EE9),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Поделиться",
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 65.h,
            decoration: BoxDecoration(
              color: const Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Text(
                "Не работает локация",
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff002055),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
