import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

/// A shimmer loading effect for property cards while data is being fetched
class PropertyCardShimmer extends StatelessWidget {
  final bool isHorizontal;

  const PropertyCardShimmer({
    Key? key,
    this.isHorizontal = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isHorizontal) {
      return _buildHorizontalShimmer();
    } else {
      return _buildVerticalShimmer();
    }
  }

  Widget _buildHorizontalShimmer() {
    return SizedBox(
      height: 320.h,
      width: 600.w,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Show 5 shimmer cards
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            height: 320.h,
            width: 240.w,
            margin: const EdgeInsets.all(10),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image placeholder
                    Container(
                      height: 180.h,
                      width: 240.w,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),

                    // Title placeholder
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        height: 18,
                        width: 150,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Location placeholder
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        height: 14,
                        width: 120,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Facilities placeholder
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Container(
                            height: 12,
                            width: 50,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 12),
                          Container(
                            height: 12,
                            width: 50,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 12),
                          Container(
                            height: 12,
                            width: 50,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Price placeholder
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        height: 18,
                        width: 80,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVerticalShimmer() {
    return ListView.builder(
      itemCount: 5, // Show 5 shimmer cards
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          height: 120,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Row(
                children: [
                  // Image placeholder
                  Container(
                    height: 120,
                    width: 120,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Title placeholder
                        Container(
                          height: 16,
                          width: 150,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),

                        // Location placeholder
                        Container(
                          height: 12,
                          width: 120,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 12),

                        // Facilities placeholder
                        Row(
                          children: [
                            Container(
                              height: 10,
                              width: 40,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 12),
                            Container(
                              height: 10,
                              width: 40,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Price placeholder
                        Container(
                          height: 16,
                          width: 80,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
