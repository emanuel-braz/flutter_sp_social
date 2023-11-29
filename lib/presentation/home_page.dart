import 'package:flutter/material.dart';
import 'package:flutter_sp_social/data/social_qr_code.dart';
import 'package:flutter_sp_social/presentation/event_store.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

const _defaultQrIcon = AssetImage('images/dash.png');

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _store = EventStore();

  late final double _cardMaxWidth;

  @override
  void initState() {
    super.initState();

    final params = Uri.base.queryParameters;
    _cardMaxWidth = double.tryParse(params['width'] ?? '') ?? 300.0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _store.loadEventData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: _store,
        builder: (context, child) {
          if (_store.value == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(
                _store.value!.eventName,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.background,
                    ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                semanticsLabel: _store.value!.eventName,
              ),
              centerTitle: true,
              backgroundColor: _store.value!.color != null
                  ? Color(int.parse(_store.value!.color!, radix: 16))
                  : Theme.of(context).colorScheme.primary,
            ),
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 16),
                child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: _store.value!.socialQrCodes
                        .map((e) =>
                            _QRCode(socialQrCode: e, width: _cardMaxWidth))
                        .toList()),
              ),
            ),
          );
        });
  }
}

class _QRCode extends StatelessWidget {
  final SocialQrCode socialQrCode;
  final double width;

  const _QRCode({required this.socialQrCode, required this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            barrierColor: Colors.black.withOpacity(0.98),
            builder: (_) => AlertDialog(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  content: SizedBox(
                    width: MediaQuery.sizeOf(context).height * 0.7,
                    child: AbsorbPointer(absorbing: true, child: this),
                  ),
                ));
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: width),
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: PrettyQrView(
                  qrImage: QrImage(
                    QrCode.fromData(
                      data: socialQrCode.qrCode,
                      errorCorrectLevel: QrErrorCorrectLevel.H,
                    ),
                  ),
                  decoration: PrettyQrDecoration(
                    shape: PrettyQrSmoothSymbol(
                      color: socialQrCode.color != null
                          ? Color(int.parse(socialQrCode.color!, radix: 16))
                          : Theme.of(context).colorScheme.primary,
                      roundFactor: 0,
                    ),
                    image: PrettyQrDecorationImage(
                      image: socialQrCode.icon != null
                          ? NetworkImage(socialQrCode.icon!) as ImageProvider
                          : _defaultQrIcon,
                      position: PrettyQrDecorationImagePosition.embedded,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                socialQrCode.title,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.background,
                    ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                semanticsLabel: socialQrCode.title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
