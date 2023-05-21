import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DateTime _selectedDate;
  late DateTime _currentMonth;
  late DateTime _currentWeekDay;
  late int _currentDay;
  late int _currentYear;
  late DateFormat _weekdayFormat;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _currentMonth = DateTime.now();
    _currentWeekDay = DateTime.now();
    _currentDay = DateTime.now().day;
    _currentYear = DateTime.now().year;
    _weekdayFormat = DateFormat('E');
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

  bool _isSameMonth(DateTime date) {
    return date.year == _currentMonth.year && date.month == _currentMonth.month;
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.notification_add,
                      color: Colors.transparent,
                    ),
                    Column(
                      children: [
                        Text(
                          _getWeekDaysName(_currentWeekDay),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF292929),
                          ),
                        ),
                        Text(
                          "$_currentDay ${_getMonthName(_currentMonth)} $_currentYear",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF292929),
                          ),
                        ),
                      ],
                    ),
                    Icon(
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
                          backgroundColor: Color(0xFFEFEFEF),
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
                        SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Color(0xFFEFEFEF),
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
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _buildWeekdays(),
              ),
              SizedBox(
                height: 10,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: 33,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final DateTime firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
                  final int daysBeforeMonth = (firstDayOfMonth.weekday - 7 + 7) % 7; // Adjust to start from 1
                  final int daysInMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;

                  DateTime currentDate;
                  if (index < daysBeforeMonth) {
                    final int day =
                        DateTime(_currentMonth.year, _currentMonth.month, 0).day - (daysBeforeMonth - index) + 1;
                    currentDate = DateTime(_currentMonth.year, _currentMonth.month - 1, day);
                  } else if (index >= daysBeforeMonth + daysInMonth) {
                    final int day = index - (daysBeforeMonth + daysInMonth) + 1;
                    currentDate = DateTime(_currentMonth.year, _currentMonth.month + 1, day);
                  } else {
                    final int day = index - daysBeforeMonth + 1;
                    currentDate = DateTime(_currentMonth.year, _currentMonth.month, day);
                  }

                  final bool isCurrentMonth = currentDate.month == _currentMonth.month;
                  final bool isToday = currentDate.day == DateTime.now().day &&
                      currentDate.month == DateTime.now().month &&
                      currentDate.year == DateTime.now().year;

                  return GestureDetector(
                    onTap: () {
                      if (isCurrentMonth) {
                        _selectDate(currentDate);
                      }
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${currentDate.day}',
                            style: TextStyle(
                              fontSize: 16,
                              color: isCurrentMonth ? const Color(0xFF292929) : Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (isToday)
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              height: 4,
                              width: 4,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          const SizedBox(height: 5),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: isCurrentMonth ? Colors.blue : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
