import 'package:flutter/material.dart';

class AddressField extends StatefulWidget {
  
  final TextEditingController controller;
  final List<String> suggestions;

  const AddressField({
    super.key,
    
    required this.controller,
    required this.suggestions,
  });

  @override
  State<AddressField> createState() => _AddressFieldState();
}

class _AddressFieldState extends State<AddressField> {
  late List<String> _filtered;

  @override
  void initState() {
    super.initState();
    _filtered = widget.suggestions;
    widget.controller.addListener(_filter);
  }

  void _filter() {
    final input = widget.controller.text.toLowerCase();
    if (input.isEmpty) {
      setState(() => _filtered = widget.suggestions);
    } else {
      setState(() {
        _filtered = widget.suggestions
            .where((s) => s.toLowerCase().contains(input))
            .toList();
      });
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_filter);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        TextField(
          controller: widget.controller,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        if (_filtered.isNotEmpty && widget.controller.text.isNotEmpty)
          Container(
            constraints: const BoxConstraints(maxHeight: 150),
            child: ListView(
              children: _filtered.map((addr) {
                return ListTile(
                  title: Text(addr),
                  onTap: () {
                    widget.controller.text = addr;
                    widget.controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: addr.length),
                    );
                    setState(() {
                      _filtered = [];
                    });
                  },
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
