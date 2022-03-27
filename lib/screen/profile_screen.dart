import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kan_absen/firebase/auth.dart';
import 'package:kan_absen/models/present_model.dart';
import 'package:kan_absen/models/profile_model.dart';
import 'package:kan_absen/screen/login_screen.dart';
import 'package:kan_absen/templates/colour_template.dart';
import 'package:kan_absen/templates/text_style_template.dart';
import 'package:kan_absen/widgets/appbar_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const String route = '/profile_screen';

  void _doLogout(BuildContext context) async {
    await signOut();
    Provider.of<ProfileModel>(context, listen: false).removeAllProfile();
    Provider.of<PresentModel>(context, listen: false).removePresent();
    bool isStored = Provider.of<ProfileModel>(context, listen: false)
              .theProfile == null
      ? false
      : true;
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    await Future.delayed(const Duration(seconds: 1));
    if (!isStored) {
      Navigator.of(context).pushReplacementNamed(LoginScreen.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: AppBarWidget(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.chevron_left_outlined,
                    color: ColourTemplate.primaryColour,
                    size: 32,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Profil',
                      style: TextStyleTemplate.boldGray(size: 28),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Saya',
                      style: TextStyleTemplate.boldPrimary(
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 4,
        ),
        child: Column(
          children: [
            Form(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 8,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.25),
                      blurRadius: 4,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: Consumer<ProfileModel>(
                  builder: (context, profile, child) => Column(
                    children: [
                      // *Name
                      Container(
                        margin: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Nama",
                              style: TextStyle(
                                color: ColourTemplate.grayColour,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextFormField(
                              initialValue: profile.theProfile != null
                                  ? profile.theProfile!.name
                                  : '',
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColourTemplate.primaryColour,
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColourTemplate.primaryColour,
                                    width: 2,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColourTemplate.primaryColour,
                                    width: 2,
                                  ),
                                ),
                                contentPadding: EdgeInsets.only(
                                  bottom: 4,
                                  top: 8,
                                ),
                                hintText: "Nama Lengkap",
                                isDense: true,
                              ),
                              cursorColor: ColourTemplate.primaryColour,
                              style: const TextStyle(
                                color: ColourTemplate.primaryColour,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // *Date Of Birth
                      Container(
                        margin: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Tanggal Lahir",
                              style: TextStyle(
                                color: ColourTemplate.grayColour,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextFormField(
                              initialValue: profile.theProfile != null
                                  ? DateFormat('EEEE, dd MMMM yyyy')
                                      .format(profile.theProfile!.dateOfBirth)
                                  : '',
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColourTemplate.primaryColour,
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColourTemplate.primaryColour,
                                    width: 2,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColourTemplate.primaryColour,
                                    width: 2,
                                  ),
                                ),
                                contentPadding: EdgeInsets.only(
                                  bottom: 4,
                                  top: 8,
                                ),
                                hintText: "Tanggal Lahir",
                                isDense: true,
                              ),
                              readOnly: true,
                              cursorColor: ColourTemplate.primaryColour,
                              style: const TextStyle(
                                color: ColourTemplate.primaryColour,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // *Sex
                      Container(
                        margin: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Jenis Kelamin",
                              style: TextStyle(
                                color: ColourTemplate.grayColour,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextFormField(
                              initialValue: profile.theProfile != null
                                  ? profile.theProfile!.sex
                                  : '',
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColourTemplate.primaryColour,
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColourTemplate.primaryColour,
                                    width: 2,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColourTemplate.primaryColour,
                                    width: 2,
                                  ),
                                ),
                                contentPadding: EdgeInsets.only(
                                  bottom: 4,
                                  top: 8,
                                ),
                                hintText: "Jenis Kelamin",
                                isDense: true,
                              ),
                              readOnly: true,
                              cursorColor: ColourTemplate.primaryColour,
                              style: const TextStyle(
                                color: ColourTemplate.primaryColour,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // *Email
                      Container(
                        margin: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Email",
                              style: TextStyle(
                                color: ColourTemplate.grayColour,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextFormField(
                              initialValue: profile.theProfile != null
                                  ? profile.theProfile!.email
                                  : '',
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColourTemplate.primaryColour,
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColourTemplate.primaryColour,
                                    width: 2,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColourTemplate.primaryColour,
                                    width: 2,
                                  ),
                                ),
                                contentPadding: EdgeInsets.only(
                                  bottom: 4,
                                  top: 8,
                                ),
                                hintText: "Alamat Email",
                                isDense: true,
                              ),
                              cursorColor: ColourTemplate.primaryColour,
                              style: const TextStyle(
                                color: ColourTemplate.primaryColour,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // *Quotes
                      Container(
                        margin: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Kata-Kata",
                              style: TextStyle(
                                color: ColourTemplate.grayColour,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextFormField(
                              maxLines: null,
                              maxLength: null,
                              keyboardType: TextInputType.multiline,
                              initialValue: profile.theProfile != null
                                  ? profile.theProfile!.quotes
                                  : '',
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColourTemplate.primaryColour,
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColourTemplate.primaryColour,
                                    width: 2,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColourTemplate.primaryColour,
                                    width: 2,
                                  ),
                                ),
                                contentPadding: EdgeInsets.only(
                                  bottom: 4,
                                  top: 8,
                                ),
                                hintText: "Kata-kata",
                                isDense: true,
                              ),
                              cursorColor: ColourTemplate.primaryColour,
                              style: const TextStyle(
                                color: ColourTemplate.primaryColour,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: ColourTemplate.negativeColour,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.black.withOpacity(.25),
                  highlightColor: Colors.black.withOpacity(.25),
                  onTap: () => _doLogout(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text(
                      "KELUAR",
                      style: TextStyleTemplate.boldWhite(size: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
