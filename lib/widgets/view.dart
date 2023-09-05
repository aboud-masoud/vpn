import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vpn/obj/item.dart';
import 'package:vpn/screens/game.dart';

class MyView extends StatefulWidget {
  final Item item;
  const MyView({super.key, required this.item});

  @override
  State<MyView> createState() => _MyViewState();
}

class _MyViewState extends State<MyView> {
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          List<Item> listOfIconsSelected = [];

          for (var i in listOfIcons) {
            if (i.selected) {
              listOfIconsSelected.add(i);
            }
          }

          print(listOfIconsSelected.length);

          if (listOfIconsSelected.length > 0 &&
              listOfIconsSelected.length.isEven == false) {
            print("wallaa fatat");
            for (var ss in listOfIconsSelected) {
              if (widget.item.icon == ss.icon) {
                widget.item.selected = true;
              }
            }
          } else {
            widget.item.selected = true;
          }

          if (listOfIconsSelected.length + 1 == listOfIcons.length) {
            print("sawsan");
            storage.write(key: "counter", value: "3");

            Navigator.pop(context);
          }

          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[400],
          ),
          child: widget.item.selected
              ? Center(
                  child: Icon(
                    widget.item.icon,
                    size: 50,
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}
