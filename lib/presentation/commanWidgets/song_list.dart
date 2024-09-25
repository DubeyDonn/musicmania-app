import 'package:flutter/material.dart';

class SongList extends StatelessWidget {
  final List<dynamic> model;
  final double borderRadius;

  const SongList({
    Key? key,
    required this.model,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: model.length,
      itemBuilder: (context, index) {
        final item = model[index];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Image.network(
              item['imageUrl'] ?? 'https://via.placeholder.com/150',
              fit: BoxFit.cover,
              width: 50,
              height: 50,
            ),
          ),
          title: Text(item['title'] ?? 'Unknown Title'),
          subtitle: Text(item['subtitle'] ?? 'Unknown Subtitle'),
          onTap: () {
            // Handle item tap
          },
        );
      },
    );
  }
}
