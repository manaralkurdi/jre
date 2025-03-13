import 'package:flutter/material.dart';

/// A generic property card that can work with any property model
/// by using a flexible approach with callbacks to extract data
class DynamicPropertyCard<T> extends StatelessWidget {
  /// The property data object
  final T property;

  /// Callback to extract the title from the property
  final String Function(T property) titleExtractor;

  /// Callback to extract the price from the property
  final String Function(T property) priceExtractor;

  /// Callback to extract the location code from the property
  final String Function(T property) locationCodeExtractor;

  /// Callback to extract the location from the property
  final String Function(T property) locationExtractor;

  /// Callback to extract the number of beds from the property
  final int Function(T property) bedsExtractor;

  /// Callback to extract the number of baths from the property
  final int Function(T property) bathsExtractor;

  /// Callback to extract the number of kitchens from the property
  final int Function(T property) kitchensExtractor;

  /// Callback to extract the image URL from the property
  final String Function(T property) imageUrlExtractor;

  /// Optional callback for handling favorite toggle
  final Function(T property, bool isFavorite)? onFavoriteToggle;

  /// Optional callback for handling card tap
  final Function(T property)? onTap;

  /// Flag to determine if the property is a favorite
  final bool Function(T property)? isFavoriteExtractor;

  /// Optional callback to extract any additional property type label
  final String? Function(T property)? propertyTypeExtractor;

  const DynamicPropertyCard({
    Key? key,
    required this.property,
    required this.titleExtractor,
    required this.priceExtractor,
    required this.locationCodeExtractor,
    required this.locationExtractor,
    required this.bedsExtractor,
    required this.bathsExtractor,
    required this.kitchensExtractor,
    required this.imageUrlExtractor,
    this.onFavoriteToggle,
    this.onTap,
    this.isFavoriteExtractor,
    this.propertyTypeExtractor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap != null ? () => onTap!(property) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[900] : Colors.white,
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
              // Property Image with Stack for favorite button and property type label
              Stack(
                children: [
                  // Image
                  ClipRRect(
                    borderRadius:  BorderRadius.circular(30
                    ),
                    child: Image.network(

                      imageUrlExtractor(property),
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.error, color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),

                  // Favorite button
                  if (onFavoriteToggle != null && isFavoriteExtractor != null)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          final isFavorite = isFavoriteExtractor!(property);
                          onFavoriteToggle!(property, !isFavorite);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            isFavoriteExtractor!(property)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavoriteExtractor!(property)
                                ? Colors.red
                                : Colors.grey,
                            size: 20,
                          ),
                        ),
                      ),
                    ),

                  // Property type label
                  // if (propertyTypeExtractor != null && propertyTypeExtractor!(property) != null)
                  //   Positioned(
                  //     top: 10,
                  //     left: 10,
                  //     child: Container(
                  //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  //       decoration: BoxDecoration(
                  //         color: Color(0xff3D5BF6),
                  //         borderRadius: BorderRadius.circular(30),
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: Colors.black.withOpacity(0.1),
                  //             blurRadius: 5,
                  //             offset: const Offset(0, 2),
                  //           ),
                  //         ],
                  //       ),
                  //       child: Text(
                  //         propertyTypeExtractor!(property)!,
                  //         style: const TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                ],
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
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          priceExtractor(property),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff3D5BF6),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Location
                    Row(
                      children: [
                        Icon(
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
                          iconColor: Colors.redAccent,
                        ),

                        const SizedBox(width: 20),

                        // Bath
                        _buildFeatureItem(
                          icon: Icons.bathtub,
                          value: '${bathsExtractor(property)} Bath',
                          iconColor: Colors.redAccent,
                        ),

                        const SizedBox(width: 20),

                        // Kitchen
                        _buildFeatureItem(
                          icon: Icons.kitchen,
                          value: '${kitchensExtractor(property)} Kitchen',
                          iconColor: Colors.redAccent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String value,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 20,
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