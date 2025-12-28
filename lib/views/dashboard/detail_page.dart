import 'dart:ui';
import 'package:dicoding_project2/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailPage extends StatefulWidget {
  final Movie movie;

  const DetailPage({super.key, required this.movie});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: true,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  // Background Blur
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: ClipRRect(
                      child: Transform.scale(
                        scale: 1.1,
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Image.network(
                            widget.movie.image,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Column(
                    children: [
                      SizedBox(height: 80),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            // Poster
                            SizedBox(
                              height: 150,
                              width: 110,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  widget.movie.image,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),

                            // Movie Info
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Movie Title
                                  Text(
                                    widget.movie.title,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.w900),
                                  ),

                                  // Movie Details
                                  SizedBox(height: 5),
                                  Table(
                                    columnWidths: {
                                      0: FixedColumnWidth(80),
                                      1: FlexColumnWidth(),
                                    },
                                    children: [
                                      // Genre
                                      _buildTableRow(
                                        'Genre',
                                        widget.movie.genre,
                                      ),
                                      _buildTableRow(
                                        'Durasi',
                                        widget.movie.duration,
                                      ),
                                      _buildTableRow(
                                        'Sutradara',
                                        widget.movie.director,
                                      ),
                                      _buildTableRow(
                                        'Rating Usia',
                                        widget.movie.usia,
                                      ),
                                    ],
                                  ),

                                  // Rating
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      RatingBarIndicator(
                                        rating: widget.movie.rating,
                                        itemBuilder: (context, index) =>
                                            const Icon(
                                              Icons.star_rounded,
                                              color: Color(0xFFFFBF65),
                                            ),
                                        itemCount: 5,
                                        itemSize: 25,
                                        direction: Axis.horizontal,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        '${widget.movie.rating}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: Theme.of(context).colorScheme.primary,
                                              fontWeight: FontWeight.w900,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ), // SliverAppBar(
            //   backgroundColor: Theme.of(context).colorScheme.primary,
            //   surfaceTintColor: Colors.transparent,
            //   pinned: true,
            //   title: Text(widget.movie.title),
            // ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
