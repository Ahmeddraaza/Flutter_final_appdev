import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: WeeklyExpenseScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class WeeklyExpenseScreen extends StatelessWidget {
  const WeeklyExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Weekly Expense",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "From 1 - 6 Apr, 2024",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.grey.shade400),
                            ),
                          ),
                          child: const Text(
                            "View Report",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          right: MediaQuery.of(context).size.width * 0.4,
                          bottom: 50,
                          child: const CircleWidget(
                            radius: 70,
                            backgroundColor: Color(0xFFEEEAFB),
                            text: "48%",
                            textColor: Color(0xFF562BDF),
                          ),
                        ),
                        Positioned(
                          left: MediaQuery.of(context).size.width * 0.52,
                          top: 0,
                          child: const CircleWidget(
                            radius: 55,
                            backgroundColor: Color(0xFFE4F5ED),
                            text: "32%",
                            textColor: Color(0xFF67B68D),
                          ),
                        ),
                        Positioned(
                          left: MediaQuery.of(context).size.width * 0.52,
                          top: 110,
                          child: const CircleWidget(
                            radius: 40,
                            backgroundColor: Color(0xFFFBE5E8),
                            text: "13%",
                            textColor: Color(0xFFD6596E),
                          ),
                        ),
                        Positioned(
                          right: MediaQuery.of(context).size.width * 0.15,
                          bottom: 78,
                          child: const CircleWidget(
                            radius: 25,
                            backgroundColor: Color(0xFFFAF2E2),
                            text: "7%",
                            textColor: Color(0xFFE09F65),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: DashDivider(),
                  ),
                  SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ExpenseRow(
                                label: "Grocery",
                                amount: "\$758.20",
                                color: Color(0xFF8D6DF2),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: ExpenseRow(
                                label: "Food & Drink",
                                amount: "\$758.20",
                                color: Color(0xFF58BD81),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: DashDivider(),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ExpenseRow(
                                label: "Shopping",
                                amount: "\$758.20",
                                color: Color(0xFFE55A5F),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: ExpenseRow(
                                label: "Transportation",
                                amount: "\$758.20",
                                color: Color(0xFFEEA14D),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CircleWidget extends StatelessWidget {
  final double radius;
  final Color backgroundColor;
  final String text;
  final Color textColor;

  const CircleWidget({
    super.key,
    required this.radius,
    required this.backgroundColor,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: Text(
        text,
        style: TextStyle(
          fontSize: radius / 2.5,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}

class ExpenseRow extends StatelessWidget {
  final String label;
  final String amount;
  final Color color;

  const ExpenseRow({
    super.key,
    required this.label,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 6,
              backgroundColor: color,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class DashDivider extends StatelessWidget {
  const DashDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 6.0;
        const dashSpace = 3.0;
        final dashCount =
            (constraints.constrainWidth() / (dashWidth + dashSpace)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return Container(
              width: dashWidth,
              height: 1,
              color: Colors.grey.shade400,
            );
          }),
        );
      },
    );
  }
}
