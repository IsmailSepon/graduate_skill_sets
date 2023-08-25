import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/auth/repo/auth_repository.dart';
import 'package:gp/routes/app_routes.dart';
import 'auth/bloc/auth_cubit.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // runApp(const MyApp());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => GPAuthCubit(repository: RepositoryProvider.of<AuthRepository>(context)),
        child: MaterialApp.router(
         debugShowCheckedModeBanner: false,
         routerConfig: AppRoutes.router,
          ),
      ),
    );
  }
}
