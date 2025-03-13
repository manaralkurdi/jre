import 'package:flutter/material.dart';

import '../../../domain/model/home/proparty_model.dart';
import '../component/dynamic_property.dart';

class FilteredPropertiesPage extends StatelessWidget {
  final int filterType;
final List<PropertyDataCategory> response;
  const FilteredPropertiesPage({Key? key, required this.filterType, required this.response})
    : super(key: key);

  @override
  Widget build(BuildContext context) {


    // Filter properties based on selected type
    final filteredProperties =
    response.where((p) => p.propertyType == filterType).toList();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text('$filterType',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,automaticallyImplyLeading: true,
      ),
      body:
          filteredProperties.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home_work, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'No $filterType properties found',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                itemCount: filteredProperties.length,
                itemBuilder: (context, index) {
                  final property = filteredProperties[index];
                  return DynamicPropertyCard<PropertyDataCategory>(
                    property: property,
                    titleExtractor: (p) => p.nameEn,
                    priceExtractor: (p) => '\$${p.dailyPrice}',
                    locationCodeExtractor: (p) => p.location,
                    locationExtractor: (p) => p.location,
                    bedsExtractor: (p) => 3,
                    bathsExtractor: (p) =>2,
                    kitchensExtractor: (p) => 3,
                    imageUrlExtractor: (p) => p.mainImage,
                    //    isFavoriteExtractor: (p) => p.isFavorite,
                    // propertyTypeExtractor: (p) => p.propertyType,
                    // onFavoriteToggle: _toggleFavorite,
                    // onTap: (p) => _navigateToDetails(p),
                  );
                },
              ),
    );
  }
}
