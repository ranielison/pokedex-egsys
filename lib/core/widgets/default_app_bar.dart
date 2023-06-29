import 'package:flutter/material.dart';
import 'package:pokedex_egsys/core/theme/app_colors.dart';
import 'package:pokedex_egsys/core/theme/text_syles.dart';

class DefaultAppBar extends StatelessWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? bottom;

  const DefaultAppBar({
    Key? key,
    this.title,
    this.actions,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: AppColors.grey3),
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: title != null
                  ? Text(
                      title!,
                      style: TextStyles.h2Style.copyWith(
                        color: AppColors.grey3,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : const SizedBox(),
            ),
            actions != null
                ? Row(
                    children: actions!,
                  )
                : IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.transparent,
                    ),
                    onPressed: () {},
                  ),
          ],
        ),
        if (bottom != null) bottom!,
      ],
    );
  }
}
