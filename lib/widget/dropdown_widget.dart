import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    super.key,
    required this.selectedDrop,
    required this.dropdownList,
    required this.onChanged,
    required this.hintText,

  });

  final String? selectedDrop;
  final List<String> dropdownList;
  final ValueChanged<String?> onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: Colors.black, width: 1)
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          style: TextStyle(fontSize: 15, color: Colors.black),
          isExpanded: true,
          value: selectedDrop,
          hint: Text(hintText),
          items: dropdownList.map((String type) {
            return DropdownMenuItem<String>(value: type, child: Text(type));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}



 // GestureDetector(
                //   onTap: () {
                //     showCupertinoModalPopup(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return CupertinoActionSheet(
                //           title: Text("Select Category"),
                //           actions: categoryDropdown.map((category) {
                //             return CupertinoActionSheetAction(
                //               child: Text(category),
                //               onPressed: () {
                //                 setState(() {
                //                   selectedDrop = category;
                //                 });
                //                 Navigator.pop(context);
                //               },
                //             );
                //           }).toList(),
                //           cancelButton: CupertinoActionSheetAction(
                //             child: Text("Cancel"),
                //             onPressed: () {
                //               Navigator.pop(context);
                //             },
                //           ),
                //         );
                //       },
                //     );
                //   },
                //   child: Container(
                //     height: 35,
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       color: const Color(0xFFDCDBDB),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: Center(
                //       child: Text(
                //         selectedDrop ?? "Select Category",
                //         style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: 15,
                //           color: Colors.blue,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),




