import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kan_absen/models/agenda_model.dart';
import 'package:kan_absen/screen/list_agenda_screen.dart';
import 'package:kan_absen/templates/colour_template.dart';
import 'package:kan_absen/templates/text_style_template.dart';
import 'package:kan_absen/widgets/card_menu_widget.dart';
import 'package:provider/provider.dart';

class AgendaCardWidget extends StatelessWidget {
  const AgendaCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardMenuWidget(
      startColour: ColourTemplate.negativeColour.withOpacity(.9),
      endColour: ColourTemplate.negativeColour.withOpacity(.8),
      child: Consumer<AgendaModel>(
        builder: (context, agenda, child) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Agenda',
                    style: TextStyleTemplate.boldWhite(size: 18),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      agenda.theListOfAgenda.isNotEmpty
                        ? DateFormat('dd').format(agenda.theListOfAgenda[0].agenda_start)
                        : 'Tidak Ada',
                      style: TextStyleTemplate.boldWhite(size: agenda.theListOfAgenda.isNotEmpty ? 32 : 24),
                    ),
                    Column(
                      children: [
                        Text(
                          agenda.theListOfAgenda.isNotEmpty
                            ? DateFormat('MMMM').format(agenda.theListOfAgenda[0].agenda_start)
                            : '',
                          style: TextStyleTemplate.mediumWhite(size: 18),
                        ),
                        Text(
                          agenda.theListOfAgenda.isNotEmpty
                            ? DateFormat('yyyy').format(agenda.theListOfAgenda[0].agenda_start)
                            : '',
                          style: TextStyleTemplate.regularWhite(size: 16),
                        ),
                      ],
                    )
                  ],
                ),
                Container(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(),
                Container(
                  width: MediaQuery.of(context).size.width * 0.38,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    agenda.theListOfAgenda.isNotEmpty
                      ? agenda.theListOfAgenda[0].agenda_name
                      : '',
                    style: TextStyleTemplate.boldWhite(size: 28),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    color: Colors.white
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pushNamed(ListAgendaScreen.route),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        alignment: Alignment.center,
                        child: Text(
                          'Lihat Detail',
                          style: TextStyleTemplate.mediumNegative(size: 14),
                        ),
                      ),
                    ),
                  ),
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}
