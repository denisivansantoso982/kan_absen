import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kan_absen/models/agenda_model.dart';
import 'package:kan_absen/models/data/agenda_data.dart';
import 'package:kan_absen/templates/colour_template.dart';
import 'package:kan_absen/widgets/appbar_widget.dart';
import 'package:provider/provider.dart';

class DetailAgendaScreen extends StatelessWidget {
  const DetailAgendaScreen({Key? key}) : super(key: key);
  static const String route = '/detail_agenda_screen';

  @override
  Widget build(BuildContext context) {
    final String uid = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: AppBarWidget(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  right: 8,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.chevron_left,
                    color: ColourTemplate.primaryColour,
                    size: 32,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      "Detail",
                      style: TextStyle(
                        color: ColourTemplate.grayColour,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Agenda",
                      style: TextStyle(
                        color: ColourTemplate.primaryColour,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.25),
                blurRadius: 4,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          margin: const EdgeInsets.only(
            top: 8,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 12,
          ),
          child: Consumer<AgendaModel>(
            builder: (context, agenda, child) {
              AgendaData theAgenda = agenda.theListOfAgenda.firstWhere((element) => element.agenda_uid == uid);
              return Column(
                children: [
                  // *Agenda Name
                  Container(
                    margin: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Nama Agenda",
                          style: TextStyle(
                            color: ColourTemplate.grayColour,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextField(
                          controller: TextEditingController(text: theAgenda.agenda_name),
                          readOnly: true,
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
                            hintText: "Nama Agenda",
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
                  // *Agenda Start
                  Container(
                    margin: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tanggal Mulai Agenda",
                          style: TextStyle(
                            color: ColourTemplate.grayColour,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextField(
                          controller: TextEditingController(text: DateFormat('EEEE, dd MMMM yyyy').format(theAgenda.agenda_start)),
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
                  // *Agenda End
                  Container(
                    margin: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tanggal Berakhir Agenda",
                          style: TextStyle(
                            color: ColourTemplate.grayColour,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextFormField(
                          controller: TextEditingController(text: DateFormat('EEEE, dd MMMM yyyy').format(theAgenda.agenda_end)),
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
                  // *Quotes
                  Container(
                    margin: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Detail Agenda",
                          style: TextStyle(
                            color: ColourTemplate.grayColour,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextFormField(
                          controller: TextEditingController(text: theAgenda.agenda_detail),
                          maxLines: null,
                          maxLength: null,
                          keyboardType: TextInputType.multiline,
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
                            hintText: "Detail Agenda",
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
              );
            }
          ),
        ),
      ),
    );
  }
}
