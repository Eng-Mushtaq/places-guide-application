class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Easiest Way",
    image: "assets/images/image1.png",
    desc: "Easiest Way to search places in the city",
  ),
  OnboardingContents(
    title: "Detailed Information",
    image: "assets/images/img.png",
    desc:
        "Find out the facility information in detail supported with images and reviews.",
  ),
  OnboardingContents(
    title: "Search Near You",
    image: "assets/images/image3.jpg",
    desc:
        "Search what you want and find out what is closest to you by displaying it on the map.",
  ),
];
