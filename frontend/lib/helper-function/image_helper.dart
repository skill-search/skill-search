class ImageHelper {
  static String getImagePath(String serviceCategory) {
    // Define a mapping of service categories to image paths
    Map<String, String> categoryToImagePath = {
      'Event Planning': 'images/Event Planning.png',
      'Administrative Support': 'images/Administrative Support.png',
      'Design & Creative': 'images/Design & Creative.png',
      'Education & Training': 'images/Education & Training.png',
      'Engineering & Architecture': 'images/Engineering & Architecture.png',
      'Finance & Accounting': 'images/Finance & Accounting.png',
      'Handyman Services': 'images/Handyman Services.png',
      'Health & Wellness': 'images/Health & Wellness.png',
      'Legal': 'images/Legal.png',
      'Marketing': 'images/Marketing.png',
      'Programming & Tech': 'images/Programming & Tech.png',
      'Sales & Business': 'images/Sales & Business.png',
      'Writing & Translation': 'images/Writing & Translation.png',
    };

    // Use the mapping to get the image path for the given service category
    String imagePath = categoryToImagePath[serviceCategory] ?? 'images/icon-template.png';

    return imagePath;
  }
}