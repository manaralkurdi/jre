import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jre_app/ui/home/bloc/home_bloc.dart';

import '../../../domain/model/home/proparty_model.dart';
import '../../../utils/Colors.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart' show HomeState, HomeStatus;
class PropertyFilter extends StatelessWidget {
  final String selectedFilter;
  final Function(String, Map<String, dynamic>) onFilterSelected;
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
      {'name': 'Apartment', 'icon': Icons.apartment, 'id': 5},
      {'name': 'Villa', 'icon': Icons.villa, 'id': 4},
      {'name': 'House', 'icon': Icons.home, 'id': 2},
      {'name': 'Farm', 'icon': Icons.villa, 'id': 3},
      {'name': 'Chalet', 'icon': Icons.home, 'id': 1},
    ];

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
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
                  // Pass both the filter name and the filter data to the callback
                  onFilterSelected(filter['name'], filter);

                  // Request category details with the filter ID
                  context.read<HomeBloc>().add(
                    CategoryDetailsLoaded(id: filter['id']),
                  );
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
      },
    );
  }
}