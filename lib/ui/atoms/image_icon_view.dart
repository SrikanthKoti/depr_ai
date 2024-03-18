import 'package:cached_network_image/cached_network_image.dart';
import 'package:depr_ai/app/utils.dart';
import 'package:depr_ai/helper.dart';
import 'package:depr_ai/ui/atoms/shimmer_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageIconView extends StatelessWidget {
  final String? assetPath;
  final String? networkPath;
  final String? fallbackImage;
  final double? dScale;
  final double? dHeight;
  final double? dWidth;
  final Color? iconColor;
  final BoxFit fit;
  final double dBorderRadius;
  final bool showPlaceHolder;

  const ImageIconView({
    Key? key,
    this.assetPath,
    this.dScale,
    this.iconColor,
    this.dWidth,
    this.dHeight,
    this.networkPath,
    this.fallbackImage,
    this.dBorderRadius = 0,
    this.fit = BoxFit.cover,
    this.showPlaceHolder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      value: "ICON",
      child: ClipRRect(
        borderRadius: BorderRadius.circular(dBorderRadius),
        child: assetPath != null
            ? Utils.isSvg(assetPath!)
                ? SvgPicture.asset(
                    assetPath!,
                    height: dHeight,
                    width: dWidth,
                    fit: fit,
                    colorFilter: iconColor != null ? Helper.getSVGCOlor(iconColor!) : null,
                  )
                : Image.asset(
                    assetPath ?? "",
                    height: dHeight,
                    width: dWidth,
                    fit: fit,
                    scale: dScale,
                    color: iconColor,
                  )
            : (networkPath != null && networkPath!.isNotEmpty)
                ? Utils.isSvg(networkPath!)
                    ? SvgPicture.network(
                        networkPath!,
                        height: dHeight,
                        width: dWidth,
                        fit: fit,
                        placeholderBuilder: (context) => showPlaceHolder
                            ? ShimmerContainer(
                                width: dWidth,
                                height: dHeight ?? double.infinity,
                              )
                            : const SizedBox.shrink(),
                        colorFilter: iconColor != null ? Helper.getSVGCOlor(iconColor!) : null,
                      )
                    : CachedNetworkImage(
                        imageUrl: networkPath!,
                        color: iconColor,
                        height: dHeight,
                        width: dWidth,
                        fit: fit,
                        errorWidget: (context, url, error) {
                          return fallbackImage != null
                              ? Utils.isSvg(fallbackImage!)
                                  ? SvgPicture.asset(
                                      fallbackImage!,
                                      height: dHeight,
                                      width: dWidth,
                                      fit: fit,
                                      colorFilter:
                                          iconColor != null ? Helper.getSVGCOlor(iconColor!) : null,
                                    )
                                  : Image.asset(
                                      fallbackImage ?? "",
                                      height: dHeight,
                                      width: dWidth,
                                      fit: fit,
                                      scale: dScale,
                                      color: iconColor,
                                    )
                              : ShimmerContainer(
                                  width: dWidth,
                                  height: dHeight ?? double.infinity,
                                );
                        },
                        placeholder: (context, url) => showPlaceHolder
                            ? ShimmerContainer(
                                width: dWidth,
                                height: dHeight ?? double.maxFinite,
                              )
                            : const SizedBox.shrink(),
                      )
                : Container(),
      ),
    );
  }
}
