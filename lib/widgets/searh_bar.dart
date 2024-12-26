import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie_app/View_Model/providers/media_provider.dart';

class MediaSearchBar extends StatefulWidget {
  const MediaSearchBar({
    super.key,
    required this.controller,
    required this.mediaProvider,
  });

  final TextEditingController controller;
  final MediaProvider mediaProvider;

  @override
  State<MediaSearchBar> createState() => _MediaSearchBarState();
}

class _MediaSearchBarState extends State<MediaSearchBar> {
  Timer? _debounce;

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.mediaProvider.fetchSearchMedia(value);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          onTapOutside: ((event) {
            FocusScope.of(context).unfocus();
          }),
          onChanged: _onSearchChanged,
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: "Search Movies or TV Shows",
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            suffixIcon: widget.controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.white),
                    onPressed: () {
                      widget.controller.clear();
                      widget.mediaProvider.clearSearch();
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
