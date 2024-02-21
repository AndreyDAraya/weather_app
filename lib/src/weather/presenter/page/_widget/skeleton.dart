part of '../page.dart';

/// Widget for displaying a skeleton placeholder.
class SkeletonWidget extends StatelessWidget {
  const SkeletonWidget({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.black12,
          highlightColor: Colors.white10,
          child: Container(
            padding: const EdgeInsets.all(DsSpace.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DsVerticalSpace.xxl,
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(DsSpace.lg)),
                ),
                DsVerticalSpace.xxl,
                Container(
                  width: 250,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(DsSpace.sm),
                  ),
                ),
                DsVerticalSpace.xs,
                Container(
                  width: 110,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(DsSpace.sm),
                  ),
                ),
                DsVerticalSpace.xxl,
                Container(
                  width: 175,
                  height: 175,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(DsSpace.sm),
                  ),
                ),
                DsVerticalSpace.xxl,
                Container(
                  width: 200,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(DsSpace.sm),
                  ),
                ),
                DsVerticalSpace.md,
                Container(
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(DsSpace.sm),
                  ),
                ),
                DsVerticalSpace.xxl,
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(DsSpace.lg),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: DsSpace.ml,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
      ],
    );
  }
}
