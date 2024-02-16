import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testproject/components/CustomBlueButton.dart';
import 'package:zoom_widget/zoom_widget.dart';

class SeatSelectionScreen extends StatelessWidget {
  const SeatSelectionScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(children: [
          Text(
            "The King’s Man",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            "In theaters december 22, 2021",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff61C3F2)),
          ),
        ]),
      ),
      body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.grey.shade100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 1.1,
                      child: Zoom(
                        maxZoomWidth: 380,
                        maxZoomHeight: 380,
                        child: SvgPicture.asset(
                          'assets/hall2.svg',
                          // Customize the color of the icon
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            child: IconButton(
                                onPressed: () {}, icon: const Icon(Icons.add)),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.remove)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 26),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SeatItem(const Color(0xffCD9D0F), "Selected"),
                            SeatItem(const Color(0xffA6A6A6), "Not available"),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SeatItem(const Color(0xff564CA3), "VIP (150\$)"),
                            SeatItem(
                                const Color(0xff61C3F2), "Regular (50 \$)"),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 22),
                              decoration: BoxDecoration(
                                  color: Color(0xffA6A6A6A).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Row(children: [
                                Text(
                                  "4 /",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text("3 row"),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.close)
                              ]),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                  color: Color(0xffA6A6A6A).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Column(children: [
                                Text("Total Price"),
                                Text(
                                  "\$ 50",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                            ),
                            CustomBlueButton(() async {}, "Proceed to pay"),
                          ],
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Row SeatItem(Color itemColor, String desc) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/Seat.svg',
          width: 24,
          color: itemColor,
          // Customize the color of the icon
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          "$desc",
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Color(0xff8F8F8F)),
        ),
      ],
    );
  }
}
