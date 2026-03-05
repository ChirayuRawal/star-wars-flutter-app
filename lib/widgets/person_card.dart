import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/person_model.dart';

class PersonCard extends StatefulWidget {
  final Person person;

  const PersonCard({super.key, required this.person});

  @override
  State<PersonCard> createState() => _PersonCardState();
}

class _PersonCardState extends State<PersonCard> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.95),
      onTapUp: (_) {
        setState(() => _scale = 1.0);
        _showDetails();
      },
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 150),
        child: Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            title: Text(widget.person.name),
          ),
        ),
      ),
    );
  }

  void _showDetails() {
    final heightInMeter =
        (double.tryParse(widget.person.height) ?? 0) / 100;

    final formattedDate = DateFormat('dd-MM-yyyy')
        .format(DateTime.parse(widget.person.created));

    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.person.name,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Height: ${heightInMeter.toStringAsFixed(2)} m"),
            Text("Mass: ${widget.person.mass} kg"),
            Text("Birth Year: ${widget.person.birthYear}"),
            Text("Films: ${widget.person.films.length}"),
            Text("Created: $formattedDate"),
          ],
        ),
      ),
    );
  }
}