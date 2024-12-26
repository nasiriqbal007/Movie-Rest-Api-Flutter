import 'package:flutter/material.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/utils/image_error_helper.dart';

class MediaGridView<T> extends StatelessWidget {
  final List<T> items;
  final String errorMessage;
  final Function(T item) onItemTap;
  final String Function(T item) getTitle;
  final String Function(T item) getPosterPath;
  final double Function(T item) getVoteAverage;

  const MediaGridView({
    super.key,
    required this.items,
    required this.errorMessage,
    required this.onItemTap,
    required this.getTitle,
    required this.getPosterPath,
    required this.getVoteAverage,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.52,
          crossAxisCount: 3),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => onItemTap(item),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 0.64,
                  child: Image.network(
                    '$imagePath${getPosterPath(item)}',

                    fit: BoxFit.cover,
                    loadingBuilder: customImageLoadingBuilder, // Custom loader
                    errorBuilder:
                        customImageErrorBuilder, // Custom error handling
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Text(
                  getTitle(item),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Text(
                  getVoteAverage(item).toStringAsFixed(1),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
