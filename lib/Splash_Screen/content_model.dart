class UnbordingContent {
  String image;
  String title ;
  String discription;

  UnbordingContent({required this.image, required this.title,required this.discription});
}

List<UnbordingContent> contents = [
    UnbordingContent(
      title: 'We Connect People',
      image: 'assets/json/onboarding1.json',
      discription: "Connecting people trough one platform to share the memories together."
    ),
    UnbordingContent(
      title: 'Sharing happiness',
      image: 'assets/json/onboarding2.json',
      discription: "Sharing happiness by sharing your memories in chatIn platform."
    ),
    UnbordingContent(
      title: 'Last Long Memories',
      image: 'assets/json/onboarding3.json',
      discription: "You can store memories of your photos in chatIn app without limit."
    ),
];