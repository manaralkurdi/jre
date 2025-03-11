import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jre_app/base/component/app_custom_text.dart';

import '../../../model/home/proparty_model.dart';
import '../widget/Search_page.dart';
import 'dynamic_property.dart';

class SearchBottomSheet extends StatefulWidget {
  @override
  _SearchBottomSheetState createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  DateTime checkInDate = DateTime.now().add(Duration(days: 7));
  DateTime checkOutDate = DateTime.now().add(Duration(days: 9));
  int rooms = 1;
  int guests = 1;

  final Map<String, List<String>> _countryAreas = {
    'jordan': ['amman', 'salt', 'zarqa', 'irbid', 'aqaba', 'jerash', 'madaba'],
    'egypt': [
      'cairo',
      'alexandria',
      'giza',
      'sharm_el_sheikh',
      'luxor',
      'aswan',
      'hurghada',
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

  @override
  Widget build(BuildContext context) {
    final isRtl = Localizations.localeOf(context).languageCode == 'ar';

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
                          items:
                              _countryAreas.keys.map((String country) {
                                return DropdownMenuItem<String>(
                                  value: country,
                                  child: AppCustomText(titleText: country),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCountry = newValue;
                              _selectedArea =
                                  null; // Reset area when country changes
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
                          items:
                              _selectedCountry == null
                                  ? []
                                  : _countryAreas[_selectedCountry]!.map((
                                    String area,
                                  ) {
                                    return DropdownMenuItem<String>(
                                      value: area,
                                      child: AppCustomText(titleText: area),
                                    );
                                  }).toList(),
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
                  onPressed: () {
                    // Implement the search functionality
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: AppCustomText(titleText: ('confirm')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<PropertyModel> propertyCard = [
    PropertyModel(
      id: '1',
      title: 'Delux Apartment',
      price: 267000,
      location: 'NY, New York',
      locationCode: '2BW',
      beds: 4,
      baths: 3,
      kitchens: 1,
      imageUrl: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2',
      isFavorite: false,
      propertyType: 'For Sale',
    ),
    PropertyModel(
      id: '2',
      title: 'Modern Penthouse',
      price: 450000,
      location: 'LA, California',
      locationCode: '3AC',
      beds: 5,
      baths: 4,
      kitchens: 1,
      imageUrl: 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267',
      isFavorite: true,
      propertyType: 'Premium',
    ),
    PropertyModel(
      id: '3',
      title: 'Cozy Studio',
      price: 120000,
      location: 'Chicago, Illinois',
      locationCode: '1CS',
      beds: 1,
      baths: 1,
      kitchens: 1,
      imageUrl: 'https://images.unsplash.com/photo-1554995207-c18c203602cb',
      isFavorite: false,
      propertyType: 'For Rent',
    ),
    PropertyModel(
      id: '4',
      title: 'Seaside Villa',
      price: 870000,
      location: 'Miami, Florida',
      locationCode: '5SV',
      beds: 6,
      baths: 5,
      kitchens: 2,
      imageUrl: 'https://images.unsplash.com/photo-1580587771525-78b9dba3b914',
      isFavorite: false,
      propertyType: 'Luxury',
    ),
    PropertyModel(
      id: '5',
      title: 'Family Home',
      price: 320000,
      location: 'Boston, Massachusetts',
      locationCode: '4FH',
      beds: 4,
      baths: 3,
      kitchens: 1,
      imageUrl: 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6',
      isFavorite: true,
      propertyType: 'For Sale',
    ),
  ];

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
                child: AppCustomText(titleText:
                  title,
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

  Widget _buildSearchList(properties) {
    return ListView.builder(
      primary: true,
      shrinkWrap: true,
      itemCount: properties.length,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final property = properties[index];
        return DynamicPropertyCard<PropertyModel>(
          property: property,
          titleExtractor: (p) => p.title,
          priceExtractor: (p) => '\$${p.price.toInt()}',
          locationCodeExtractor: (p) => p.locationCode,
          locationExtractor: (p) => p.location,
          bedsExtractor: (p) => p.beds,
          bathsExtractor: (p) => p.baths,
          kitchensExtractor: (p) => p.kitchens,
          imageUrlExtractor: (p) => p.imageUrl,
          isFavoriteExtractor: (p) => p.isFavorite,
          propertyTypeExtractor: (p) => p.propertyType,
          // onFavoriteToggle: _toggleFavorite,
          // onTap: (p) => _navigateToDetails(p),
        );
      },
    );
  }
}
