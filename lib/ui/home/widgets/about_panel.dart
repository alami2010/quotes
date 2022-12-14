import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:quotez/theme/app_dimens.dart';
import 'package:quotez/ui/home/widgets/panel_widgets/panel_divider.dart';
import 'package:quotez/ui/home/widgets/panel_widgets/panel_header.dart';
import 'package:quotez/ui/home/widgets/panel_widgets/panel_list_tile.dart';
import 'package:quotez/utils/constants.dart';
import 'package:quotez/utils/email_util.dart';
import 'package:quotez/utils/ui_strings.dart';
import 'package:quotez/utils/url_util.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

/// [AboutPanel] displays information about the app and extra communication.
class AboutPanel extends StatefulWidget {
  final ScrollController? scrollController;
  final PanelController? panelController;
  final Function? loadQuotes;

  const AboutPanel({
    this.scrollController,
    this.panelController,
    this.loadQuotes,
    Key? key,
  }) : super(key: key);

  @override
  State<AboutPanel> createState() => _AboutPanelState();
}

class _AboutPanelState extends State<AboutPanel> {
  PackageInfo? appInfo;

  Future<PackageInfo> initPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return packageInfo;
  }

  @override
  Widget build(BuildContext context) {
    List<String> mentor = [
      "All Quotes",
      "Annamalai Swami",
      "Robert Adams",
      "Jac O'Keeffe",
      "Ramana Maharshi",
      "Nisargadatta Maharaj",
      "Sri Muruganar",
      "Papaji",
      "Jalaluddin Rumi",
      "Love Quotes",
      "For the Dying"
    ];

    initPackageInfo().then((packageInfo) {
      setState(() {
        appInfo = packageInfo;
      });
    });

    return SingleChildScrollView(
      controller: widget.scrollController,
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              const PanelHeader(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          top: AppDimens.paddingL,
                          bottom: AppDimens.paddingM,
                        ),
                        child: CircleAvatar(
                          radius: 70,
                          foregroundImage: AssetImage(
                            Constants.appIcon,
                          ),
                        ),
                      ),
                      Text(
                        UiStrings.appName,
                        style: Theme.of(context).primaryTextTheme.bodyText2,
                      ),
                      /*         Text(
                        'v${appInfo?.version}',
                        style: Theme.of(context).primaryTextTheme.bodyText2,
                      ),*/
                      const SizedBox(height: AppDimens.sizeUnitM),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const PanelDivider(),
                      ...mentor.map((element) {
                        return PanelListTile(
                          title: element,
                          tileIcon: const Icon(Icons.person),
                          onTap: () async =>
                              widget.loadQuotes?.call(getFileName(element)),
                        );
                      }),
                      const PanelDivider(),
                      PanelListTile(
                        title: UiStrings.writeMeAnEmail,
                        tileIcon: const Icon(Icons.mail_outline),
                        onTap: () => EmailUtil.sendEmail(context),
                      ),
                      const PanelDivider(),
                      PanelListTile(
                        title: UiStrings.rateTheApp,
                        tileIcon: const Icon(Icons.rate_review_outlined),
                        onTap: () {
                          // Didn't use [Platform], because this approach is easier mock in tests
                          Theme.of(context).platform == TargetPlatform.android
                              ? UrlUtil.openUrl(Constants.playStoreUrl)
                              : null;
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getFileName(String element) {
    return element.replaceAll(RegExp("[^A-Za-z0-f9]"), "");
  }
}
