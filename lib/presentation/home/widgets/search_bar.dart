import 'package:flutter/material.dart';
import 'package:pokedex_egsys/core/theme/app_colors.dart';
import 'package:pokedex_egsys/core/utils/debouncer.dart';

class SearchInput extends StatefulWidget {
  final String hint;
  final Function(String value)? onChange;
  final TextEditingController? controller;
  final Function? onTap;
  final bool? isSearching;
  final Function()? onClean;

  const SearchInput({
    super.key,
    required this.hint,
    this.onChange,
    this.controller,
    this.onTap,
    this.isSearching = false,
    this.onClean,
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput>
    with TickerProviderStateMixin {
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 150),
      child: SizedBox(
        height: 50,
        child: TextFormField(
          onTap: widget.onTap as void Function()?,
          controller: widget.controller,
          onChanged: (value) {
            _debouncer.run(
              () => setState(() {
                widget.onChange?.call(value);
              }),
            );
          },
          cursorColor: AppColors.grey3,
          cursorWidth: 1,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.grey8,
                ),
                borderRadius: BorderRadius.circular(8)),
            hintText: widget.hint,
            hintStyle: const TextStyle(
              color: AppColors.grey5,
            ),
            filled: true,
            fillColor: AppColors.white,
            focusedBorder: InputBorder.none,
            suffixIcon: widget.controller!.text.isEmpty
                ? const SizedBox()
                : GestureDetector(
                    onTap: () {
                      widget.controller!.clear();
                      widget.onClean?.call();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: widget.isSearching! ? 15 : 10),
                      child: const Icon(
                        Icons.close,
                        color: AppColors.grey3,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
