import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_egsys/core/theme/app_colors.dart';
import 'package:pokedex_egsys/core/theme/text_syles.dart';
import 'package:pokedex_egsys/presentation/home/bloc/home_bloc.dart';

class FilterSelector extends StatelessWidget {
  final Function()? onChangeFilter;

  const FilterSelector({super.key, this.onChangeFilter});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccess) {
          return Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      onChangeFilter?.call();
                      context.read<HomeBloc>().add(
                            const SelectTypeEvent(
                              FilterType.search,
                            ),
                          );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: state.filterTypeSelected == FilterType.search
                            ? AppColors.primaryColor
                            : Colors.transparent,
                        border: Border.all(
                          width: 1,
                          color: state.filterTypeSelected == FilterType.type
                              ? AppColors.primaryColor
                              : Colors.transparent,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(4),
                          topLeft: Radius.circular(4),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Name/Id',
                        style: TextStyles.h4Style.copyWith(
                            color: state.filterTypeSelected == FilterType.search
                                ? AppColors.white
                                : AppColors.grey3),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      onChangeFilter?.call();
                      context.read<HomeBloc>().add(
                            const SelectTypeEvent(
                              FilterType.type,
                            ),
                          );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: state.filterTypeSelected == FilterType.type
                            ? AppColors.primaryColor
                            : Colors.transparent,
                        border: Border.all(
                          width: 1,
                          color: state.filterTypeSelected == FilterType.search
                              ? AppColors.primaryColor
                              : Colors.transparent,
                        ),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Type',
                        style: TextStyles.h4Style.copyWith(
                          color: state.filterTypeSelected == FilterType.type
                              ? AppColors.white
                              : AppColors.grey3,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }
}
