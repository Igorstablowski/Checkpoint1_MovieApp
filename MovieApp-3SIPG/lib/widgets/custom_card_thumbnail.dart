import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/pages/home/widgets/movie_detail_page.dart';

class CustomCardThumbnail extends StatefulWidget {
  final String imageAsset;
  final int id;

  const CustomCardThumbnail(
      {super.key, required this.imageAsset, required this.id});

  @override
  State<CustomCardThumbnail> createState() => _CustomCardThumbnailState();
}

class _CustomCardThumbnailState extends State<CustomCardThumbnail> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetailPage(
                      id: widget.id,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
          image: DecorationImage(
            image: NetworkImage(
              '$imageUrl${widget.imageAsset}',
            ),
            fit: BoxFit.cover,
          ),
        ),
        margin: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 30),
      ),
    );
  }
}
