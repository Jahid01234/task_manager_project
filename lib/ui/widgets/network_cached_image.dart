import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NetworkCachedImage extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const NetworkCachedImage({
    super.key,
    required this.url,
    this.height,
    this.width,
    this.fit,
  });

  bool _isValidUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null && uri.hasScheme && uri.hasAuthority;
  }

  @override
  Widget build(BuildContext context) {

    if (!_isValidUrl(url)) {
      return const Icon(Icons.error_outline);
    }

    return CachedNetworkImage(
        imageUrl: url,
        progressIndicatorBuilder: (context, url, downloadProgress){
          return const CircularProgressIndicator();
        },
        errorWidget: (context, url, error){
          return const Icon(Icons.error_outline);
        },
    );
  }
}
