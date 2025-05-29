import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:technewz/backend/functions.dart';
import 'package:technewz/utils/colors.dart';

class Searchbar extends StatefulWidget {
  final VoidCallback onSearch;

  const Searchbar({super.key, required this.onSearch});

  static TextEditingController searchcontroller = TextEditingController();

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          // Search Input Field
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.darkgrey,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: TextField(
                  controller: Searchbar.searchcontroller,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: GoogleFonts.lato(),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Search Icon
          InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
              widget.onSearch();
            },
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.search, color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
