import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/social_qr_code.dart';
import '../event_store.dart';

class MobileView extends StatelessWidget {
  final EventStore store;

  const MobileView({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: store.value!.socialQrCodes.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) => ListTileWidget(socialQrCode: store.value!.socialQrCodes[index]),
    );
  }
}

class ListTileWidget extends StatelessWidget {
  final SocialQrCode socialQrCode;
  const ListTileWidget({super.key, required this.socialQrCode});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    Widget icon = socialQrCode.icon != null
        ? Image.network(socialQrCode.icon!, fit: BoxFit.fitWidth, width: 48, height: 48)
        : Image.asset('images/dash.png', width: 48, height: 48, fit: BoxFit.fitWidth);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launch(socialQrCode.qrCode),
        child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: theme.colorScheme.primary),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                icon,
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(socialQrCode.title, style: textTheme.headlineSmall),
                      Text(socialQrCode.qrCode, style: textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Future<void> launch(String url, {bool isNewTab = true}) async {
    await launchUrl(
      Uri.parse(url),
      webOnlyWindowName: isNewTab ? '_blank' : '_self',
    );
  }
}
