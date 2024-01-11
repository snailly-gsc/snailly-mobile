part of 'animations.dart';

enum AniProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  final bool isTranslate;

  const FadeAnimation({
    Key? key,
    this.delay = 0.5,
    this.isTranslate = false,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final tween = MultiTrackTween([
    //   Track("opacity")
    //       .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
    //   Track("translateY").add(
    //       Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
    //       curve: Curves.easeOut)
    // ]);

    var tween = TimelineTween<AniProps>()
      ..addScene(
        begin: const Duration(milliseconds: 0),
        duration: const Duration(milliseconds: 500),
      ).animate(AniProps.opacity, tween: Tween<double>(begin: 0.0, end: 1.0));

    if (isTranslate) {
      tween
          .addScene(
            begin: const Duration(milliseconds: 0),
            end: const Duration(milliseconds: 200),
          )
          .animate(
            AniProps.translateY,
            tween: Tween<double>(begin: 50.0, end: 0.0),
            curve: Curves.easeOut,
          );
    }

    return PlayAnimation<TimelineValue<AniProps>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(AniProps.opacity),
        child: Transform.translate(
          offset: (isTranslate)
              ? Offset(0, value.get(AniProps.translateY))
              : const Offset(0, 0),
          child: child,
        ),
      ),
    );
  }
}
