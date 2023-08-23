part of utils;

abstract class AssetsPicker {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<XFile?> image({
    required BuildContext context,
    ImageSource source = ImageSource.gallery,
    double maxWidth = 512,
    double maxHeight = 512,
  }) async {
    if (!(await Access.photos())) {
      if (context.mounted) {
        // SmartDialog.show(builder:  (_) => const LoadingDialog());
        CustomDialog.showAccess(
          context: context,
          content: const Text('Requires access to your photo gallery'),
        );
      }
      return null;
    }
    return _imagePicker.pickImage(
      source: source,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    );
  }
}
