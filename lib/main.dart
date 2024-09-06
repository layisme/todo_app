import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/src/core/style/style.dart';
import 'package:todo_app/src/data/datasources/export_datasources.dart';
import 'package:todo_app/src/data/repositories/task/task_repository_impl.dart';
import 'package:todo_app/src/domain/repositories/task/task_repository.dart';
import 'package:todo_app/src/domain/usecases/export_usecases.dart';
import 'package:todo_app/src/presentation/cubit/export_cubits.dart';
import 'package:todo_app/src/presentation/screens/home/home_screen.dart';

part 'src/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetTaskListingCubit>(
          create: (context) => GetTaskListingCubit(injector())..listings(),
        ),
        BlocProvider<CreateTaskCubit>(
          create: (context) => CreateTaskCubit(injector()),
        ),
        BlocProvider<ChangeTaskCubit>(
          create: (context) => ChangeTaskCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            useMaterial3: false,
            cupertinoOverrideTheme: CupertinoThemeData(
              primaryColor: Colors.white,
              barBackgroundColor: Style.primaryButton,
              primaryContrastingColor: Colors.white
            ),
            textTheme: TextTheme(
                headlineSmall: GoogleFonts.lato(),
                titleMedium: GoogleFonts.lato(),
                labelMedium: GoogleFonts.lato()),
            buttonTheme: ButtonThemeData(buttonColor: Style.primaryButton),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                elevation: 0,
                backgroundColor: Style.primaryButton,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                extendedTextStyle: GoogleFonts.lato(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                )),
            inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Colors.blueGrey.withOpacity(0.10),
                hintStyle: GoogleFonts.lato(
                  fontSize: 16,
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)))),
        home: const HomeScreen(),
      ),
    );
  }
}
