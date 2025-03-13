import 'package:flutter/material.dart';

/// A generic property card that can work with any model type
class GenericPropertyListingCard<T> extends StatelessWidget {
  /// The property data object
  final T property;

  /// Extracts the property title
  final String Function(T property) titleExtractor;

  /// Extracts the property price
  final double Function(T property) priceExtractor;

  /// Extracts the location code
  final String Function(T property) locationCodeExtractor;

  /// Extracts the location name
  final String Function(T property) locationExtractor;

  /// Extracts the number of beds
  final int Function(T property) bedsExtractor;

  /// Extracts the number of baths
  final int Function(T property) bathsExtractor;

  /// Extracts the number of kitchens
  final int Function(T property) kitchensExtractor;

  /// Extracts the image URL or asset path
  final String Function(T property) imageExtractor;

  /// Determines if the image is an asset (true) or network image (false)
  final bool isAssetImage;

  const GenericPropertyListingCard({
    Key? key,
    required this.property,
    required this.titleExtractor,
    required this.priceExtractor,
    required this.locationCodeExtractor,
    required this.locationExtractor,
    required this.bedsExtractor,
    required this.bathsExtractor,
    required this.kitchensExtractor,
    required this.imageExtractor,
    this.isAssetImage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
              child: _buildImage(),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Price Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          titleExtractor(property),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '\$${priceExtractor(property).toInt()}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[600],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Location
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${locationCodeExtractor(property)}  ${locationExtractor(property)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Property Details Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Bed
                      _buildFeatureItem(
                        icon: Icons.bed,
                        value: '${bedsExtractor(property)} Bed',
                      ),

                      const SizedBox(width: 20),

                      // Bath
                      _buildFeatureItem(
                        icon: Icons.bathtub,
                        value: '${bathsExtractor(property)} Bath',
                      ),

                      const SizedBox(width: 20),

                      // Kitchen
                      _buildFeatureItem(
                        icon: Icons.kitchen,
                        value: '${kitchensExtractor(property)} Kitchen',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    final imagePath = imageExtractor(property);

    if (isAssetImage) {
      return Image.asset(
        imagePath,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      );
    } else {
      return Image.network(
        imagePath,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      );
    }
  }

  Widget _buildErrorWidget() {
    return Container(
      height: 200,
      color: Colors.grey[300],
      child: const Center(
        child: Icon(Icons.error, color: Colors.grey),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.redAccent,
          size: icon == Icons.bed ? 20 : 18,
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}