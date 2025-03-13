import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jre_app/data/lib/base/app_config.dart';
import 'package:jre_app/domain/model/home/proparty_model.dart';
import 'package:jre_app/domain/repositry/home/repositry_random.dart';
import 'package:jre_app/ui/home/bloc/home_bloc.dart';
import 'package:jre_app/ui/home/bloc/home_state.dart';
import 'package:jre_app/ui/Details/ui/property_deatils.dart';
import 'package:jre_app/ui/home/component/dynamic_property.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void _navigateToDetails(dynamic id) {
    final appConfig = AppConfig();
    final repository = RealEstateRepository(appConfig: appConfig);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(repository),
          child: PropertyViewScreen(propertyId: int.parse(id.toString())),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        // Implement listener if needed for state changes
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            title: const Text(
              'Search Results',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
          ),
          body: _buildSearchResults(state),
        );
      },
    );
  }

  Widget _buildSearchResults(HomeState state) {
    final properties = state.filteredProperties;

    if (properties.isEmpty) {
      return const Center(
        child: Text(
          'No properties found',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

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
          imageUrlExtractor: (p) async {
            final appConfig = AppConfig();
            final baseUrl = await appConfig.imageUrl;
            return p.mainImage != null
                ? '$baseUrl${p.mainImage}'
                : '$baseUrl/default.jpg';
          },
          propertyTypeExtractor: (p) => p.propertyType,
          onTap: (p) => _navigateToDetails(p.id),
        );
      },
    );
  }
}