/*
 * Copyright 2013 Heena Mahour <heena393@gmail.com>
 * Copyright 2013 Sebastian Kügler <sebas@kde.org>
 * Copyright 2013 Martin Klapetek <mklapetek@kde.org>
 * Copyright 2014 David Edmundson <davidedmundson@kde.org>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.6
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as Components
import org.kde.plasma.private.digitalclock 1.0
import org.kde.plasma.components 3.0 as PlasmaComponents3

Item {
    id: main

    readonly property bool inPanel: (plasmoid.location === PlasmaCore.Types.TopEdge
                                     || plasmoid.location === PlasmaCore.Types.RightEdge
                                     || plasmoid.location === PlasmaCore.Types.BottomEdge
                                     || plasmoid.location === PlasmaCore.Types.LeftEdge)

    property int ndays: plasmoid.configuration.ndays
    property bool mirror: plasmoid.configuration.mirror
    property string timeFormat



    Layout.minimumHeight: inPanel ? units.gridUnit : rootColumn.implicitHeight
    Layout.maximumHeight: inPanel ? units.gridUnit : rootColumn.implicitHeight
    Layout.minimumWidth:  inPanel ? lbCalendar.implicitWidth + units.smallSpacing * 3 + 22 : rootColumn.implicitWidth + units.largeSpacing
    Layout.maximumWidth:  inPanel ? lbCalendar.implicitWidth + units.smallSpacing * 3 + 22 : rootColumn.implicitWidth + units.largeSpacing

    Connections {
        target: plasmoid.configuration

        onNdaysChanged: {
            myModel.model = []
            myModel.model = plasmoid.configuration.ndays * 2 + 1
            myModel.update()
        }
    }


    ///
    ///
    ///
    ///
    ///
    ///
    ///
    property string labelCalendar

    PlasmaCore.IconItem {
        id: icon
        source: "view-calendar"
        width: 22; height: 22
        visible: inPanel
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: units.smallSpacing
    }

    PlasmaComponents3.Label {
        id: lbCalendar
        anchors.left: icon.right
        anchors.leftMargin: units.smallSpacing
        anchors.verticalCenter: parent.verticalCenter
        text: labelCalendar
        color: theme.textColor
        visible: inPanel
        font.bold: plasmoid.configuration.boldText
        font.family: plasmoid.configuration.fontFamily || theme.defaultFont.family
        horizontalAlignment: Text.AlignHCenterlabelCalendar
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: plasmoid.configuration.fixedFont ? plasmoid.configuration.fontSize : theme.defaultFont.pixelSize

    }

    ///
    ///
    ///
    ///

    TextMetrics {
        id: textMetrics
        elide: Text.ElideMiddle
        elideWidth: 100
        text: "Mon"
        font.pointSize: textMetrics.font.pointSize
        font.family: plasmoid.configuration.fontFamily || theme.defaultFont.family
    }

    TextMetrics {
        id: textMetrics2
        elide: Text.ElideMiddle
        elideWidth: 100
        text: "Sun 30"
        font.pointSize: textMetrics.font.pointSize + 10
        font.family: plasmoid.configuration.fontFamily || theme.defaultFont.family
    }
    ///
    ///
    ///
    ///
    ///

    ColumnLayout{
        id: rootColumn
        spacing: units.smallSpacing
        anchors.fill: parent
        visible: !inPanel
        Repeater {
            id: myModel
            RowLayout{
                Layout.fillWidth: true
                height: index !== ndays ? textMetrics.height * 1.2: textMetrics2.height
                spacing: 0

                LayoutMirroring.enabled: mirror
                property string dayName
                property int dayNumber
                property bool sunday

                Component.onCompleted: {
                    var date = new Date();
                    var last = new Date(date.getTime() + ((-ndays+index) * 24 * 60 * 60 * 1000));
                    dayName = Qt.locale(Qt.locale().uiLanguages[0]).dayName(last.getDay(), Locale.ShortFormat)
                    dayNumber = last.getDate();
                    sunday = last.getDay() === 0

                }
                Rectangle{
                    color: 'transparent'
                    width: textMetrics.width* 2.5
                    height: parent.height
                    Rectangle{
                        id: bar
                        anchors.left: parent.left
                        height: parent.height
                        width: units.smallSpacing * 2
                        color: theme.highlightColor
                        visible: index === ndays && !mirror
                    }
                    PlasmaComponents3.Label {
                        id: lbDay
                        anchors.verticalCenter:  parent.verticalCenter
                        anchors.left:  index === ndays ?  bar.right : parent.left
                        anchors.right: index === ndays ?  bar2.left : parent.right
                        anchors.margins: index === ndays ? units.largeSpacing  : 0
                        horizontalAlignment: mirror ? Qt.AlignRight :  Qt.AlignLeft
                        text: dayName
                        font.pointSize: index === ndays ? textMetrics2.font.pointSize : textMetrics.font.pointSize + 1
                        color: sunday ? theme.highlightColor : theme.textColor
                        font.bold: sunday
                        font.family: textMetrics.font.family
                    }
                    Rectangle{
                        id: bar2
                        anchors.right: parent.right
                        height: parent.height
                        width: units.smallSpacing * 2
                        color: theme.highlightColor
                        visible: index === ndays && mirror
                    }

                }
                Rectangle{
                    color: 'transparent'
                    width: units.gridUnit *  3 // index !== ndays ?  units.gridUnit  : 0 //textMetrics2.width
                    height: parent.height
                    PlasmaComponents3.Label {
                        width: parent.width
                        anchors.verticalCenter: parent.verticalCenter
                        horizontalAlignment: mirror ? Qt.AlignRight :  Qt.AlignLeft
                        font.pointSize: index === ndays ? textMetrics2.font.pointSize : textMetrics.font.pointSize + 1
                        color: index === ndays ? theme.highlightColor : theme.textColor
                        text: dayNumber
                        font.family: textMetrics.font.family
                        x: {
                            var posX = (Math.cos(Math.abs(-ndays + index)*3.14/ndays)) * units.gridUnit * 2.5
                            return posX < 0 ? 0 : (mirror ? -posX : posX)
                        }

                    }
                }
                Item{
                    Layout.fillWidth: mirror
                }

            }
        }
    }

    Timer {
        interval: 10000; running: true; repeat: true
        onTriggered:{
            var date = new Date();
            var txt = date.getDate() + '.' + (date.getMonth()+1)
            if( txt !== labelCalendar){
                labelCalendar = txt
                myModel.model = []
                myModel.model = plasmoid.configuration.ndays * 2 + 1
                myModel.update()
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: plasmoid.expanded = !plasmoid.expanded
    }

    function timeFormatCorrection(timeFormatString) {
        var regexp = /(hh*)(.+)(mm)/i
        var match = regexp.exec(timeFormatString);

        var hours = match[1];
        var delimiter = match[2];
        var minutes = match[3]
        var seconds = "ss";
        var amPm = "AP";
        var uses24hFormatByDefault = timeFormatString.toLowerCase().indexOf("ap") === -1;

        // because QLocale is incredibly stupid and does not convert 12h/24h clock format
        // when uppercase H is used for hours, needs to be h or hh, so toLowerCase()
        var result = hours.toLowerCase() + delimiter + minutes;

        if (main.showSeconds) {
            result += delimiter + seconds;
        }

        // add "AM/PM" either if the setting is the default and locale uses it OR if the user unchecked "use 24h format"
        if ((main.use24hFormat == Qt.PartiallyChecked && !uses24hFormatByDefault) || main.use24hFormat == Qt.Unchecked) {
            result += " " + amPm;
        }

        main.timeFormat = result;
    }

    Component.onCompleted: {
        timeFormatCorrection(Qt.locale().timeFormat(Locale.ShortFormat));
        var date = new Date();
        labelCalendar = date.getDate() + '.' + (date.getMonth()+1)
        myModel.model = plasmoid.configuration.ndays * 2 + 1

    }
}
