import 'package:aliftech_test/core/utils.dart';
import 'package:aliftech_test/data/models/event_model.dart';
import 'package:aliftech_test/presentation/blocs/events/event_bloc.dart';
import 'package:aliftech_test/presentation/blocs/home/home_bloc.dart';
import 'package:aliftech_test/presentation/screens/event_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({Key? key}) : super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _selectedDate = DateTime.now();
  late DateTime _currentMonth;
  late DateTime _currentWeekDay;
  late int _currentDay;
  late int _currentYear;
  late DateFormat _weekdayFormat;

  @override
  void initState() {
    _selectedDate = DateTime.now();
    _currentMonth = DateTime.now();
    _currentWeekDay = DateTime.now();
    _currentDay = DateTime.now().day;
    _currentYear = DateTime.now().year;
    _weekdayFormat = DateFormat('E');
    super.initState();
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _changeMonth(int months) {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + months);
    });
  }

  String _getMonthName(DateTime date) {
    final monthFormat = DateFormat('MMMM');
    return monthFormat.format(date);
  }

  String _getWeekDaysName(DateTime date) {
    final weekdayFormat = DateFormat('EEEE');
    return weekdayFormat.format(date);
  }

  List<Widget> _buildWeekdays() {
    final weekdays = <Widget>[];
    const firstDayOfWeek = DateTime.sunday;

    for (var i = 0; i < 7; i++) {
      final weekday = (firstDayOfWeek + i) % 7;
      weekdays.add(
        Text(
          _weekdayFormat.format(DateTime.now().subtract(Duration(days: DateTime.now().weekday - weekday))),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFF969696)),
        ),
      );
    }

    return weekdays;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                color: Colors.transparent,
                onPressed: () {},
                icon: const Icon(Icons.notification_add),
              ),
              Column(
                children: [
                  Text(
                    _getWeekDaysName(_currentWeekDay),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF292929),
                    ),
                  ),
                  Text(
                    "$_currentDay ${_getMonthName(_currentMonth)} $_currentYear",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF292929),
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.notification_add,
                size: 32,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getMonthName(_currentMonth),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: const Color(0xFFEFEFEF),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 16,
                      ),
                      onPressed: () {
                        _changeMonth(-1);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: const Color(0xFFEFEFEF),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 16,
                      ),
                      onPressed: () {
                        _changeMonth(1);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _buildWeekdays(),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 33,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
          ),
          itemBuilder: (BuildContext context, int index) {
            final DateTime firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
            final int daysBeforeMonth = (firstDayOfMonth.weekday - 7 + 7) % 7;
            final int daysInMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;

            DateTime currentDate;
            if (index < daysBeforeMonth) {
              final int day = DateTime(_currentMonth.year, _currentMonth.month, 0).day - (daysBeforeMonth - index) + 1;
              currentDate = DateTime(_currentMonth.year, _currentMonth.month - 1, day);
            } else if (index >= daysBeforeMonth + daysInMonth) {
              final int day = index - (daysBeforeMonth + daysInMonth) + 1;
              currentDate = DateTime(_currentMonth.year, _currentMonth.month + 1, day);
            } else {
              final int day = index - daysBeforeMonth + 1;
              currentDate = DateTime(_currentMonth.year, _currentMonth.month, day);
            }

            final bool isCurrentMonth = currentDate.month == _currentMonth.month;

            bool isToday = _selectedDate.year == currentDate.year &&
                _selectedDate.month == currentDate.month &&
                _selectedDate.day == currentDate.day;

            return GestureDetector(
              onTap: () {
                if (isCurrentMonth) {
                  _selectDate(currentDate);
                }

                BlocProvider.of<EventBloc>(context).add(FilterByDateEvent(dateTime: currentDate.toIso8601String()));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: isToday ? Colors.blue : Colors.transparent, borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      '${currentDate.day}',
                      style: TextStyle(
                        fontSize: 16,
                        color: isCurrentMonth
                            ? isToday
                                ? Colors.white
                                : const Color(0xFF292929)
                            : Colors.grey,
                        fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is LoadedHomeState) {
                        List<DayEvent> isSameDate =
                            state.eventList.where((element) => currentDate.isSameDate(element.dateTime)).toList();

                        return SizedBox(
                          height: 10,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: isSameDate.length,
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, int index) {
                              var element = isSameDate[index];
                              final itemColor = Color(int.parse(element.colorValue, radix: 16) + 0xFF000000);
                              return Container(
                                width: 4,
                                height: 4,
                                margin: const EdgeInsets.only(right: 2),
                                decoration: BoxDecoration(
                                  color: itemColor,
                                  shape: BoxShape.circle,
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Schedule',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const EventScreen();
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.add,
                      size: 16,
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      'Add Event',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
