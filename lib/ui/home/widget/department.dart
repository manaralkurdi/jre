import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jre_app/base/component/app_custom_text.dart';

import 'package:jre_app/ui/home/widget/filter_page.dart';
import '../../../utils/Colors.dart';
import 'filter_page.dart';

// Property Filter widget that navigates to filtered results page
class PropertyFilter extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;

  const PropertyFilter({
    Key? key,
    required this.selectedFilter,
    required this.onFilterSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> filters = [
     // {'name': 'All', 'icon': Icons.grid_view_rounded},
      {'name': 'Apartment', 'icon': Icons.apartment},
      {'name': 'Villa', 'icon': Icons.villa},
      {'name': 'House', 'icon': Icons.home},
      {'name': 'Farm', 'icon': Icons.agriculture},
      {'name': 'Chalet', 'icon': Icons.cottage},
    ];

    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilter == filter['name'];

          return GestureDetector(
            onTap: () {
              onFilterSelected(filter['name']);
              if (filter['name'] != 'All') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilteredPropertiesPage(
                      filterType: filter['name'],
                    ),
                  ),
                );
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: primaryColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    filter['icon'],
                    color: isSelected ? Colors.white : primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  AppCustomText(titleText:
                    filter['name'],
                    style: TextStyle(
                      color: isSelected ? Colors.white : primaryColor,
                      fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}