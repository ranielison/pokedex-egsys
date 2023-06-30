import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_egsys/core/di/injection_container.dart';
import 'package:pokedex_egsys/core/routes/app_router.dart';
import 'package:pokedex_egsys/core/routes/constants_routes.dart';
import 'package:pokedex_egsys/core/theme/app_colors.dart';
import 'package:pokedex_egsys/presentation/details/bloc/details_bloc.dart';
import 'package:pokedex_egsys/presentation/home/bloc/home_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => sl<HomeBloc>()
            ..add(
              PrepareStateEvent(),
            ),
        ),
        BlocProvider<DetailsBloc>(create: (_) => sl<DetailsBloc>()),
      ],
      child: MaterialApp(
        title: 'Pokédex Egsys',
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
        ),
        debugShowCheckedModeBanner: false,
        routes: AppRouter.routes,
        initialRoute: INITIAL_ROUTE,
      ),
    );
  }
}
