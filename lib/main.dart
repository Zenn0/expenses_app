import 'package:expenses_app/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromRGBO(96, 125, 139, 1)
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 30, 48, 56),
);

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor:kDarkColorScheme.primary,
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
            titleTextStyle: TextStyle(
              color: kColorScheme.onPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          textTheme: ThemeData().textTheme.copyWith(
            titleLarge: GoogleFonts.lexend(
              fontSize: 20,
              fontWeight: FontWeight.w700, 
              color: Colors.black 
            )
          ),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.primaryContainer,
            elevation: 5,
            margin: EdgeInsets.all(10),
          ),
      ),
        theme: ThemeData().copyWith(
          scaffoldBackgroundColor: const Color.fromRGBO(96, 125, 139, 1),
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
            titleTextStyle: TextStyle(
              color: kColorScheme.onPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          textTheme: ThemeData().textTheme.copyWith(
            titleLarge: GoogleFonts.lexend(
              fontSize: 20,
              fontWeight: FontWeight.w700, 
              color: Colors.black 
            )
          ),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.primaryContainer,
            elevation: 5,
            margin: EdgeInsets.all(10),
          ),
        ),
        themeMode: ThemeMode.system,
        home: const Expenses()),
  );
}
