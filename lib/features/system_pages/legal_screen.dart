import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinder_world/core/theme/app_colors.dart';
import 'package:kinder_world/core/constants/app_constants.dart';

class LegalScreen extends ConsumerWidget {
  final String type;
  
  const LegalScreen({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = _getTitle(type);
    final content = _getContent(type);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: AppConstants.fontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Text(
                  content,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Last updated
              const Center(
                child: Text(
                  'Last updated: January 2026',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTitle(String type) {
    switch (type) {
      case 'terms':
        return 'Terms of Service';
      case 'privacy':
        return 'Privacy Policy';
      case 'guide':
        return 'User Guide';
      default:
        return 'Legal Information';
    }
  }

  String _getContent(String type) {
    switch (type) {
      case 'terms':
        return '''TERMS OF SERVICE

Last Updated: January 2026

Welcome to Kinder World! These Terms of Service ("Terms") govern your use of the Kinder World mobile application ("App") and related services ("Services"). By accessing or using our App, you agree to be bound by these Terms.

1. ACCEPTANCE OF TERMS
By downloading, installing, or using the Kinder World App, you acknowledge that you have read, understood, and agree to be bound by these Terms of Service and our Privacy Policy.

2. ELIGIBILITY
The App is designed for use by children aged 5-12 under parental supervision. Parents or legal guardians must create accounts and manage their children's use of the App.

3. PARENTAL RESPONSIBILITY
Parents are responsible for:
- Monitoring their child's use of the App
- Setting appropriate screen time limits
- Reviewing content accessed by their child
- Managing privacy settings

4. USE LICENSE
We grant you a limited, non-exclusive, non-transferable license to use the App for personal, non-commercial purposes.

5. INTELLECTUAL PROPERTY
All content, features, and functionality of the App are owned by Kinder World and are protected by international copyright, trademark, and other intellectual property laws.

6. USER CONDUCT
You agree not to:
- Use the App for any unlawful purpose
- Interfere with or disrupt the App's functionality
- Attempt to gain unauthorized access to our systems
- Upload or transmit any harmful content

7. PRIVACY
We are committed to protecting children's privacy. Our data collection and use practices are described in our Privacy Policy, which is incorporated into these Terms.

8. DISCLAIMER
The App is provided "as is" without warranties of any kind. We do not guarantee that the App will be error-free or uninterrupted.

9. LIMITATION OF LIABILITY
To the maximum extent permitted by law, Kinder World shall not be liable for any indirect, incidental, special, or consequential damages.

10. CHANGES TO TERMS
We may update these Terms from time to time. Continued use of the App after changes constitutes acceptance of the updated Terms.

11. CONTACT
If you have questions about these Terms, please contact us at legal@kinderworld.app'''
      .replaceAll('\n', '\n\n');

      case 'privacy':
        return '''PRIVACY POLICY

Last Updated: January 2026

Kinder World ("we," "us," or "our") is committed to protecting the privacy of children and families who use our educational mobile application.

1. INFORMATION WE COLLECT

A. Child Information:
- Name (first name only)
- Age range
- Learning progress and achievements
- App usage patterns
- Avatar and preferences

B. Parent Information:
- Email address
- Account credentials
- Parental controls settings
- Communication preferences

C. Technical Information:
- Device identifiers
- App performance data
- Crash reports
- Usage analytics

2. HOW WE USE INFORMATION

We use collected information to:
- Provide personalized learning experiences
- Track educational progress
- Enable parental controls and monitoring
- Improve app functionality and content
- Communicate with parents about their child's progress
- Ensure app security and stability

3. DATA PROTECTION FOR CHILDREN

We comply with the Children's Online Privacy Protection Act (COPPA) and follow these principles:
- Minimal data collection
- Parental consent required
- No behavioral advertising to children
- No sharing of child personal information
- Secure data storage and transmission

4. PARENTAL CONTROLS

Parents can:
- Access and update their child's information
- Delete their child's account and data
- Modify privacy settings
- Opt out of data collection (with limited functionality)

5. DATA SHARING

We do not sell personal information. We may share data with:
- Service providers who assist in app operation
- Legal authorities when required by law
- No third parties for marketing purposes

6. DATA SECURITY

We implement appropriate technical and organizational measures to protect personal information, including:
- Encryption of data in transit and at rest
- Secure authentication
- Regular security assessments
- Limited access to personal data

7. DATA RETENTION

We retain personal information only as long as necessary to provide services or as required by law. When accounts are deleted, we securely remove associated data.

8. INTERNATIONAL TRANSFERS

We store and process data in secure facilities. When transferring data internationally, we ensure appropriate safeguards are in place.

9. YOUR RIGHTS

Depending on your location, you may have rights to:
- Access your personal information
- Correct inaccurate data
- Request deletion of your data
- Object to certain processing
- Data portability

10. CONTACT

For privacy questions or requests, contact us at privacy@kinderworld.app

11. CHANGES TO POLICY

We may update this Privacy Policy from time to time. We will notify parents of material changes.'''
      .replaceAll('\n', '\n\n');

      case 'guide':
        return '''KINDER WORLD USER GUIDE

Welcome to Kinder World - the safe, educational, and fun learning app for children aged 5-12!

GETTING STARTED

1. Download and Install
- Download Kinder World from the App Store (iOS) or Google Play Store (Android)
- Install the app on your device
- Open the app to begin setup

2. Create Parent Account
- Tap "Parent Mode" on the welcome screen
- Register with your email address
- Create a secure password
- Set up a Parent PIN for accessing controls

3. Set Up Child Profiles
- Go to Child Management in Parent Mode
- Tap "Add New Profile"
- Enter your child's name and age
- Choose an avatar
- Select interests (optional)
- Create a picture password with your child

4. Configure Settings
- Set daily screen time limits
- Choose allowed hours for app use
- Configure content filters
- Set up break reminders

PARENT MODE FEATURES

Dashboard:
- View all children's progress at a glance
- See recent activities and achievements
- Access AI insights and recommendations

Child Management:
- Add, edit, or remove child profiles
- Reset picture passwords
- Manage multiple children

Reports & Analytics:
- Track learning progress over time
- See time spent in each learning area
- Identify strengths and areas for improvement
- Generate weekly/monthly reports

Parental Controls:
- Set daily screen time limits
- Configure allowed hours
- Enable break reminders
- Block specific content types
- Emergency lock feature

Settings:
- Manage notifications
- Update account information
- Configure privacy settings
- Manage subscriptions

CHILD MODE FEATURES

Home Dashboard:
- Personalized greeting with child's name
- Progress overview (level, XP, streak)
- Daily goal tracking
- Continue learning shortcut
- Recommended activities

Learn Section:
- Subject-based learning (Math, Science, Reading, etc.)
- Interactive lessons with guided instruction
- Progress tracking and achievements
- Adaptive difficulty based on performance

Play Section:
- Educational games and puzzles
- Interactive stories
- Music and songs
- Educational videos
- All content is age-appropriate and safe

AI Buddy:
- Friendly AI assistant for questions
- Personalized learning recommendations
- Emotional support and encouragement
- Safe, filtered conversations

Profile:
- View achievements and badges
- See learning statistics
- Manage favorites
- Customize avatar and preferences

SAFETY FEATURES

Content Filtering:
- All content reviewed by educators
- Age-appropriate material only
- No external links or advertisements
- Safe search within the app

Privacy Protection:
- COPPA and GDPR compliant
- Minimal data collection
- Parental consent required
- Secure data storage

Parental Oversight:
- Complete activity monitoring
- Detailed usage reports
- Real-time notifications
- Remote control capabilities

TIPS FOR PARENTS

1. Start with short sessions (15-20 minutes) and gradually increase
2. Explore the app with your child initially
3. Review progress reports regularly
4. Adjust difficulty settings as needed
5. Use break reminders to encourage healthy habits
6. Celebrate achievements with your child
7. Contact support if you need help

TROUBLESHOOTING

App Won't Load:
- Check internet connection
- Restart the app
- Update to latest version

Login Issues:
- Verify email and password
- Use "Forgot Password" if needed
- Check Parent PIN if prompted

Content Not Loading:
- Ensure stable internet connection
- Try downloading content for offline use
- Check storage space on device

Performance Issues:
- Close other apps
- Restart device
- Clear app cache if needed

SUPPORT

Need more help? Contact us at:
- Email: support@kinderworld.app
- Live Chat: Available 24/7 in the app
- Phone: 1-800-KINDER

Thank you for choosing Kinder World for your child's learning journey!'''
      .replaceAll('\n', '\n\n');

      default:
        return 'Legal information will be displayed here based on the selected option.';
    }
  }
}