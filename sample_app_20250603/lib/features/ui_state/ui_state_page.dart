import 'package:flutter/material.dart';

class UiStatePage extends StatefulWidget {
  const UiStatePage({super.key});

  @override
  State<UiStatePage> createState() => _UiStatePageState();
}

class _UiStatePageState extends State<UiStatePage> {
  List<String> _items = [];
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      // Simulate async fetch
      await Future.delayed(const Duration(seconds: 1));
      final items = List.generate(10, (i) => 'Item ${i + 1}');
      setState(() {
        _items = items;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _onTapItem(BuildContext context, String item) async {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => _buildAlertDialog(context, item),
    );
  }

  Widget _buildAlertDialog(BuildContext context, String item) {
    return AlertDialog(
      title: const Text('Item Details'),
      content: Text(item),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _UiStatePageTemplate(
      items: _items,
      loading: _loading,
      error: _error,
      onTapItem: _onTapItem,
      fetchItems: _fetchItems,
    );
  }
}

class _UiStatePageTemplate extends StatelessWidget {
  final List<String> items;
  final bool loading;
  final String? error;
  final Function(BuildContext, String) onTapItem;
  final Future<void> Function() fetchItems;

  const _UiStatePageTemplate({
    super.key,
    required this.items,
    required this.loading,
    required this.error,
    required this.onTapItem,
    required this.fetchItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UI State Page')),
      body:
          loading
              ? const Center(child: CircularProgressIndicator())
              : error != null
              ? Center(child: Text('Error: $error'))
              : items.isEmpty
              ? const Center(child: Text('No data'))
              : ListView.builder(
                itemCount: items.length,
                itemBuilder:
                    (context, index) => ListTile(
                      title: Text(items[index]),
                      onTap: () {
                        onTapItem(context, items[index]);
                      },
                    ),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchItems,
        tooltip: 'Refetch',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
