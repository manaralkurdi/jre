// Filtered properties page that displays only properties of a specific type
import 'package:flutter/material.dart';

import '../../../model/home/proparty_model.dart' show Property;
import '../../../utils/Colors.dart' show primaryColor;
import '../component/dynamic_property.dart';

class SearchPage extends StatelessWidget {
   SearchPage({Key? key, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Property> properties =
    // Mock data - in a real app, this would come from local storage
    [
      Property(
        rating: 5,
        id: '1',
        title: 'Modern Apartment',
        price: 267000,
        location: 'New York, NY',
        locationCode: '2BW',
        beds: 4,
        baths: 3,
        kitchens: 1,
        imageUrl:  'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2',
        type: 'Apartment',
        name: 'Khaothong Terrace 1',
        country: 'Krabi Thailand',
        sqft: 6575,
      ),
      Property(
        id: '2',
        title: 'Luxury Villa',
        price: 550000,
        location: 'Miami, FL',
        locationCode: '3CV',
        beds: 5,
        baths: 4,
        kitchens: 2,
        imageUrl:  'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2',
        type: 'Villa',
        name: 'Khaothong Terrace 1',
        country: 'Krabi Thailand',
        sqft: 6575,
        rating: 5,
      ),
      Property(
        id: '3',
        title: 'Family House',
        price: 320000,
        location: 'Austin, TX',
        locationCode: '4FH',
        beds: 4,
        baths: 2,
        kitchens: 1,
        imageUrl:  'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2',
        type: 'House',
        name: 'Khaothong Terrace 1',
        country: 'Krabi Thailand',
        sqft: 6575,
        rating: 5,
      ),
      Property(
        id: '4',
        title: 'Modern Villa',
        price: 620000,
        location: 'Los Angeles, CA',
        locationCode: '5MV',
        beds: 6,
        baths: 5,
        kitchens: 2,
        imageUrl:  'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2',
        type: 'Villa',
        name: 'Khaothong Terrace 1',
        country: 'Krabi Thailand',
        sqft: 6575,
        rating: 5,
      ),
      Property(
        id: '5',
        title: 'Studio Apartment',
        price: 175000,
        location: 'Chicago, IL',
        locationCode: '1SA',
        beds: 1,
        baths: 1,
        kitchens: 1,
        imageUrl:  'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2',
        type: 'Apartment',
        name: 'Khaothong Terrace 1',
        country: 'Krabi Thailand',
        sqft: 6575,
        rating: 5,
      ),
      Property(
        id: '6',
        title: 'Countryside House',
        price: 290000,
        location: 'Boulder, CO',
        locationCode: '6CH',
        beds: 3,
        baths: 2,
        kitchens: 1,
        imageUrl: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2',
        type: 'House',
        name: 'Khaothong Terrace 1',
        country: 'Krabi Thailand',
        sqft: 6575,
        rating: 5,
      ),
    ];
    return Scaffold(
      appBar: AppBar(elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text('',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,automaticallyImplyLeading: true,
      ),
      body: ListView.builder(
        itemCount: properties.length,
        itemBuilder: (context, index) {
          final property = properties[index];
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
