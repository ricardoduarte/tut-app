import 'dart:async';

import 'package:tut/domain/model.dart';
import 'package:tut/presentation/base/base_view_model.dart';
import 'package:tut/presentation/resources/assets_manager.dart';
import 'package:tut/presentation/resources/strings_manager.dart';

class OnboardingViewModel extends BaseViewModel
    with OnboardingViewModelInputs, OnboardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    // Send slider data to view
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length) {
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex = _list.length - 1; // infinite loop to go to end of slider
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubtitle1, ImageAssets.onboardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubtitle2, ImageAssets.onboardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubtitle3, ImageAssets.onboardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4,
            AppStrings.onBoardingSubtitle4, ImageAssets.onboardingLogo4),
      ];

  _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

abstract class OnboardingViewModelInputs {
  void goNext();
  void goPrevious();
  void onPageChanged(int index);

  Sink get inputSliderViewObject;
}

abstract class OnboardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
