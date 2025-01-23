import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemCard extends StatelessWidget {

  final void Function()? onTap;
  final DateTime dateTime;
  final String title;
  final String? subTitle;
  final String trailingText;

  ItemCard({
    super.key,
    required this.dateTime,
    this.onTap,
    required this.title,
    this.subTitle,
    required this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 90,
                height: subTitle != null ? 80 : 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    topLeft: Radius.circular(8),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: SizedBox(
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dateTime.day.toString(),
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleLarge?.fontSize,
                          color: Colors.white),
                    ),
                    Text(
                      DateFormat("MMMM").format(dateTime),
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              subtitle: subTitle != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        subTitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : null,
              trailing: Text(
                trailingText,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
