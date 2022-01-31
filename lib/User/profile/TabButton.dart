import 'package:flutter/material.dart';
import 'package:hostel_booking/User/profile/palette.dart';

class TabButton extends StatelessWidget {
  const TabButton({
    this.label,
    this.icon,
    this.page,
    this.color,
    this.weight = FontWeight.bold,
  });

  final IconData? icon;
  final String? label;
  final VoidCallback? page;
  final Color? color;
  final FontWeight? weight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white70,
      ),
      child: GestureDetector(
        onTap: page,
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  margin: EdgeInsets.fromLTRB(5.0, 7.0, 5.0, 7.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label!,
                            style: TextStyle(
                              fontWeight: weight,
                              fontSize: 25.0,
                              color: color,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 3, 0),
                        width: 50.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              icon,
                              size: 25.0,
                              color: kcardIconFaded,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback? onTap;
  const ListButton({Key? key, this.label, this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white70,
      ),
      child: ListTile(
        // tileColor: Colors.white,
        // selectedTileColor: Colors.black,
        title: Text(
          "$label",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        leading: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }
}
