import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class PlutoColumnTitle extends PlutoStatefulWidget {
  final PlutoGridStateManager stateManager;

  final PlutoColumn column;

  late final double height;

  PlutoColumnTitle({
    required this.stateManager,
    required this.column,
    double? height,
  })  : height = height ?? stateManager.columnHeight,
        super(key: ValueKey('column_title_${column.key}'));

  @override
  PlutoColumnTitleState createState() => PlutoColumnTitleState();
}

class PlutoColumnTitleState extends PlutoStateWithChange<PlutoColumnTitle> {
  late Offset _columnRightPosition;

  bool _isPointMoving = false;

  PlutoColumnSort _sort = PlutoColumnSort.none;

  bool get showContextIcon {
    return widget.column.enableContextMenu ||
        widget.column.enableDropToResize ||
        !_sort.isNone;
  }

  bool get enableGesture {
    return widget.column.enableContextMenu || widget.column.enableDropToResize;
  }

  MouseCursor get contextMenuCursor {
    if (enableGesture) {
      return widget.column.enableDropToResize
          ? SystemMouseCursors.resizeLeftRight
          : SystemMouseCursors.click;
    }

    return SystemMouseCursors.basic;
  }

  @override
  PlutoGridStateManager get stateManager => widget.stateManager;

  @override
  void initState() {
    super.initState();

    updateState();
  }

  @override
  void updateState() {
    _sort = update<PlutoColumnSort>(
      _sort,
      widget.column.sort,
    );
  }

  void _showContextMenu(BuildContext context, Offset position) async {
    final selected = await showColumnMenu(
      context: context,
      position: position,
      backgroundColor: stateManager.style.menuBackgroundColor,
      items: stateManager.columnMenuDelegate.buildMenuItems(
        stateManager: stateManager,
        column: widget.column,
      ),
    );

    stateManager.columnMenuDelegate.onSelected(
      context: context,
      stateManager: stateManager,
      column: widget.column,
      mounted: mounted,
      selected: selected,
    );
  }

  void _handleOnPointDown(PointerDownEvent event) {
    _isPointMoving = false;

    _columnRightPosition = event.position;
  }

  void _handleOnPointMove(PointerMoveEvent event) {
    _isPointMoving = true;

    final moveOffset = event.position.dx - _columnRightPosition.dx;
    final bool isLTR = stateManager.isLTR;

    stateManager.resizeColumn(widget.column, isLTR ? moveOffset : -moveOffset);

    _columnRightPosition = event.position;
  }

  void _handleOnPointUp(PointerUpEvent event) {
    if (_isPointMoving) {
      stateManager.updateCorrectScrollOffset();
    } else if (mounted && widget.column.enableContextMenu) {
      _showContextMenu(context, event.position);
    }

    _isPointMoving = false;
  }

  @override
  Widget build(BuildContext context) {
    final columnWidget = _BuildSortableWidget(
      stateManager: stateManager,
      column: widget.column,
      child: _BuildColumnWidget(
        stateManager: stateManager,
        column: widget.column,
        height: widget.height,
      ),
    );

    late final  contextMenuIcon ;

    if (widget.column.title==""){
       contextMenuIcon = Container(
        height: widget.height,
        alignment: Alignment.center,
        child: SizedBox(),
      );
    } else {
      contextMenuIcon = Container(
        height: widget.height,
        alignment: Alignment.center,
        child: PlutoGridColumnIcon2(
          sort: _sort,
          color: stateManager.configuration!.style.iconColor,
          icon: widget.column.enableContextMenu
              ? stateManager.configuration!.style.columnContextIcon
              : stateManager.configuration!.style.columnResizeIcon,
        ),
      );
    }

    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          child: widget.column.enableColumnDrag
              ? _BuildDraggableWidget(
                  stateManager: stateManager,
                  column: widget.column,
                  child: columnWidget,
                )
              : columnWidget,
        ),

          Positioned.directional(
            textDirection: stateManager.textDirection,
            start: -6, ///v  отступ стрелок сортировки
            top:8, ///v
            child: enableGesture
                ? Listener(
                    onPointerDown: _handleOnPointDown,
                    onPointerMove: _handleOnPointMove,
                    onPointerUp: _handleOnPointUp,
                    child: contextMenuIcon,
                  )
                : contextMenuIcon,
          ),
      ],
    );
  }
}

class PlutoGridColumnIcon extends StatelessWidget {
  final PlutoColumnSort? sort;

  final Color color;

  final IconData icon;

