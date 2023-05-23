import 'package:aliftech_test/presentation/blocs/events/event_bloc.dart';
import 'package:aliftech_test/presentation/blocs/home/home_bloc.dart';
import 'package:aliftech_test/presentation/screens/detail_event/detail_event_screen.dart';
import 'package:aliftech_test/presentation/widgets/custom_calendar.dart';
import 'package:aliftech_test/presentation/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                const CustomCalendar(),
                const SizedBox(height: 20),
                BlocBuilder<EventBloc, EventState>(
                  builder: (context, state) {
                    if (state is LoadingAllEventsState) {
                      return const LoaderWidget();
                    }

                    if (state is LoadedAllEventState) {
                      return LazyLoadScrollView(
                        isLoading: isLoading,
                        onEndOfPage: () => BlocProvider.of<HomeBloc>(context).add(LoadMoreEvents()),
                        scrollOffset: 100,
                        child: ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.eventList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = state.eventList[index];
                            final itemColor = Color(int.parse(item.colorValue, radix: 16) + 0xFF000000);

                            return GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    item: item,
                                  ),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 14),
                                    padding: const EdgeInsets.only(left: 14, right: 14, top: 30, bottom: 12),
                                    decoration: BoxDecoration(
                                      color: itemColor.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.eventList[index].name,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: itemColor,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          state.eventList[index].description,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: itemColor,
                                          ),
                                        ),
                                        const SizedBox(height: 18),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time_filled_sharp,
                                                  size: 20,
                                                  color: itemColor,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  DateFormat('EEEE, MMM d, yyyy')
                                                      .format(state.eventList[index].dateTime),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: itemColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  size: 20,
                                                  color: itemColor,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  state.eventList[index].location,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: itemColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 400,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: itemColor,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }

                    if (state is EmptyEventState) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text(
                            'No events for today',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF969696),
                            ),
                          ),
                        ),
                      );
                    }

                    return const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Center(
                        child: Text(
                          'Something went wrong',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
