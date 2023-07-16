import 'package:flutter/material.dart';
import 'package:cathnow/widgets/my_appbar.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: MyAppBar(title: "Privacy Policy"),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'At White Acre Software, we respect your privacy and are committed to protecting your personal data. This Privacy Policy explains how we collect, use, and disclose your personal data.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'What personal data do we collect?',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'We may collect the following types of personal data:',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        '- Contact information (such as your name, email address, and phone number)'),
                    Text(
                        '- Demographic information (such as your age, gender, and location)'),
                    Text(
                        '- Usage information (such as your IP address, browser type, and device information)'),
                    Text(
                        '- Other information you choose to provide to us (such as feedback or comments)'),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'How do we use your personal data?',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'We use your personal data to:',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('- Provide and improve our services to you'),
                    Text(
                        '- Communicate with you about our products and services'),
                    Text('- Respond to your requests and inquiries'),
                    Text(
                        '- Conduct research and analyze data to improve our products and services'),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'We will not share your personal data with anyone, except as required by law enforcement or other governmental authorities. We may also disclose your personal data to our trusted service providers who need to access your data to provide services to us, such as hosting providers, payment processors, or customer support providers.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'We will retain your personal data for as long as necessary to fulfill the purposes for which it was collected, unless a longer retention period is required by law.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Your Rights',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'You have the right to access, correct, or delete your personal data. You may also object to or restrict the processing of your personal data, or request that we provide a copy of your personal data to you or to a third party. To exercise these rights, please contact us using the contact information provided below.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 32.0),
              Text(
                'Security',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'We take appropriate measures to protect your personal data from unauthorized access, alteration, disclosure, or destruction. However, no security measures are perfect or impenetrable, and we cannot guarantee the security of your personal data.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 32.0),
              Text(
                'Updates to this Privacy Policy',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 32.0),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'If you have any questions or concerns about this Privacy Policy or our privacy practices, please contact us at privacy@whiteacresoftware.com.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ));
  }
}
