import 'package:flutter/material.dart';

class DealOfImages extends StatefulWidget {
  const DealOfImages({Key? key}) : super(key: key);

  @override
  State<DealOfImages> createState() => _DealOfImagesState();
}

class _DealOfImagesState extends State<DealOfImages> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10, top: 15),
          alignment: Alignment.topLeft,
          child: Text("Deal Of Images"),
        ),
        Image.network(
          "https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg",
          height: 232,
          fit: BoxFit.fitHeight,
        ),
        Container(
          padding: const EdgeInsets.only(left: 15),
          alignment: Alignment.topLeft,
          child: const Text(
            '\$100',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding:
          const EdgeInsets.only(left: 15, top: 5, right: 40),
          child: const Text(
            'Yusuf',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
