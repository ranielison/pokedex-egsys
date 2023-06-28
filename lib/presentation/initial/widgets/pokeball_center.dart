import 'package:flutter/material.dart';
import 'package:pokedex_egsys/core/routes/constants_routes.dart';

class PokeballCenter extends StatelessWidget {
  const PokeballCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 40,
          color: Colors.black,
        ),
        const CircleAvatar(
          radius: 60,
          backgroundColor: Colors.black,
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, HOME_ROUTE),
          child: const CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
