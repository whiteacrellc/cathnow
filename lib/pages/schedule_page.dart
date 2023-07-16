import 'package:cathnow/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:cathnow/utils/logger.dart';
import 'package:logging/logging.dart';
import 'package:cathnow/widgets/description_widget.dart';
import 'package:cathnow/widgets/date_picker.dart';
import 'package:provider/provider.dart';
import 'package:cathnow/widgets/navigation_bar.dart';
import 'package:cathnow/widgets/custom_button.dart';
import 'package:cathnow/utils/settings.dart';
import 'package:cathnow/pages/log_cath.dart';
import 'package:cathnow/widgets/my_appbar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  SchedulePageState createState() => SchedulePageState();
}

class SchedulePageState extends State<SchedulePage> {
  final Logger logger = LoggerSingleton().getLogger();

  @override
  void initState() {
    super.initState();
  }

  void _showWarningDialog() {
    AlertDialog(
      title: const Text('Schedule Info'),
      content: const Text('You must set at least one time.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Dismiss'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    NavBar().page = NavigationPage.setup;

    const descriptionText = '''
Make a list of the time of day you want to cath.''';
    return Consumer<Settings>(
        builder: (context, appState, _) => Scaffold(
            appBar: const MyAppBar(title: "Setup"),
            bottomNavigationBar: NavBar(),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Card(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: DescriptionWidget(text: (descriptionText)),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          //color: Colors.black,
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListView.builder(
                          //key: const Key("cathlist"),
                          itemCount: appState.cathList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Dismissible(
                                key: Key(Utils.convertTimeOfDayToString(
                                    appState.cathList[index])),
                                onDismissed: (direction) {
                                  setState(() {
                                    appState.reomoveListEntry(index);
                                  });
                                },
                                background: Container(
                                  color:
                                      const Color.fromARGB(255, 128, 60, 131),
                                  alignment: Alignment.center,
                                  child: const Padding(
                                    padding: EdgeInsets.only(right: 16.0),
                                    child: Icon(
                                      Icons.delete,
                                      color: Color.fromARGB(255, 32, 19, 212),
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: ListTile(
                                    key: Key(Utils.convertTimeOfDayToString(
                                        appState.cathList[index])),
                                    title: Text(
                                      Utils.convertTimeOfDayToString(
                                          appState.cathList[index]),
                                      style: const TextStyle(
                                        backgroundColor:
                                            Color.fromARGB(54, 65, 180, 196),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.0,
                                      ),
                                    ),
                                  ),
                                ));
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TimePickerWidget(
                    key: const Key("timepickerwidget"),
                    timeOfDayList: appState.cathList,
                    setStateCallback: (TimeOfDay timeOfDay) {
                      setState(() {
                        appState.addListEntry(timeOfDay);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      buttonText: "Done",
                      onPressed: () {
                        if (appState.cathList.isEmpty) {
                          _showWarningDialog();
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LogCathWidget()));
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                ]))));
  }
}
