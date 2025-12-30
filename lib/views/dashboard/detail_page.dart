import 'dart:ui';
import 'package:dicoding_project2/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

class DetailPage extends StatefulWidget {
  final Movie movie;

  const DetailPage({super.key, required this.movie});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _selectedDateIndex = 0;

  final List<Map<String, dynamic>> _dummyDates = [
    {'date': '29 Des', 'day': 'HARI INI'},
    {'date': '30 Des', 'day': 'SENIN'},
    {'date': '31 Des', 'day': 'SELASA'},
    {'date': '01 Jan', 'day': 'RABU'},
    {'date': '02 Jan', 'day': 'KAMIS'},
  ];

  final List<Map<String, dynamic>> dummyCinemas = [
    {
      'name': 'Grand Indonesia XXI',
      'type': 'Dolby Atmos',
      'price': 'Rp 50.000',
      'times': ['12:00', '14:20', '16:40', '19:00', '21:20'],
    },
    {
      'name': 'Plaza Senayan XXI',
      'type': 'IMAX',
      'price': 'Rp 75.000',
      'times': ['13:00', '15:30', '18:00', '20:30'],
    },
    {
      'name': 'CGV Pasific Place',
      'type': 'Velvet Class',
      'price': 'Rp 150.000',
      'times': ['12:15', '14:45', '17:15', '20:15'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: true,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              expandedHeight: 250,

              // Background Blur
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: ClipRRect(
                        child: Transform.scale(
                          scale: 1.1,
                          child: ImageFiltered(
                            imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w900,
                                          ),
                                    ),

                                    // Movie Details
                                    SizedBox(height: 5),
                                    Table(
                                      columnWidths: {
                                        0: FixedColumnWidth(80),
                                        1: FlexColumnWidth(),
                                      },
                                      children: [
                                        _buildTableRow('Genre', widget.movie.genre),
                                        _buildTableRow('Durasi',widget.movie.duration),
                                        _buildTableRow('Sutradara',widget.movie.director),
                                        _buildTableRow('Rating Usia',widget.movie.usia),
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
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
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
              ),
              pinned: true,
              // title: Text(widget.movie.title, style: TextStyle(color: Colors.white),),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sinopsis',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 5),
                    ReadMoreText(
                      widget.movie.synopsis,
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.justify,
                      trimMode: TrimMode.Line,
                      trimLines: 2,
                      colorClickableText: Colors.grey.shade400,
                      trimCollapsedText: ' Show more',
                      trimExpandedText: ' Show less',
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  'Jadwal',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),

            SliverAppBar(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              pinned: true,
              toolbarHeight: 70,
              primary: false,
              automaticallyImplyLeading: false,
              // titleSpacing: 0,
              title: SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _dummyDates.length,
                  itemBuilder: (context, index) {
                    final dates = _dummyDates[index];
                    bool isSelected = _selectedDateIndex == index;
                    Color primary = Theme.of(context).colorScheme.primary;

                    return Container(
                      margin: EdgeInsets.only(right: 8),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedDateIndex = index;
                            });
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: isSelected ? primary : Colors.white,
                              border: Border.all(
                                width: 1,
                                color: isSelected ? primary : Colors.grey,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  dates['date'],
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w900,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.grey,
                                      ),
                                ),
                                Text(
                                  dates['day'],
                                  style: Theme.of(context).textTheme.labelLarge
                                      ?.copyWith(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.grey,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Cinema Info
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final cinema = dummyCinemas[index];
                List<String> times = cinema['times'];

                return Column(
                  children: [
                    Divider(color: Colors.grey.shade300),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cinema['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    cinema['type'],
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                cinema['price'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: times.map((time) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  time,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }, childCount: dummyCinemas.length),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 50)),
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
