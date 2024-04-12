import 'package:flutter/material.dart';
import 'package:flutter_sp_social/core/utils/layout_util.dart';

import 'event_store.dart';
import 'home_view/home_page_factory.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _store = EventStore();

  @override
  void initState() {
    super.initState();

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
                actions: [
                  if (!LayoutUtil.isMobileLayout(context))
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'sorteio');
                        },
                        child: const Text(
                          'Sorteio',
                        ),
                      ),
                    ),
                ],
                centerTitle: true,
                backgroundColor: _store.value!.color != null
                    ? Color(int.parse(_store.value!.color!, radix: 16))
                    : Theme.of(context).colorScheme.primary,
              ),
              backgroundColor: Theme.of(context).colorScheme.background,
              body: HomePageViewFactory.build(context, _store));
        });
  }
}
