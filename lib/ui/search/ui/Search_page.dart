import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jre_app/data/lib/base/app_config.dart';
import 'package:jre_app/domain/model/home/proparty_model.dart';
import 'package:jre_app/domain/repositry/home/repositry_random.dart';
import 'package:jre_app/ui/Details/ui/property_deatils.dart';
import 'package:jre_app/ui/home/component/dynamic_property.dart';
import '../../Details/bloc/details_bloc.dart';
import '../component/search_component.dart';
import '../search_bloc.dart';
import '../search_state.dart';

class SearchPage extends StatefulWidget {
  final List<PropertyDataCategory>? properties; // Can be null for initial load

  const SearchPage({Key? key, this.properties}) : super(key: key);

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
        builder: (context) => BlocProvider<DetailsBloc>(
          create: (context) => DetailsBloc(repository),
          child: PropertyViewScreen(propertyId: int.parse(id.toString())),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void _showSearchBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        // Use the current SearchBloc instance from context
        child: BlocProvider.value(
          value: BlocProvider.of<SearchBloc>(context),
          child: SearchBottomSheet(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        actions: [
        ],
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state.status == SearchStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'An error occurred')),
            );
          }
        },
        builder: (context, state) {
          // Priority 1: Show filtered results when available from the SearchBloc
          if (state.status == SearchStatus.SearchSuccsess ) {
            final results = state.filteredProperties!.cast<PropertyDataCategory>();
            return _buildSearchResults(results);
          }

          // Priority 2: Show properties passed from constructor if available
          if (widget.properties != null && widget.properties!.isNotEmpty) {
            return _buildSearchResults(widget.properties!);
          }

          // Priority 3: Show loading indicator during search
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          // Priority 4: Show empty results state or initial state
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search, size: 48, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  state.status == SearchStatus.SearchSuccsess ?
                  'No properties match your criteria' : 'Start your search',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _showSearchBottomSheet,
                  child: Text('Refine Search'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchResults(List<PropertyDataCategory> properties) {
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