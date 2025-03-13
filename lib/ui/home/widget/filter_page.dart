import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocConsumer, BlocProvider;

import '../../../data/lib/base/app_config.dart';
import '../../../domain/model/home/proparty_model.dart';
import '../../../domain/repositry/home/repositry_random.dart';
import '../../Details/ui/property_deatils.dart';
import '../bloc/home_bloc.dart' show HomeBloc;
import '../bloc/home_state.dart';
import '../component/dynamic_property.dart';

class CategoryList extends StatelessWidget {
  final int filterType;
  final String filterName;
  final List<PropertyDataCategory> properties;

  const CategoryList({
    Key? key,
    required this.filterType,
    required this.properties,
    required this.filterName,
  }) : super(key: key);

  void _navigateToDetails(BuildContext context, PropertyDataCategory property) {
    final appConfig = AppConfig();
    final repository = RealEstateRepository(appConfig: appConfig);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(repository),
          child: PropertyViewScreen(
            propertyId: int.tryParse(property.id.toString()) ?? 0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter properties based on selected type
    final filteredProperties = properties
        .where((p) => p.propertyType == filterType.toString())
        .toList();

    return BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.status == HomeStatus.error) {
            // Show error snackbar or dialog if needed
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'An error occurred'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              title: Text(
                filterName,
                style: const TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
            ),
            body: _buildBody(context, filteredProperties, state),
          );
        }
    );
  }

  Widget _buildBody(
      BuildContext context,
      List<PropertyDataCategory> filteredProperties,
      HomeState state
      ) {
    // Show loading indicator if state is loading
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return _buildPropertyList(context, filteredProperties);
  }

  Widget _buildPropertyList(
      BuildContext context,
      List<PropertyDataCategory> filteredProperties
      ) {
    if (filteredProperties.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home_work, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No $filterName properties found',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredProperties.length,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        final property = filteredProperties[index];
        return DynamicPropertyCard<PropertyDataCategory>(
          property: property,
          titleExtractor: (p) => p.nameEn ?? 'Property',
          priceExtractor: (p) => '\$${p.dailyPrice ?? 0}',
          locationCodeExtractor: (p) => p.location ?? '',
          locationExtractor: (p) => p.location ?? '',
          bedsExtractor: (p) => 3,
          bathsExtractor: (p) => 2,
          kitchensExtractor: (p) => 1,
          imageUrlExtractor: (p) async {
            final appConfig = AppConfig();
            final baseUrl = await appConfig.imageUrl;
            return p.mainImage != null
                ? '$baseUrl${p.mainImage}'
                : '$baseUrl/default.jpg';
          },
          propertyTypeExtractor: (p) => p.propertyType ?? '0',
          onTap: (p) => _navigateToDetails(context, p),
        );
      },
    );
  }
}