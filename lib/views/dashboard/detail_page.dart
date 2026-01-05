import 'dart:ui';
import 'package:dicoding_project2/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

class DetailPage extends StatelessWidget {
  final Movie movie;
  final ValueNotifier<bool> _isAppbarCollapsing = ValueNotifier(false);

  DetailPage({super.key, required this.movie});

  final List<Map<String, dynamic>> _dummyDates = [
    {'date': '29 Des', 'day': 'HARI INI'},
    {'date': '30 Des', 'day': 'SENIN'},
    {'date': '31 Des', 'day': 'SELASA'},
    {'date': '01 Jan', 'day': 'RABU'},
    {'date': '02 Jan', 'day': 'KAMIS'},
  ];

  final List<Map<String, dynamic>> dummyCinemas = [
    {
      'name': 'Level 21 XXI',
      'type': 'Dolby Atmos',
      'price': 'Rp 60.000',
      'times': ['12:00', '14:20', '16:40', '19:00', '21:20'],
    },
    {
      'name': 'Beachwalk XXI',
      'type': 'The Premiere',
      'price': 'Rp 100.000',
      'times': ['13:00', '15:30', '18:00', '20:30'],
    },
    {
      'name': 'Galeria XXI',
      'type': 'Regular 2D',
      'price': 'Rp 45.000',
      'times': ['12:15', '14:45', '17:15', '20:15'],
    },
    {
      'name': 'Park 23 XXI',
      'type': 'Regular 2D',
      'price': 'Rp 40.000',
      'times': ['12:00', '14:10', '16:20', '18:30'],
    },
    {
      'name': 'Trans Studio Mall XXI',
      'type': 'IMAX',
      'price': 'Rp 75.000',
      'times': ['13:15', '15:45', '18:15', '20:45'],
    },
    {
      'name': 'Cinepolis Plaza Renon',
      'type': 'Regular',
      'price': 'Rp 45.000',
      'times': ['12:30', '15:00', '17:30', '20:00'],
    },
    {
      'name': 'Cinepolis Lippo Mall Kuta',
      'type': 'Macro XE',
      'price': 'Rp 65.000',
      'times': ['13:00', '15:30', '18:00', '21:00'],
    },
    {
      'name': 'Cinepolis Sidewalk Jimbaran',
      'type': 'Regular',
      'price': 'Rp 40.000',
      'times': ['12:45', '15:15', '17:45', '20:15'],
    },
    {
      'name': 'Denpasar Cineplex',
      'type': 'Executive',
      'price': 'Rp 35.000',
      'times': ['12:00', '14:00', '16:00', '18:00', '20:00'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification) {
                if (notification.metrics.pixels > 150 &&
                    !_isAppbarCollapsing.value) {
                  _isAppbarCollapsing.value = true;
                } else if (notification.metrics.pixels <= 150 &&
                    _isAppbarCollapsing.value) {
                  _isAppbarCollapsing.value = false;
                }
              }
              return false;
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      // Background Blur
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: ClipRRect(
                          child: Transform.scale(
                            scale: 1.1,
                            child: ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                sigmaX: 8,
                                sigmaY: 8,
                              ),
                              child: Image.network(
                                movie.image,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Column(
                        children: [
                          const SizedBox(height: 90),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.all(20),
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
                                      movie.image,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),

                                // Movie Info
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w900,
                                            ),
                                      ),
                                      const SizedBox(height: 5),
                                      Table(
                                        columnWidths: const {
                                          0: FixedColumnWidth(80),
                                          1: FlexColumnWidth(),
                                        },
                                        children: [
                                          _buildTableRow('Genre', movie.genre),
                                          _buildTableRow(
                                            'Durasi',
                                            movie.duration,
                                          ),
                                          _buildTableRow(
                                            'Sutradara',
                                            movie.director,
                                          ),
                                          _buildTableRow(
                                            'Rating Usia',
                                            movie.usia,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          RatingBarIndicator(
                                            rating: movie.rating,
                                            itemBuilder: (context, index) =>
                                                const Icon(
                                                  Icons.star_rounded,
                                                  color: Color(0xFFFFBF65),
                                                ),
                                            itemCount: 5,
                                            itemSize: 20,
                                            direction: Axis.horizontal,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            '${movie.rating}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  color: primaryColor,
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

                  // Sysnopsis Title
                  const SizedBox(height: 20),
                  Padding(
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

                        const SizedBox(height: 5),
                        ReadMoreText(
                          movie.synopsis,
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

                  // Jadwal Title
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text(
                      'Jadwal',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),

                  if (movie.rating == 0.0) ...[
                    Container(
                      height: 150,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.event_busy_rounded,
                            size: 40,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Mohon maaf, jadwal penayangan untuk film ini belum tersedia. Nantikan segera di bioskop kesayangan Anda!",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: _dummyDates.length,
                        itemBuilder: (context, index) {
                          final dates = _dummyDates[index];
                          bool isSelected = index == 0;

                          return Container(
                            margin: const EdgeInsets.only(right: 8),
                            // height: 30,
                            // width: 30,
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                height: 35,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: isSelected
                                      ? primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                    width: 1,
                                    color: isSelected
                                        ? primaryColor
                                        : Colors.grey,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      dates['date'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w900,
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.grey,
                                          ),
                                    ),
                                    Text(
                                      dates['day'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
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
                          );
                        },
                      ),
                    ),

                    // Cinemas Info
                    const SizedBox(height: 20),
                    Column(
                      children: dummyCinemas.map((cinema) {
                        List<String> times = cinema['times'];
                        return Column(
                          children: [
                            Divider(color: Colors.grey.shade300, height: 1),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cinema['name'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              cinema['type'],
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        cinema['price'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: times.map((t) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          t,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
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
                      }).toList(),
                    ),
                  ],

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),

          // Appbar
          ValueListenableBuilder<bool>(
            valueListenable: _isAppbarCollapsing,
            builder: (context, isCollapsing, child) {
              return Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: kToolbarHeight + MediaQuery.of(context).padding.top,
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                  ),
                  color: isCollapsing ? primaryColor : Colors.transparent,
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 16),
                        decoration: BoxDecoration(
                          color: isCollapsing
                              ? Colors.transparent
                              : Colors.black45,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Expanded(
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: isCollapsing ? 1.0 : 0.0,
                          child: Text(
                            movie.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 56),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w900,
              fontSize: 12,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
