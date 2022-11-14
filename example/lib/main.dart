/// Figma
// https://www.figma.com/file/s1MhgPqbtApD2PV3cZ7YHp/Featly-%2F-Music-profile?node-id=17%3A557
// https://www.figma.com/file/s1MhgPqbtApD2PV3cZ7YHp/Featly-%2F-Music-profile?node-id=250%3A3054
// https://www.figma.com/file/hCMcCzGdfbDBSE8l3RvKvB/qwakly?node-id=105%3A2
//
// d:\flutter\SDK\flutter\bin\flutter.bat
//
// построение JSON
// flutter    pub run build_runner build
// flutter    pub run build_runner watch
//
// ВЕБ
// flutter    build web
// flutter    build web --web-renderer html  --base-href /https://hohma.by/    --release
//
// Генерирование классов для ассетов
// //FlutterGen // https://github.com/FlutterGen/flutter_gen
// flutter packages pub run build_runner build

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grid Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PlutoGridExamplePage(),
    );
  }
}

/// PlutoGrid Example
//
/// For more examples, go to the demo web link on the github below.
class PlutoGridExamplePage extends StatefulWidget {
  const PlutoGridExamplePage({Key? key}) : super(key: key);

  @override
  State<PlutoGridExamplePage> createState() => _PlutoGridExamplePageState();
}

var colorB = const Color(0xFFF8F8F8);
// var colorB = const Color(0xFFffffff);

var ww = 90.0;

// const double ColumnHeight = 110 - 12;
const double ColumnHeight = 124;
const double ColumnGroupHeight = 32;
const double FilterHeight = 46;
const bool headerBottom = true;