  const PlutoGridColumnIcon({
    this.sort,
    this.color = Colors.black26,
    this.icon = Icons.dehaze,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (sort) {
      case PlutoColumnSort.ascending:
        return Transform.rotate(
          angle: 90 * pi / 90,
          child: const Icon(
            Icons.sort,
            color: Colors.green,
          ),
        );
      case PlutoColumnSort.descending:
        return const Icon(
          Icons.sort,
          color: Colors.red,
        );
      default:
        return Icon(
          icon,
          color: color,
        );
    }
  }
}



///v  другой дизайн стрелок сортировки
class PlutoGridColumnIcon2 extends StatelessWidget {
  final PlutoColumnSort? sort;

  final Color color;

  final IconData icon;

  const PlutoGridColumnIcon2({
    this.sort,
    this.color = Colors.black26,
    this.icon = Icons.dehaze,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.topLeft,
          height: 10,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_drop_up,
            ),
            onPressed: () {},
            iconSize: 22,
            color: sort == PlutoColumnSort.ascending ? Color(0xFF0F8BD1):Color(0xFFCECECF), /// v
            // color: Colors.grey,
            padding: const EdgeInsets.all(0),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          height: 10,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_drop_down,
            ),
            onPressed: () {},
            iconSize: 22,
            color: sort == PlutoColumnSort.descending ? Color(0xFF0F8BD1):Color(0xFFCECECF), /// v
            padding: const EdgeInsets.all(0),
          ),
        ),
      ],
    );




  }
}

class _BuildDraggableWidget extends StatelessWidget {
  final PlutoGridStateManager stateManager;

  final PlutoColumn column;
  final Widget child;

  const _BuildDraggableWidget({
    required this.stateManager,
    required this.column,
    required this.child,
    Key? key,
  }) : super(key: key);

  void _handleOnPointerMove(PointerMoveEvent event) {
    stateManager.eventManager!.addEvent(PlutoGridScrollUpdateEvent(
      offset: event.position,
      scrollDirection: PlutoGridScrollUpdateDirection.horizontal,
    ));
  }

