import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:jre_app/ui/home/widget/filter_page.dart';
import '../../../domain/model/home/proparty_model.dart';
import '../../../utils/Colors.dart';
import 'filter_page.dart';

// Property Filter widget that navigates to filtered results page
class PropertyFilter extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;
  final List<PropertyDataCategory> response;

  const PropertyFilter({
    Key? key,
    required this.selectedFilter,
    required this.onFilterSelected,
    required this.response,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> filters = [
      // {'name': 'All', 'icon': Icons.grid_view_rounded,'id':1},
      {'name': 'Apartment', 'icon': Icons.apartment,'id':5},
      {'name': 'Villa', 'icon': Icons.villa,'id':4},
      {'name': 'House', 'icon': Icons.home,'id':1},
      {'name': 'Farm', 'icon': Icons.villa,'id':3},
      {'name': 'Chaleh', 'icon': Icons.home,'id':1},
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
              // Navigate to filtered results page if not "All"
              if (filter['name'] != 'All') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilteredPropertiesPage(
                      filterType: filter['id'],
                      response: response,
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
                  Text(
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