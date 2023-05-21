import 'package:aliftech_test/presentation/screens/detail.dart';
import 'package:aliftech_test/presentation/widgets/custom_calendar.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              const CustomCalendar(),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DetailScreen(),
                        )),
                    child: Stack(
                      children: [
                        Container(
                          width: 400,
                          height: 130,
                          padding: const EdgeInsets.only(left: 14, right: 14, top: 30, bottom: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF009FEE).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Watching Football ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF056EA1),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              const Text(
                                'Manchester United vs Arsenal (Premiere League)',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF056EA1),
                                ),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.access_time_filled_sharp,
                                        size: 24,
                                        color: Color(0xFF056EA1),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        '17:30 - 18:30',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF056EA1),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.location_on,
                                        size: 24,
                                        color: Color(0xFF056EA1),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        'Stamford Bridge',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF056EA1),
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
                          decoration: const BoxDecoration(
                            color: Color(0xFF009FEE),
                            borderRadius: BorderRadius.only(
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
            ],
          ),
        ),
      ),
    );
  }
}
