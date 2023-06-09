import 'package:aliftech_test/presentation/blocs/events/event_bloc.dart';
import 'package:aliftech_test/presentation/blocs/home/home_bloc.dart';
import 'package:aliftech_test/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EventBloc()
            ..add(FilterByDateEvent(
              dateTime: DateTime.now().toIso8601String(),
            )),
        ),
        BlocProvider(create: (context) => HomeBloc()..add(LoadEvents())),
      ],
      child: MaterialApp(
        title: 'Aliftech Demo App',
        debugShowCheckedModeBanner: false,
        theme: _buildTheme(Brightness.light),
        home: const HomeScreen(),
      ),
    );
  }

  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
    );
  }
}
