abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs {
  // shared variables and functions used by view models
}

abstract class BaseViewModelInputs {
  // called when the view model is initialized
  void start();

  // called when the view model dies
  void dispose();
}

abstract class BaseViewModelOutputs {

}
