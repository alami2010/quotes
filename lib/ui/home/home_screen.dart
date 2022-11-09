import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotez/bloc/home_screen/home_cubit.dart';
import 'package:quotez/theme/app_dimens.dart';
import 'package:quotez/ui/home/widgets/about_panel.dart';
import 'package:quotez/ui/home/widgets/home_content.dart';
import 'package:quotez/ui/home/widgets/home_footer.dart';
import 'package:quotez/ui/home/widgets/home_header.dart';
import 'package:quotez/ui/home/widgets/home_no_network_view.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

/// [HomeScreen] is the main screen of the app, containing most of the content.
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PanelController panelController = PanelController();

  @override
  void initState() {
    super.initState();
    loadQuotes("AllQuotes");
  }

  void loadQuotes(String mentor) {
    print(mentor);
    panelController.isAttached ? panelController.close() : null;
    BlocProvider.of<HomeCubit>(context).getRandomQuote(mentor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SlidingUpPanel(
        controller: panelController,
        maxHeight: MediaQuery.of(context).size.height *
            AppDimens.panelHeightPercentage,
        minHeight: 0,
        backdropEnabled: true,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(
            AppDimens.borderRadiusXL,
          ),
        ),
        panelBuilder: (ScrollController sc) => AboutPanel(
            scrollController: sc,
            panelController: panelController,
            loadQuotes: loadQuotes),
        body: SafeArea(
          child: Column(
            children: [
              HomeHeader(panelController: panelController),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (BuildContext context, state) {
                  print(state);
                  return state is HomeLoaded
                      ? Expanded(
                          child: Column(
                            children: [
                              Image.network(state.randomQuote?.url ?? ''),
                              HomeContent(),
                              HomeFooter(),
                            ],
                          ),
                        )
                      : const HomeNoNetworkView();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
