import 'package:flutter/material.dart';
import 'package:pokedex_egsys/core/routes/constants_routes.dart';
import 'package:pokedex_egsys/core/theme/text_syles.dart';

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
          child: CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white,
            child: Text(
              'Press',
              style: TextStyles.h5Style.copyWith(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
