import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: WeeklyExpenseScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class WeeklyExpenseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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
                // Header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.grey.shade400),
                          ),
                        ),
                        child: Text(
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
                SizedBox(height: 16),
                // Circle Chart
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleWidget(
                        radius: 80,
                        backgroundColor: Color(0xFFEEEAFB),
                        text: "48%",
                        textColor: Color(0xFF562BDF),
                      ),
                      Positioned(
                        top: 40,
                        right: 50,
                        child: CircleWidget(
                          radius: 60,
                          backgroundColor: Color(0xFFE4F5ED),
                          text: "32%",
                          textColor: Color(0xFF67B68D),
                        ),
                      ),
                      Positioned(
                        bottom: 40,
                        left: 60,
                        child: CircleWidget(
                          radius: 40,
                          backgroundColor: Color(0xFFFBE5E8),
                          text: "13%",
                          textColor: Color(0xFFD6596E),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 50,
                        child: CircleWidget(
                          radius: 30,
                          backgroundColor: Color(0xFFFAF2E2),
                          text: "7%",
                          textColor: Color(0xFFE09F65),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                // Dashed Divider
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DashDivider(),
                ),
                SizedBox(height: 16),
                // Expense Rows
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                SizedBox(height: 16),
              ],
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
    required this.label,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 6,
              backgroundColor: color,
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}

class DashDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashWidth = 6.0;
        final dashSpace = 3.0;
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
