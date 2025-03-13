import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jre_app/data/lib/base/app_config.dart';
import 'package:jre_app/domain/model/home/proparty_model.dart';
import 'package:jre_app/domain/repositry/home/repositry_random.dart';
import 'package:jre_app/ui/home/bloc/home_bloc.dart';
import 'package:jre_app/ui/home/bloc/home_state.dart';

import '../../Details/ui/property_deatils.dart';
import '../component/dynamic_property.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key,})
      : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  _navigateToDetails(id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
            BlocProvider<HomeBloc>(
              create: (context) =>
                  HomeBloc(AppConfig() as RealEstateRepositoryType),
              child: PropertyViewScreen(propertyId: id ?? "1"),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text('', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final properties = state.filteredProperties;
          return ListView.builder(
            itemCount: properties.length,
            itemBuilder: (context, index) {
              final property = properties[index];
              return DynamicPropertyCard<PropertyDataCategory>(
                property: property,
                titleExtractor: (p) => p.nameEn,
                priceExtractor: (p) => '\$${p.dailyPrice}',
                locationCodeExtractor: (p) => p.location,
                locationExtractor: (p) => p.location,
                bedsExtractor: (p) => 3,
                bathsExtractor: (p) => 3,
                kitchensExtractor: (p) => 2,
                imageUrlExtractor: (p) => p.mainImage,
                //isFavoriteExtractor: (p) => p.isFavorite,
                propertyTypeExtractor: (p) => p.propertyType,
                // onFavoriteToggle: _toggleFavorite,
                onTap: (p) => _navigateToDetails(p.id),
              );
            },
          );
        },
      ),
    );
  }
}
