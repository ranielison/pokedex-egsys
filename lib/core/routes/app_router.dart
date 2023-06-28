import 'package:pokedex_egsys/core/routes/constants_routes.dart';
import 'package:pokedex_egsys/presentation/details/details_page.dart';
import 'package:pokedex_egsys/presentation/home/pages/home_page.dart';
import 'package:pokedex_egsys/presentation/initial/initial_page.dart';

class AppRouter {
  static final routes = {
    INITIAL_ROUTE: (context) => const InitialPage(),
    HOME_ROUTE: (context) => const HomePage(),
    DETAILS_ROUTE: (context) => const DetailsPage(),
  };
}
