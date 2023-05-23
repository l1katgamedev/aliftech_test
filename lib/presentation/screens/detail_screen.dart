import 'dart:developer';

import 'package:aliftech_test/data/models/event_model.dart';
import 'package:aliftech_test/presentation/blocs/events/event_bloc.dart';
import 'package:aliftech_test/presentation/blocs/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatefulWidget {
  final DayEvent item;

  const DetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<EventBloc, EventState>(
        listener: (context, state) {
          if (state is DeletedEventState) {
            BlocProvider.of<HomeBloc>(context).add(LoadEvents());

            Navigator.of(context).pop();
          }

          if (state is ErrorDeleteEventState) {
            log("${'Error delete event'}");
          }
        },
        child: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 350,
                padding: const EdgeInsets.only(top: 80, left: 40, right: 40),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 20,
                              color: Colors.black,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Edit',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Watching Football ',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Manchester United vs Arsenal (Premiere League)',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 30),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_filled_sharp,
                                  size: 24,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '17:30 - 18:30',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 24,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Stamford Bridge',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reminder',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '15 minutes before',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF7C7B7B),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus vel ex sit amet neque dignissim mattis non eu est. Etiam pulvinar est mi, et porta magna accumsan nec. Ut vitae urna nisl. Integer gravida sollicitudin massa, ut congue orci posuere sit amet. Aenean laoreet egestas est, ut auctor nulla suscipit non. ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF7C7B7B),
                      ),
                    ),
                    const SizedBox(height: 50),
                    BlocBuilder<EventBloc, EventState>(
                      builder: (context, state) {
                        return SizedBox(
                          height: 55.0,
                          child: ElevatedButton(
                            onPressed: state is DeletingEventState
                                ? null
                                : () {
                                    BlocProvider.of<EventBloc>(context).add(DeleteEvent(widget.item.id));
                                  },
                            child: state is DeletingEventState
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.delete_forever_outlined,
                                      ),
                                      Text('Delete Event'),
                                    ],
                                  ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
