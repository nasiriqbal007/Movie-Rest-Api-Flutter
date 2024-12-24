import 'package:flutter/material.dart';
import 'package:movie_app/data/api_services.dart';
import 'package:movie_app/model/cast_model.dart';
// Import your credits model

class ActorCastList extends StatelessWidget {
  final List<Cast> castList;

  const ActorCastList({super.key, required this.castList});

  @override
  Widget build(BuildContext context) {
    if (castList.isEmpty) {
      return const Center(
        child: Text(
          'No cast information available.',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: castList.length,
        itemBuilder: (context, index) {
          final cast = castList[index];
          return Container(
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              children: [
                cast.profilePath.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipOval(
                          child: Image.network(
                            '$actorImagePath${cast.profilePath}',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : const Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.grey,
                      ),
                const SizedBox(height: 8),
                Text(
                  cast.name,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
