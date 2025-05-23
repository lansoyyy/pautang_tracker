import 'package:flutter/material.dart';
import 'package:pautang_tracker/utils/colors.dart';
import 'package:pautang_tracker/widgets/text_widget.dart';

import '../../../widgets/drawer_widget.dart';

class AboutusTab extends StatelessWidget {
  String id;

  AboutusTab({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(
        id: id,
      ),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primary,
        title: TextWidget(
          text: 'About Us',
          fontSize: 18,
          fontFamily: 'Bold',
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              Center(
                child: Image.asset(
                  'assets/images/avlogo.png',
                  height: 75,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextWidget(text: 'Who we are', fontSize: 24, color: black),
              const SizedBox(
                height: 10,
              ),
              TextWidget(
                  maxLines: 50,
                  text:
                      'We are a team of passionate student innovators based in Province of Misamis Oriental, Philippines. Our mission is to provide top-notch software solutions to businesses and individuals who are seeking to streamline their processes and enhance their digital presence.\n\nWe believe that technology has the power to transform the world, and we are committed to creating innovative and user-friendly products that deliver value to our clients. Our team is composed of talented individuals with diverse backgrounds and skill sets, who are united by our shared passion for technology and innovation.\n\nAs a startup, we are agile and constantly evolving, always seeking to improve and stay ahead of the curve. We pride ourselves on our ability to listen to our clients needs and create customized solutions that meet their unique requirements.\n\nThank you for considering us as your partner in digital transformation. We look forward to helping you achieve your goals through the power of technology.',
                  fontSize: 14,
                  color: grey),
              const SizedBox(
                height: 50,
              ),
              TextWidget(text: 'What we do', fontSize: 24, color: black),
              const SizedBox(
                height: 10,
              ),
              TextWidget(
                  maxLines: 50,
                  text:
                      'We specialize in providing innovative software solutions that empower businesses and individuals to thrive in the digital age. Our team of talented developers and designers work together to create custom software applications that are tailored to our clients unique needs and goals.\n\nWe offer a wide range of services, including but not limited to:\n\nSoftware development: We build software applications from scratch, using the latest tools and technologies to create scalable, secure, and user-friendly solutions.\n\nWeb development: We design and develop websites that are responsive, visually appealing, and optimized for search engines.\n\nMobile app development: We create native and hybrid mobile applications for iOS and Android, with a focus on delivering a seamless user experience.\n\nE-commerce solutions: We help businesses establish and grow their online presence by developing e-commerce platforms that are secure, efficient, and user-friendly.\n\nUI/UX design: We create intuitive and visually stunning user interfaces that enhance the overall user experience and drive engagement.\n\nWe are committed to delivering high-quality software solutions that meet our clients needs and exceed their expectations. We work closely with our clients throughout the development process to ensure that our solutions are aligned with their goals and objectives.\n\nContact us today to learn more about how we can help you leverage the power of technology to achieve your business goals.',
                  fontSize: 14,
                  color: grey),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
