import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tut/domain/model.dart';
import 'package:tut/presentation/onboarding/onboarding_view_model.dart';
import 'package:tut/presentation/resources/assets_manager.dart';
import 'package:tut/presentation/resources/color_manager.dart';
import 'package:tut/presentation/resources/routes_manager.dart';
import 'package:tut/presentation/resources/strings_manager.dart';
import 'package:tut/presentation/resources/values_manager.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController(initialPage: 0);
  final OnboardingViewModel _viewModel = OnboardingViewModel();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        return _buildContentWidget(snapshot.data);
      },
    );
    // return _buildContentWidget();
  }

  Widget _buildContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    }
    else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          elevation: AppSize.s0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: sliderViewObject.numOfSlides,
          onPageChanged: (index) {
            _viewModel.onPageChanged(index);
          },
          itemBuilder: (context, index) {
            return OnBoardingPage(sliderViewObject.sliderObject);
          },
        ),
        bottomSheet: Container(
          color: ColorManager.white,
          height: AppSize.s100,
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.loginRoute);
                    },
                    child: Text(
                      AppStrings.skip,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  )),
              _buildBottomSheetWidget(sliderViewObject),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
                child: SizedBox(
                  height: AppSize.s20,
                  width: AppSize.s20,
                  child: SvgPicture.asset(ImageAssets.leftArrowIcon),
                ),
                onTap: () {
                  _pageController.animateToPage(
                    _viewModel.goPrevious(),
                    duration:
                        const Duration(milliseconds: DurationConstants.d300),
                    curve: Curves.bounceInOut,
                  );
                }),
          ),
    
          // Circles indicator
          Row(
            children: [
              for (int i = 0; i < sliderViewObject.numOfSlides; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i, sliderViewObject.currentIndex),
                )
            ],
          ),
    
          // Right arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
                child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: SvgPicture.asset(ImageAssets.rightArrowIcon),
            ),
            onTap: () {
              _pageController.animateToPage(
                _viewModel.goNext(),
                duration:
                    const Duration(milliseconds: DurationConstants.d300),
                curve: Curves.bounceInOut,
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int _currentIndex) {
    if (index == _currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIcon);
    } else {
      return SvgPicture.asset(ImageAssets.solidCircleIcon);
    }
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s40),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: AppSize.s60),
        SvgPicture.asset(_sliderObject.image)
      ],
    );
  }
}
