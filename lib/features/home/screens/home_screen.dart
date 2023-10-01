import 'package:earthquake/common/build_loading_animation.dart';
import 'package:earthquake/common/build_title.dart';
import 'package:earthquake/constants/sizes.dart';
import 'package:earthquake/features/home/services/home_provider.dart';
import 'package:earthquake/features/home/widgets/build_scroll_up_button.dart';
import 'package:earthquake/features/home/widgets/custom_appbar.dart';
import 'package:earthquake/features/home/widgets/google_maps.dart';
import 'package:earthquake/features/home/widgets/recent_card.dart';
import 'package:earthquake/models/latest_earthquake.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool _showBackToTopButton = false;

  late ScrollController _scrollController;

  int _selectedDays = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context
          .read<HomeProvider>()
          .getEarthQuakes(context: context, days: _selectedDays);
    });
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 100) {
            _showBackToTopButton = true;
          } else {
            _showBackToTopButton = false;
          }
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(microseconds: 10), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    final homeprovider = context.watch<HomeProvider>();
    final loading = context.watch<HomeProvider>().isLoading;

    return Scaffold(
      floatingActionButton: _showBackToTopButton == false
          ? null
          : ScrollUpButton(
              callback: _scrollToTop,
            ),
      appBar: const CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          _selectedDays = 1;
          await context
              .read<HomeProvider>()
              .getEarthQuakes(context: context, days: _selectedDays);
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GoogleMapsWidget(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: sh * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BuildTitle(title: 'زلازل حدثت مؤخراً'),
                        DropdownButton<int>(
                          value: _selectedDays,
                          items: List.generate(7, (index) {
                            final days = index + 1;
                            return DropdownMenuItem<int>(
                              value: days,
                              child: Text(' عدد الأيام: $days'),
                            );
                          }),
                          onChanged: (value) {
                            setState(() {
                              _selectedDays = value!;
                            });
                            context.read<HomeProvider>().getEarthQuakes(
                                  context: context,
                                  days: _selectedDays,
                                );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: sh * 0.01,
                    ),
                    loading
                        ? const LoadingWidget()
                        : ListView.separated(
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: sh * 0.03,
                              );
                            },
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: homeprovider.earthquakesList.length,
                            itemBuilder: (BuildContext context, int index) {
                              LatestEarthquake l =
                                  homeprovider.earthquakesList[index];
                              final formattedDate =
                                  DateFormat('yyyy-MM-dd').format(l.time);
                              return RecentCard(
                                days: l.time,
                                place: l.place,
                                depth: l.depth.toString(),
                                mag: l.magnitude.toString(),
                                time: formattedDate,
                                lat: l.latitude.toString(),
                                long: l.longitude.toString(),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
