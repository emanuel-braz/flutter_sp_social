import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';

class CertificateValidation extends StatefulWidget {
  const CertificateValidation({super.key});

  @override
  State<CertificateValidation> createState() => _CertificateValidationState();
}

class _CertificateValidationState extends State<CertificateValidation> {
  late final String certValidation;
  final ValueKey key = const ValueKey('key_0');

  @override
  void initState() {
    super.initState();

    certValidation = '${Uri.base.origin}/static/cert_validation.html';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validação de Certificado'),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, 'home');
          },
          icon: const Icon(Icons.home),
        ),
      ),
      body: EasyWebView(
        src: certValidation,
        key: key,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
