import 'dart:math';

import 'package:casper/components/confirm_action.dart';
import 'package:casper/comp/customised_text.dart';
import 'package:casper/components/panel_forms/add_panel_form.dart';
import 'package:casper/components/panel_forms/add_teams_form.dart';
import 'package:casper/data_tables/faculty/coordinator/coordinator_panel_management_data_table.dart';
import 'package:casper/components/search_text_field.dart';
import 'package:casper/components/panel_forms/add_panel_from_CSV_form.dart';
import 'package:casper/models/models.dart';
import 'package:casper/views/shared/loading_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:casper/components/panel_forms/assign_teams_to_panels_from_CSV_form.dart';

import '../../../../components/add_teams_form.dart';

class CoordinatorPanelManagementPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final userRole, viewPanel;

  const CoordinatorPanelManagementPage({
    Key? key,
    required this.userRole,
    required this.viewPanel,
  }) : super(key: key);

  @override
  State<CoordinatorPanelManagementPage> createState() =>
      _CoordinatorPanelManagementPageState();
}

class _CoordinatorPanelManagementPageState
    extends State<CoordinatorPanelManagementPage> {
  bool loading = true, searching = false;
  List<AssignedPanel> assignedPanels = [];
  final panelIdController = TextEditingController(),
      evaluatorNameController = TextEditingController(),
      termController = TextEditingController(),
      courseController = TextEditingController(text: 'CP302'),
      yearSemesterController = TextEditingController(text: '2023-1');
  final horizontalScrollController = ScrollController(),
      verticalScrollController = ScrollController();

  void confirmAction() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: ConfirmAction(
              onSubmit: () {},
            ),
          ),
        );
      },
    );
  }

  void getPanels() {
    setState(() {
      assignedPanels.clear();
    });

    FirebaseFirestore.instance.collection('assigned_panel').get().then((value) {
      for (var doc in value.docs) {
        setState(() {
          assignedPanels.add(
            AssignedPanel(
              id: doc['panel_id'],
              course: doc['course'],
              term: doc['term'],
              semester: doc['semester'],
              year: doc['year'],
              numberOfAssignedTeams: 0,
              panel: Panel(
                  course: doc['course'],
                  semester: doc['semester'],
                  year: doc['year'],
                  id: doc['panel_id'],
                  numberOfEvaluators: int.parse(doc['number_of_evaluators']),
                  evaluators: List<Faculty>.generate(
                      int.parse(doc['number_of_evaluators']),
                      (index) => Faculty(
                          id: doc['evaluator_ids'][index],
                          name: doc['evaluator_names'][index],
                          email: ''))),
              assignedTeams: [],
              evaluations: [],
              assignedProjectIds:
                  List<String>.from(doc['assigned_project_ids']),
              numberOfAssignedProjects:
                  int.tryParse(doc['number_of_assigned_projects']),
            ),
          );
        });
      }
      setState(() {
        loading = false;
        searching = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getPanels();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 1440;
    double wfem = (MediaQuery.of(context).size.width *
            MediaQuery.of(context).devicePixelRatio) /
        baseWidth;
    double hfem = (MediaQuery.of(context).size.height *
            MediaQuery.of(context).devicePixelRatio) /
        baseWidth;

    if (loading) {
      return const LoadingPage();
    }

    final ScrollController scrollController = ScrollController();
    return Expanded(
      child: Scaffold(
        body: Container(
          color: const Color(0xff302c42),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(60, 30, 0, 0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomisedText(
                          text: 'Panel Management',
                          fontSize: 50,
                        ),
                        Container(),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 33 * wfem,
                        ),
                        Tooltip(
                          message: 'Panel Identification Number',
                          child: SearchTextField(
                            textEditingController: panelIdController,
                            hintText: 'Panel Identification',
                            width: 170 * wfem,
                          ),
                        ),
                        SizedBox(
                          width: 20 * wfem,
                        ),
                        Tooltip(
                          message: 'Evaluator\'s Name',
                          child: SearchTextField(
                            textEditingController: evaluatorNameController,
                            hintText: 'Evaluator\'s Name',
                            width: 170 * wfem,
                          ),
                        ),
                        SizedBox(
                          width: 20 * wfem,
                        ),
                        Tooltip(
                          message: 'Term Type',
                          child: SearchTextField(
                            textEditingController: termController,
                            hintText: 'Term',
                            width: 170 * wfem,
                          ),
                        ),
                        SizedBox(
                          width: 20 * wfem,
                        ),
                        Tooltip(
                          message: 'Course Code',
                          child: SearchTextField(
                            textEditingController: courseController,
                            hintText: 'Course',
                            width: 170 * wfem,
                          ),
                        ),
                        SizedBox(
                          width: 20 * wfem,
                        ),
                        Tooltip(
                          message: 'Session (Year-Semester)',
                          child: SearchTextField(
                            textEditingController: yearSemesterController,
                            hintText: 'Session',
                            width: 170 * wfem,
                          ),
                        ),
                        SizedBox(
                          width: 25 * wfem,
                        ),
                        SizedBox(
                          height: 47,
                          width: 47,
                          child: FloatingActionButton(
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 212, 203, 216),
                            splashColor: Colors.black,
                            hoverColor: Colors.grey,
                            child: const Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 29,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 1200 * wfem,
                      height: 1000 * hfem,
                      margin: EdgeInsets.fromLTRB(40, 15, 80 * wfem, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black38,
                          ),
                          BoxShadow(
                            color: Color.fromARGB(255, 70, 67, 83),
                            spreadRadius: -3,
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        // TODO: Implement search
                        child: (searching
                            ? SizedBox(
                                width: double.infinity,
                                height: 500 * wfem,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.black),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 500,
                                width: 400,
                                child: Scrollbar(
                                  controller: verticalScrollController,
                                  thumbVisibility: true,
                                  trackVisibility: true,
                                  child: Scrollbar(
                                    controller: horizontalScrollController,
                                    thumbVisibility: true,
                                    trackVisibility: true,
                                    notificationPredicate: (notif) =>
                                        notif.depth == 1,
                                    child: SingleChildScrollView(
                                      controller: verticalScrollController,
                                      child: SingleChildScrollView(
                                        controller: horizontalScrollController,
                                        scrollDirection: Axis.horizontal,
                                        child: SizedBox(
                                          width: max(1217, 950 * wfem),
                                          child:
                                              CoordinatorPanelManagementDataTable(
                                            assignedPanels: assignedPanels,
                                            viewPanel: widget.viewPanel,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 65,
              )
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 45 * wfem,
              width: 45 * wfem,
              margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
              child: Tooltip(
                message: 'Download Panels',
                child: FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 212, 203, 216),
                  splashColor: Colors.black,
                  hoverColor: Colors.grey,
                  child: const Icon(
                    Icons.download_rounded,
                    color: Colors.black,
                    size: 35,
                  ),
                  // TODO: Add this function
                  onPressed: () {},
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 45 * wfem,
              width: 45 * wfem,
              margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
              child: Tooltip(
                message: 'Assign Teams From CSV',
                child: FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 212, 203, 216),
                  splashColor: Colors.black,
                  hoverColor: Colors.grey,
                  child: const Icon(
                    Icons.upload_file_rounded,
                    color: Colors.black,
                    size: 35,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Center(
                            child: AssignTeamsToPanelsFromCSVForm(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            // Container(
            //   height: 45 * wfem,
            //   width: 45 * wfem,
            //   margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
            //   child: Tooltip(
            //     message: 'Assign Team',
            //     child: FloatingActionButton(
            //       backgroundColor: const Color.fromARGB(255, 212, 203, 216),
            //       splashColor: Colors.black,
            //       hoverColor: Colors.grey,
            //       child: const Icon(
            //         Icons.add,
            //         color: Colors.black,
            //         size: 35,
            //       ),
            //       onPressed: () {
            //         showDialog(
            //           context: context,
            //           builder: (context) {
            //             return const AlertDialog(
            //               title: Center(
            //                   // TODO: Assign team NOT create team
            //                   // child: CreateTeamsForm(),
            //                   ),
            //             );
            //           },
            //         );
            //       },
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            Container(
              height: 45 * wfem,
              width: 45 * wfem,
              margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
              child: Tooltip(
                message: 'Create Panels From CSV',
                child: FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 212, 203, 216),
                  splashColor: Colors.black,
                  hoverColor: Colors.grey,
                  child: const Icon(
                    Icons.upload_file,
                    color: Colors.black,
                    size: 35,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Center(
                            child: CreatePanelFromCSVForm(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 45 * wfem,
              width: 45 * wfem,
              margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
              child: Tooltip(
                message: 'Create Panel',
                child: FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 212, 203, 216),
                  splashColor: Colors.black,
                  hoverColor: Colors.grey,
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 35,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Center(
                            child: AddPanelForm(
                              refresh: getPanels,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 65,
            ),
          ],
        ),
      ),
    );
  }
}