  void _handleOnPointerUp(PointerUpEvent event) {
    PlutoGridScrollUpdateEvent.stopScroll(
      stateManager,
      PlutoGridScrollUpdateDirection.horizontal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: _handleOnPointerMove,
      onPointerUp: _handleOnPointerUp,
      child: Draggable<PlutoColumn>(
        data: column,
        dragAnchorStrategy: pointerDragAnchorStrategy,
        feedback: FractionalTranslation(
          translation: const Offset(-0.5, -0.5),
          child: PlutoShadowContainer(
            alignment: column.titleTextAlign.alignmentValue,
            width: PlutoGridSettings.minColumnWidth,
            height: stateManager.columnHeight,
            backgroundColor:
                stateManager.configuration!.style.gridBackgroundColor,
            borderColor: stateManager.configuration!.style.gridBorderColor,
            child: Text(
              column.title,
              style: stateManager.configuration!.style.columnTextStyle.copyWith(
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}

class _BuildSortableWidget extends StatelessWidget {
  final PlutoGridStateManager? stateManager;

  final PlutoColumn? column;

  final Widget? child;

  const _BuildSortableWidget({
    Key? key,
    this.stateManager,
    this.column,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return column!.enableSorting
        ? InkWell(
            onTap: () {
              stateManager!.toggleSortColumn(column!);
            },
            child: child,
          )
        : child!;
  }
}

class _BuildColumnWidget extends StatelessWidget {
  final PlutoGridStateManager stateManager;

  final PlutoColumn column;

  final double height;

  const _BuildColumnWidget({
    required this.stateManager,
    required this.column,
    required this.height,
    Key? key,
  }) : super(key: key);

  EdgeInsets get padding =>
      column.titlePadding ??
      stateManager.configuration!.style.defaultColumnTitlePadding;

  bool get showSizedBoxForIcon =>
      column.isShowRightIcon &&
      (column.titleTextAlign.isRight || stateManager.isRTL);

  @override
  Widget build(BuildContext context) {
    return DragTarget<PlutoColumn>(
      onWillAccept: (PlutoColumn? columnToDrag) {
        return columnToDrag != null &&
            columnToDrag.key != column.key &&
            !stateManager.limitMoveColumn(
              column: columnToDrag,
              targetColumn: column,
            );
      },
      onAccept: (PlutoColumn columnToMove) {
        if (columnToMove.key != column.key) {
          stateManager.moveColumn(column: columnToMove, targetColumn: column);
        }
      },
      builder: (dragContext, candidate, rejected) {
        final bool noDragTarget = candidate.isEmpty;

        final style = stateManager.style;

        ///v todo: сделать по человечи отрисовку полосок
        bool needBorder =false;
        if (stateManager.configuration!.linesForFields != null) {
          needBorder = stateManager.configuration!.linesForFields!.contains(column.field);
        }


        return Container(
          width: column.width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: noDragTarget
                ? column.backgroundColor
                : style.dragTargetColumnColor,
            border: BorderDirectional(
              end: style.enableColumnBorderVertical && needBorder
                  ? BorderSide(color: style.borderColor, width: 1.0)
                  : BorderSide.none,
            ),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                if (column.enableRowChecked)
                  _CheckboxAllSelectionWidget(
                    column: column,
                    stateManager: stateManager,
                  ),
                Expanded(
                  child: _ColumnTextWidget(
                    column: column,
                    stateManager: stateManager,
                    height: height,
                  ),
                ),
                if (showSizedBoxForIcon) SizedBox(width: style.iconSize),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CheckboxAllSelectionWidget extends PlutoStatefulWidget {
  final PlutoGridStateManager stateManager;

  final PlutoColumn? column;

  const _CheckboxAllSelectionWidget({
    required this.stateManager,
    this.column,
    Key? key,
  }) : super(key: key);

  @override
  _CheckboxAllSelectionWidgetState createState() =>
      _CheckboxAllSelectionWidgetState();
}

class _CheckboxAllSelectionWidgetState
    extends PlutoStateWithChange<_CheckboxAllSelectionWidget> {
  bool? _checked;

  @override
  PlutoGridStateManager get stateManager => widget.stateManager;

  @override
  void initState() {
    super.initState();

    updateState();
  }

  @override
  void updateState() {
    _checked = update<bool?>(
      _checked,
      stateManager.tristateCheckedRow,
    );
  }

  void _handleOnChanged(bool? changed) {
    if (changed == _checked) {
      return;
    }

    changed ??= false;

    if (_checked == null) {
      changed = true;
    }

    stateManager.toggleAllRowChecked(changed);

    if (stateManager.onRowChecked != null) {
      stateManager.onRowChecked!(
        PlutoGridOnRowCheckedAllEvent(isChecked: changed),
      );
    }

    setState(() {
      _checked = changed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlutoScaledCheckbox(
      value: _checked,
      handleOnChanged: _handleOnChanged,
      tristate: true,
      scale: 0.86,
      unselectedColor: stateManager.configuration!.style.iconColor,
      activeColor: stateManager.configuration!.style.activatedBorderColor,
      checkColor: stateManager.configuration!.style.activatedColor,
    );
  }
}

class _ColumnTextWidget extends PlutoStatefulWidget {
  final PlutoGridStateManager stateManager;

  final PlutoColumn column;

  final double height;

  const _ColumnTextWidget({
    required this.stateManager,
    required this.column,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  _ColumnTextWidgetState createState() => _ColumnTextWidgetState();
}

class _ColumnTextWidgetState extends PlutoStateWithChange<_ColumnTextWidget> {
  bool _isFilteredList = false;

  @override
  PlutoGridStateManager get stateManager => widget.stateManager;

  @override
  void initState() {
    super.initState();

    updateState();
  }

  @override
  void updateState() {
    _isFilteredList = update<bool>(
      _isFilteredList,
      stateManager.isFilteredColumn(widget.column),
    );
  }

  void _handleOnPressedFilter() {
    stateManager.showFilterPopup(
      context,
      calledColumn: widget.column,
    );
  }

  String? get _title =>
      widget.column.titleSpan == null ? widget.column.title : null;

  List<InlineSpan> get _children => [
        if (widget.column.titleSpan != null) widget.column.titleSpan!,
        if (_isFilteredList)
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: IconButton(
              icon: Icon(
                Icons.filter_alt_outlined,
                color: stateManager.configuration!.style.iconColor,
                size: stateManager.configuration!.style.iconSize,
              ),
              onPressed: _handleOnPressedFilter,
              constraints: BoxConstraints(
                maxHeight:
                    widget.height + (PlutoGridSettings.rowBorderWidth * 2),
              ),
            ),
          ),
      ];

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: _title,
        children: _children,
      ),
      style: stateManager.configuration!.style.columnTextStyle,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
      maxLines: 1,
      textAlign: widget.column.titleTextAlign.value,
    );
  }
}
