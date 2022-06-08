import 'package:bloc_learning/extensions/extensions.dart';
import 'package:bloc_learning/models/track/track.dart';
import 'package:flutter/material.dart';

class TrackListItem extends StatelessWidget {
  const TrackListItem({
    required this.track,
    Key? key,
  }) : super(key: key);

  final Track track;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    return ListTile(
      title: Text(track.name),
      leading: CircleAvatar(
        backgroundColor: colorScheme.surfaceVariant,
        radius: 15,
        child: Text(track.trackNumber.toString()),
      ),
      subtitle: Text(track.durationString),
    );
  }
}