class _PlutoGridExamplePageState extends State<PlutoGridExamplePage> {
  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      backgroundColor: colorB,
      titlePadding: EdgeInsets.zero,
      filterPadding: EdgeInsets.zero,
      // titleSpan:EdgeInsets.zero,
      cellPadding: EdgeInsets.zero,
      title: '',
      enableContextMenu: false,
      enableDropToResize: false,
      width: 35,
      titleSpan: TextSpan(
        children: [
          WidgetSpan(
            child: Container(
              height: FilterHeight + ColumnHeight + ColumnGroupHeight + 46,
              // color: Color(0x55555555),
              // alignment: EdgeInsets., ///v
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: FilterHeight,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            //background: linear-gradient(270deg, rgba(3, 122, 173, 0.276) 0%, rgba(8, 156, 147, 0.227188) 43.23%, rgba(14, 201, 89, 0.234) 100%);
                            filterControlColorFunc(0),
                            filterControlColorFunc(0),
                            // Color.fromRGBO(8, 156, 147, 0.227188),
                            // Color.fromRGBO(14, 201, 89, 0.234),
                          ], // Color(0x0501BD01)
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                    width: double.infinity,
                    child: IconButton(
                      icon: const Icon(
                        Icons.star_border,
                      ),
                      onPressed: () {},
                      iconSize: 18,
                      color: Colors.green,
                      padding: const EdgeInsets.all(0),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.star_border,
                    ),
                    onPressed: () {},
                    iconSize: 18,
                    color: Colors.green,
                    padding: const EdgeInsets.all(0),
                  ),
                ],
              ),
            ),
          ),
          // TextSpan(text: 'column title'),
        ],
      ),
      frozen: PlutoColumnFrozen.start,
      field: 'checked',
      type: PlutoColumnType.number(),
      renderer: (rendererContext) {
        var icon = (rendererContext.cell.value == 1) ? Icons.star_border : Icons.star;
        return IconButton(
          icon: Icon(
            icon,
          ),
          onPressed: () {
            rendererContext.stateManager.insertRows(
              rendererContext.rowIdx,
              [rendererContext.stateManager.getNewRow()],
            );
          },
          iconSize: 18,
          color: Colors.green,
          padding: const EdgeInsets.all(0),
        );
      },
    ),
    PlutoColumn(
      backgroundColor: colorB,
      titlePadding: EdgeInsets.zero,
      filterPadding: EdgeInsets.zero,
      // titleSpan:EdgeInsets.zero,
      cellPadding: EdgeInsets.zero,
      title: 'average weekly income',
      enableContextMenu: false,
      enableDropToResize: false,
      titleSpan: headerFilter(1, 'AVERAGE\nWEEKLY\nINCOME'),
      field: 'awi',
      width: ww + 10,
      frozen: PlutoColumnFrozen.start,
      enableColumnDrag: false,

      type: PlutoColumnType.text(),
      renderer: (rendererContext) {
        Color textColor = Colors.green;

        if (rendererContext.cell.value == 'red') {
          textColor = Colors.red;
        } else if (rendererContext.cell.value == 'blue') {
          textColor = Colors.blue;
        } else if (rendererContext.cell.value == 'green') {
          textColor = Colors.green;
        }

        return Text(
          '\$ ' + rendererContext.cell.value.toString(),
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
    PlutoColumn(
      backgroundColor: colorB,
      titlePadding: EdgeInsets.zero,
      filterPadding: EdgeInsets.zero,
      // titleSpan:EdgeInsets.zero,
      // cellPadding: EdgeInsets.zero,
      title: 'job',
      field: 'job',
      enableContextMenu: false,
      enableDropToResize: false,
      width: ww,
      titleSpan: headerFilter(2, 'TYPE\n\n'),
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      backgroundColor: colorB,
      titlePadding: EdgeInsets.zero,
      filterPadding: EdgeInsets.zero,
      // titleSpan:EdgeInsets.zero,
      // cellPadding: EdgeInsets.zero,
      title: 'cents per mile',
      titleSpan: headerFilter(3, 'CENTS \nPER\nMILE'),
      field: 'spm',
      enableContextMenu: false,
      enableDropToResize: false,
      width: ww,
      type: PlutoColumnType.select(<String>[
        'Programmer',
        'Designer',
        'Owner',
      ]),
    ),
    PlutoColumn(
      backgroundColor: colorB,
      titlePadding: EdgeInsets.zero,
      filterPadding: EdgeInsets.zero,
      // titleSpan:EdgeInsets.zero,
      // cellPadding: EdgeInsets.zero,
      title: 'weekly',
      field: 'weekly',
      width: ww,
      titleSpan: headerFilter(4, 'WEEKLY\n\n'),
      enableContextMenu: false,
      enableDropToResize: false,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      backgroundColor: colorB,
      titlePadding: EdgeInsets.zero,
      filterPadding: EdgeInsets.zero,
      // titleSpan:EdgeInsets.zero,
      // cellPadding: EdgeInsets.zero,
      title: 'daly time',
      field: 'daly',
      width: ww,
      enableContextMenu: false,
      enableDropToResize: false,
      titleSpan: headerFilter(5, 'DALY\n\n'),
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      backgroundColor: colorB,
      titlePadding: EdgeInsets.zero,
      filterPadding: EdgeInsets.zero,
      // titleSpan:EdgeInsets.zero,
      // cellPadding: EdgeInsets.zero,
      title: 'PER HOUR',
      field: 'hour',
      width: ww,
      enableContextMenu: false,
      enableDropToResize: false,
      titleSpan: headerFilter(6, 'PER\nHOUR\n'),
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      backgroundColor: colorB,
      titlePadding: EdgeInsets.zero,
      filterPadding: EdgeInsets.zero,
      // titleSpan:EdgeInsets.zero,
      // cellPadding: EdgeInsets.zero,
      title: 'OFF GROSS',
      field: 'gross',
      enableSorting: false,
      width: ww,
      enableContextMenu: false,
      enableDropToResize: false,
      titleSpan: headerFilter(7, '%OFF\nGROSS\n'),
      type: PlutoColumnType.text(),
    ),
  ];

  final List<PlutoRow> rows = [
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '1050'),
        'job': PlutoCell(value: 'Team'),
        'spm': PlutoCell(value: '80 c'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '\$ 400'),
        'hour': PlutoCell(value: '\$ 10'),
        'gross': PlutoCell(value: '%1'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 0),
        'awi': PlutoCell(value: '1650'),
        'job': PlutoCell(value: 'Lease'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '—'),
        'gross': PlutoCell(value: '%2'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
    PlutoRow(
      cells: {
        'checked': PlutoCell(value: 1),
        'awi': PlutoCell(value: '2101'),
        'job': PlutoCell(value: 'Solo'),
        'spm': PlutoCell(value: '—'),
        'weekly': PlutoCell(value: '—'),
        'daly': PlutoCell(value: '—'),
        'hour': PlutoCell(value: '\$ 5'),
        'gross': PlutoCell(value: '%5'),
      },
    ),
  ];

  /// columnGroups that can group columns can be omitted.
  final List<PlutoColumnGroup> columnGroups = [
    // PlutoColumnGroup(title: 'checked', fields: ['checked'], expandedColumn: true),
    PlutoColumnGroup(title: 'AWI', fields: ['awi'], titleSpan: headerGroupCaption("AWI"), backgroundColor: colorB, titlePadding: EdgeInsets.zero),
    PlutoColumnGroup(title: 'Job', fields: ['job'], titleSpan: headerGroupCaption("Job"), backgroundColor: colorB, titlePadding: EdgeInsets.zero),
    PlutoColumnGroup(title: 'Salary options', fields: ['spm', 'weekly', 'daly', 'hour', 'gross'], titleSpan: headerGroupCaption("Salary Options1"), backgroundColor: colorB, titlePadding: EdgeInsets.zero),
  ];

  /// [PlutoGridStateManager] has many methods and properties to dynamically manipulate the grid.
  /// You can manipulate the grid dynamically at runtime by passing this through the [onLoaded] callback.
  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.orange,
        padding: const EdgeInsets.all(15),
        child: Material(
            child: PlutoGrid(
          columns: columns,
          rows: rows,
          columnGroups: columnGroups,
          onLoaded: (PlutoGridOnLoadedEvent event) {
            stateManager = event.stateManager;
            event.stateManager.setShowColumnFilter(true);
          },
          onChanged: (PlutoGridOnChangedEvent event) {
            print(event);
          },

          /// back lite row color
          rowColorCallback: (rowColorContext) {
            if (rowColorContext.row.cells.entries.elementAt(2).value.value == 'Team') {
              return Color(0xFFFFE3E3);
            } else if (rowColorContext.row.cells.entries.elementAt(4).value.value == 'Solo') {
              return Color(0xFFFFFFFF);
            }

            return Color(0xFFFFFFFF);
          },

          configuration: const PlutoGridConfiguration(
            linesForFields: ["job", "daly", "Salary options", "Job"],
            style: PlutoGridStyleConfig(
              enableGridBorderShadow: false,

              enableColumnBorderVertical: true,
              enableColumnBorderHorizontal: false,

              enableCellBorderVertical: true,
              enableCellBorderHorizontal: false,

              gridBorderColor: Color(0xff1146ab),
              borderColor: Color(0xff4af834),
              lineColor: Color(0xfffd0000),

              /// active line backlite
              activatedColor: const Color(0xFFFFEE9B),
              checkedColor: const Color(0xFFFD0000),

              defaultColumnTitlePadding: EdgeInsets.symmetric(horizontal: 10),
              defaultColumnFilterPadding: EdgeInsets.symmetric(horizontal: 10),
              defaultCellPadding: EdgeInsets.symmetric(horizontal: 20),
              columnHeight: ColumnHeight,
              columnGroupHeight: ColumnGroupHeight,
              headerBottom: headerBottom,
            ),
            columnSize: PlutoGridColumnSizeConfig(
              autoSizeMode: PlutoAutoSizeMode.none,
              resizeMode: PlutoResizeMode.pushAndPull,
            ),
          ),
        )),
      ),
    );
  }
}

