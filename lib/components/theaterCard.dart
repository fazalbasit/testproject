import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testproject/utils/globals.dart';

class theaterCard extends StatelessWidget {
  const theaterCard({
    super.key,
    required this.selectedIndex,
    required this.currentIndex,
  });
  final int selectedIndex;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(list[currentIndex].time),
              const SizedBox(
                width: 20,
              ),
              Text(
                list[currentIndex].hallName,
                style: const TextStyle(
                    color: Color(0xff8F8F8F),
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 1, // Spread radius
                    blurRadius: 4, // Blur radius
                    offset: Offset(0, 3), // Offset from top left
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: selectedIndex == currentIndex
                      ? const Color(0xff61C3F2)
                      : Colors.white,
                )),
            child: SvgPicture.asset(
              'assets/hall.svg',
              width: MediaQuery.of(context).size.width / 2.5,
              // Customize the color of the icon
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const Text(
                "From",
                style: TextStyle(
                    color: Color(0xff8F8F8F),
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                list[currentIndex].costFrom,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const Text(
                "or",
                style: TextStyle(
                    color: Color(0xff8F8F8F),
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "${list[currentIndex].costTo} bonus ",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
