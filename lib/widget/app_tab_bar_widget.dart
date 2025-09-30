import 'package:flutter/material.dart';

class ReuseableTabs extends StatelessWidget {
  const ReuseableTabs({
    super.key,
    required this.tabs,
    required this.activeColor,
    required this.selectedTab,
    required this.onSelectedTab,
    required this.inactiveColor,
  });

  final int selectedTab;
  final List<String> tabs;
  final Color activeColor;
  final Color inactiveColor;
  final Function(int) onSelectedTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey[300],
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(tabs.length, (index) {
            bool isSelected = selectedTab == index;
            return Expanded(
              child: GestureDetector(
                onTap: () => onSelectedTab(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? activeColor : inactiveColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