/// /// column headers
/// column Group Caption
headerGroupCaption(h) {
  return TextSpan(
    children: [
      WidgetSpan(
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 32,
                // color:Colors.amber,
                alignment: Alignment.topLeft,
                child: Text(
                  h,
                  style: const TextStyle(
                    color: Color(0xFF01BD01),
                    fontFamily: 'graphik',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              infoControl(),
            ],
          ),
        ),
      ),
      // TextSpan(text: 'column title'),
    ],
  );
}

/// column filter
headerWithOrder(txt) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      // Container(
      //   // color: Colors.red,
      //   padding: EdgeInsets.only(top: 17),
      //   width: 20,
      //   height: 55,
      //
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Container(
      //         alignment: Alignment.topLeft,
      //         height: 10,
      //         child: IconButton(
      //           icon: const Icon(
      //             Icons.arrow_drop_up,
      //           ),
      //           onPressed: () {},
      //           iconSize: 18,
      //           color: Colors.grey,
      //           // color: Colors.grey,
      //           padding: const EdgeInsets.all(0),
      //         ),
      //       ),
      //       Container(
      //         alignment: Alignment.topLeft,
      //         height: 10,
      //         child: IconButton(
      //           icon: const Icon(
      //             Icons.arrow_drop_down,
      //           ),
      //           onPressed: () {},
      //           iconSize: 18,
      //           color: Colors.grey,
      //           padding: const EdgeInsets.all(0),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.only(top: 18, left: 25),
        child: Text(
          txt,
          style: const TextStyle(
            color: Color(0xFF3D3D3D),
            fontFamily: 'graphik',
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    ],
  );
}

/// column caption & sort
headerFilter(double i, h) {
  return WidgetSpan(
    child: Container(
      // color: Colors.amber,
      height: ColumnHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          filterControl(i, "FILTER"),
          headerWithOrder(h),
        ],
      ),
    ),
  );
}

/// /// column header controlls

infoControl() {
  return SizedBox(
    height: 12.0,
    width: 12.0,
    child: IconButton(
      icon: const Icon(Icons.info_outline, size: 12),
      onPressed: () {},
      iconSize: 12,
      color: Color(0xFF01BD01),
      padding: EdgeInsets.all(0.0),
      // splashColor: Colors.deepPurpleAccent,
    ),
  );
}

HSLColor cl = HSLColor.fromColor(Color.fromRGBO(3, 122, 173, 0.18));

filterControlColorFunc(i) {
  return cl.withHue(190.0 - i * 10).toColor();
}

filterControl(double i, txt) {
  // Color cl1 = HSLColor.fromColor(Color(0xFFE8F5F8)).withLightness(filterControlColorFunc(i-1)).toColor();
  // Color cl2 = HSLColor.fromColor(Color(0xFFE8F5F8)).withLightness(filterControlColorFunc(i)).toColor();

  Color cl1 = filterControlColorFunc(i - 1);
  Color cl2 = filterControlColorFunc(i);

  return Container(
      alignment: Alignment.centerLeft,
      height: FilterHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              cl1,
              cl2,
              // Color(0x202CAFF9),
            ], // Color(0x0501BD01)
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
      ),
      width: double.infinity,
      child: const Padding(
        padding: EdgeInsets.only(left: 20),
        child: Text("FILTER"),
      ));
}

BoxDecoration decorationBorder() {
  return const BoxDecoration(
    border: Border(
      right: BorderSide(
        //                   <--- left side
        color: Colors.red,
        width: 2.0,
      ),
    ),
  );
}
