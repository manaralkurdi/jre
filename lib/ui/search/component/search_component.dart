import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jre_app/base/component/app_custom_text.dart';
import 'package:jre_app/domain/model/home/filter_request.dart';
import 'package:jre_app/ui/search/search_event.dart';


import '../../../../routes/app_route_name.dart';
import '../search_bloc.dart';
import '../search_state.dart';

class SearchBottomSheet extends StatefulWidget {
  @override
  _SearchBottomSheetState createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  DateTime checkInDate = DateTime.now().add(Duration(days: 7));
  DateTime checkOutDate = DateTime.now().add(Duration(days: 9));
  int rooms = 0;
  int guests = 0;

  // Create filter request object
  final RealEstateFilterRequest _filterRequest = RealEstateFilterRequest();

  final Map<String, Map<String, int>> _countryAreaIds = {
    'jordan': {
      'Abdoun': 1,
      'Sweifieh': 2,
      'Deir Ghbar': 3,
      'Seventh Circle': 4,
      'Tlaa Al-Ali': 5,
      'Jabal Amman': 6,
      'Jabal Al-Lweibdeh': 7,
      'Umm Uthaina': 8,
    },
    'egypt': {
      'shekh_zayd': 9,
    },
  };

  final Map<String, int> _countryIds = {
    'jordan': 1,
    'egypt': 2,
  };

  final Map<String, List<String>> _countryAreas = {
    'jordan': [
      'Abdoun',
      'Sweifieh',
      'Deir Ghbar',
      'Seventh Circle',
      'Tlaa Al-Ali',
      'Jabal Amman',
      'Jabal Al-Lweibdeh',
      'Umm Uthaina'
    ],
    'egypt': [
      'shekh_zayd',
    ],
  };

  String? _selectedCountry;
  String? _selectedArea;

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isCheckIn ? checkInDate : checkOutDate,
      firstDate: isCheckIn ? DateTime.now() : checkInDate,
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkInDate = picked;
          // If check-out date is before check-in date, update it
          if (checkOutDate.isBefore(checkInDate)) {
            checkOutDate = checkInDate.add(Duration(days: 2));
          }
        } else {
          checkOutDate = picked;
        }
      });
    }
  }

  void _updateFilterRequest() {
    // Set values to filter request
    if (_selectedCountry != null) {
      _filterRequest.setCountry(_countryIds[_selectedCountry]!);
    }
    else {
      _filterRequest.setCountry(1);
    }

    if (_selectedArea != null && _selectedCountry != null) {
      _filterRequest.setRegion(
          _countryAreaIds[_selectedCountry]![_selectedArea]!);
    }
    else {
      _filterRequest.setRegion(0);
    }

    _filterRequest.setPeopleCount(guests);
    _filterRequest.setRoomsCount(rooms);

    // Set check-in and check-out dates if your filter request supports it
    // _filterRequest.setCheckInDate(checkInDate);
    // _filterRequest.setCheckOutDate(checkOutDate);
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Localizations.localeOf(context).languageCode == 'ar';

    return BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          if(state.status == SearchStatus.SearchSuccsess) {
            Navigator.of(context).pop();
            // Navigate to search results page with results
            Navigator.of(context).pushNamed(
              AppRoutes.SEARCH,
              arguments: state.filteredProperties,
            );
            print('Search results: ${state.filteredProperties}');
          } else if(state.status == SearchStatus.error) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Error searching')),
            );
            Navigator.of(context).pop();
            // Navigate to search results page with results
            Navigator.of(context).pushNamed(
              AppRoutes.SEARCH,
              arguments: [],
            );
          }
        },
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: AppCustomText(
                    titleText: 'search',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppCustomText(
                            titleText: 'check_in',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () => _selectDate(context, true),
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat('dd/MM/yyyy').format(checkInDate),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Icon(Icons.calendar_today, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppCustomText(
                            titleText: 'check_out',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () => _selectDate(context, false),
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat('dd/MM/yyyy').format(checkOutDate),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Icon(Icons.calendar_today, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppCustomText(
                            titleText: 'country',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: AppCustomText(
                                  titleText: 'select_country',
                                  style: TextStyle(fontSize: 14),
                                ),
                                value: _selectedCountry,
                                items: _countryAreas.keys.map((String country) {
                                  return DropdownMenuItem<String>(
                                    value: country,
                                    child: AppCustomText(titleText: country),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedCountry = newValue;
                                    _selectedArea = null; // Reset area when country changes
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppCustomText(
                            titleText: 'area',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: AppCustomText(
                                  titleText: 'select_area',
                                  style: TextStyle(fontSize: 14),
                                ),
                                value: _selectedArea,
                                items: _selectedCountry == null
                                    ? []
                                    : _countryAreas[_selectedCountry]!.map(
                                      (String area) {
                                    return DropdownMenuItem<String>(
                                      value: area,
                                      child: AppCustomText(titleText: area),
                                    );
                                  },
                                ).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedArea = newValue;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildCounterField('number_of_rooms', rooms, (value) {
                  setState(() => rooms = value);
                }),
                SizedBox(height: 20),
                _buildCounterField('number_of_guests', guests, (value) {
                  setState(() => guests = value);
                }),
                35.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: BorderSide(color: Colors.grey.withOpacity(0.3)),
                          ),
                        ),
                        child: AppCustomText(titleText: ('cancel')),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: state.isLoading
                            ? null  // Disable button when loading
                            : () {
                          _updateFilterRequest();
                          // Dispatch the submit search event to SearchBloc
                          context.read<SearchBloc>().add(FilterResult(_filterRequest));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: state!.isLoading
                            ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                            : AppCustomText(titleText: ('confirm')),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
    );
  }

  Widget _buildCounterField(String title, int value, Function(int) onChanged) {
    // Check if UI is in RTL mode for Arabic
    final isRtl = Localizations.localeOf(context).languageCode == 'ar';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppCustomText(
                  titleText: title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove, color: Colors.blue),
                    onPressed: value > 1 ? () => onChanged(value - 1) : null,
                  ),
                  Text(
                    value.toString(),
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.blue),
                    onPressed: () => onChanged(value + 1),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}