import 'package:flutter/material.dart';
import 'package:pokedex_egsys/core/theme/app_colors.dart';

class SearchInput extends StatefulWidget {
  final String hint;
  final Function? onChange;
  final TextEditingController? controller;
  final Function? onTap;
  final bool? isSearching;
  final Function? onClean;

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
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 150),
      child: SizedBox(
        height: 50,
        child: TextFormField(
          //inputFormatters: widget.mask == null ? null : [widget.mask!],
          onTap: widget.onTap as void Function()?,
          controller: widget.controller,
          onChanged: widget.onChange as void Function(String)?,
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
              color: AppColors.grey7,
            ),
            filled: true,
            fillColor: AppColors.grey8,
            focusedBorder: InputBorder.none,
            suffixIcon: GestureDetector(
              onTap: widget.onClean as void Function()?,
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: widget.isSearching! ? 15 : 10),
                child: const Icon(Icons.close),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
