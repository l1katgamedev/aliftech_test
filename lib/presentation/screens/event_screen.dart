import 'package:aliftech_test/data/models/event_model.dart';
import 'package:aliftech_test/presentation/blocs/events/event_bloc.dart';
import 'package:aliftech_test/presentation/widgets/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  EventScreenState createState() => EventScreenState();
}

class EventScreenState extends State<EventScreen> {
  Color _eventColor = Colors.blue;

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ColorPicker(
          initialColor: _eventColor,
          onColorSelected: (Color color) {
            setState(() {
              _eventColor = color;
            });
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<EventBloc, EventState>(
        listener: (context, state) {
          if (state is SuccessEventState) {
            BlocProvider.of<EventBloc>(context).add(ReadEvents());
            Navigator.of(context).pop();
          }
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Event name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFE5E5E5),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Event description',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        minLines: 4,
                        maxLines: 8,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFE5E5E5),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Event location',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFE5E5E5),
                          suffixIcon: const Icon(
                            Icons.location_on,
                            size: 28,
                            color: Color(0xFF009FEE),
                          ),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Event Color: '),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5E5E5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => _showColorPicker(),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: _eventColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down_sharp),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Event time',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFE5E5E5),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<EventBloc>(context).add(CreateEvent(
                          DayEvent(
                            name: 'First',
                            description: 'First desc',
                            location: 'First loc',
                            colorValue: Colors.black.value,
                            dateTime: DateTime(1990),
                          ),
                        ));
                      },
                      child: const Text('Add event'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
