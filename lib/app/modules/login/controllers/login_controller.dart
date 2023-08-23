part of login_page;

class LoginController extends GetxController {
  final TextEditingController emailInput = TextEditingController();
  final TextEditingController passwordInput = TextEditingController();
  final TextEditingController password2Input = TextEditingController();
  final ValueNotifier<bool> showPassword = ValueNotifier(false);
  final _formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    emailInput.text = StorageService.to.getString(C.localAccount);
  }

  @override
  void onClose() {
    emailInput.dispose();
    passwordInput.dispose();
    password2Input.dispose();
    super.onClose();
  }

  void onShowPassword() => showPassword.value = !showPassword.value;

  Future<bool> onLogin() async {
    if (_formKey.currentState?.validate() != true) return false;
    SmartDialog.showLoading();
    await UserStore.to.setAccount(emailInput.value.text);
    await Future.delayed(const Duration(seconds: 1));
    SmartDialog.dismiss();
    return true;
  }
}
