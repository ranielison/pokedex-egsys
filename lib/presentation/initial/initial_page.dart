import 'package:flutter/material.dart';
import 'package:pokedex_egsys/presentation/initial/widgets/pokeball_center.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.5,
                    color: Colors.red,
                    alignment: Alignment.center,
                    child: const Text(
                      'Pokedex\n By egSYS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: 'Pokemon',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.5,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          const PokeballCenter(),
        ],
      ),
    );
  }
}
