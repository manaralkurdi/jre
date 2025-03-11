// Filtered properties page that displays only properties of a specific type
import 'package:flutter/material.dart';

import '../../../model/home/proparty_model.dart' show Property;
import '../../../utils/Colors.dart' show primaryColor;
import '../component/dynamic_property.dart';

class FilteredPropertiesPage extends StatelessWidget {
  final String filterType;

  const FilteredPropertiesPage({Key? key, required this.filterType})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample property data - in a real app, you would get this from a repository or API
    final List<Property> allProperties = [
      Property(
        id: '1',
        name: 'Modern Apartment',
        location: 'Downtown',
        country: 'USA',
        beds: 2,
        baths: 1,
        sqft: 950,
        price: 267000,
        imageUrl: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2',
        rating: 4.5,
        type: 'Apartment',
        title: 'Delux Apartment',
        kitchens: 1,
        locationCode: 'New York',
      ),
      Property(
        id: '2',
        name: 'Luxury Villa',
        location: 'Beachside',
        country: 'Spain',
        beds: 5,
        baths: 4,
        sqft: 3500,
        price: 750000,
        imageUrl:
            'https://images.unsplash.com/photo-1580587771525-78b9dba3b914',
        rating: 4.9,
        type: 'Villa',
        title: 'Delux Apartment',
        kitchens: 1,
        locationCode: 'New York',
      ),
      Property(
        id: '3',
        name: 'Family House',
        location: 'Suburbs',
        country: 'Canada',
        beds: 4,
        baths: 3,
        sqft: 2200,
        price: 450000,
        imageUrl:
            'https://images.unsplash.com/photo-1564013799919-ab600027ffc6',
        rating: 4.2,
        type: 'House',
        title: 'Delux Apartment',
        kitchens: 1,
        locationCode: 'New York',
      ),
      Property(
        title: 'Delux Apartment',
        kitchens: 1,
        locationCode: 'New York',
        id: '4',
        name: 'Coastal Villa',
        location: 'Malibu',
        country: 'USA',
        beds: 6,
        baths: 5,
        sqft: 4200,
        price: 1250000,
        imageUrl:
            'https://images.unsplash.com/photo-1572120360610-d971b9d7767c',
        rating: 4.8,
        type: 'Villa',
      ),
    ];

    // Filter properties based on selected type
    final filteredProperties =
        allProperties.where((p) => p.type == filterType).toList();

    return Scaffold(
      appBar: AppBar(elevation: 0,
        iconTheme: const IconThemeData(
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
                  return DynamicPropertyCard<Property>(
                    property: property,
                    titleExtractor: (p) => p.title,
                    priceExtractor: (p) => '\$${p.price.toInt()}',
                    locationCodeExtractor: (p) => p.location,
                    locationExtractor: (p) => p.locationCode,
                    bedsExtractor: (p) => p.beds,
                    bathsExtractor: (p) => p.baths,
                    kitchensExtractor: (p) => p.kitchens,
                    imageUrlExtractor: (p) => p.imageUrl,
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
