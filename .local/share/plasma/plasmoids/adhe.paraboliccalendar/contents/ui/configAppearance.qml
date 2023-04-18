/*
 * Copyright 2013  Bhushan Shah <bhush94@gmail.com>
 * Copyright 2013 Sebastian Kügler <sebas@kde.org>
 * Copyright 2015 Kai Uwe Broulik <kde@privat.broulik.de>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License or (at your option) version 3 or any later version
 * accepted by the membership of KDE e.V. (or its successor approved
 * by the membership of KDE e.V.), which shall act as a proxy
 * defined in Section 14 of version 3 of the license.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>
 */

import QtQuick 2.0
import QtQuick.Controls 2.3 as QtControls
import QtQuick.Layouts 1.0 as QtLayouts
import org.kde.plasma.calendar 2.0 as PlasmaCalendar
import org.kde.kquickcontrolsaddons 2.0
import org.kde.kirigami 2.5 as Kirigami

QtLayouts.ColumnLayout {
    id: appearancePage

    signal configurationChanged

    property string cfg_fontFamily
    property alias cfg_boldText: boldCheckBox.checked
    property alias cfg_italicText: italicCheckBox.checked

    property alias cfg_fixedFont: fixedFont.checked
    property alias cfg_fontSize: fontSize.value
    property alias cfg_ndays: ndays.value
    property alias cfg_mirror: mirror.checked
    property alias cfg_background: background.currentIndex


    onCfg_fontFamilyChanged: {
        // HACK by the time we populate our model and/or the ComboBox is finished the value is still undefined
        if (cfg_fontFamily) {
            for (var i = 0, j = fontsModel.count; i < j; ++i) {
                if (fontsModel.get(i).value === cfg_fontFamily) {
                    fontFamilyComboBox.currentIndex = i
                    break
                }
            }
        }
    }

    ListModel {
        id: fontsModel
        Component.onCompleted: {
            var arr = [] // use temp array to avoid constant binding stuff
            arr.push({text: i18nc("Use default font", "Default"), value: ""})

            var fonts = Qt.fontFamilies()
            var foundIndex = 0
            for (var i = 0, j = fonts.length; i < j; ++i) {
                arr.push({text: fonts[i], value: fonts[i]})
            }
            append(arr)
        }
    }



    Kirigami.FormLayout {
        QtLayouts.Layout.fillWidth: true

        Item {
            Kirigami.FormData.isSection: true
        }

        QtLayouts.RowLayout {
            QtLayouts.Layout.fillWidth: true

            Kirigami.FormData.label: i18n("Background")

            QtControls.ComboBox {
                id: background
                model: [
                    i18n("No background"),
                    i18n("Standard background"),
                    i18n("Translucent Background"),
                    i18n("Shadow Background"),
                    i18n("No background and shadow"),
                ]
                onActivated: cfg_background = currentIndex
            }
        }

        QtLayouts.RowLayout {
            QtLayouts.Layout.fillWidth: true

            Kirigami.FormData.label: i18n("Around days:")

            QtControls.SpinBox {
                id: ndays
                from: 2
                to: 15
                editable: true
                validator: IntValidator {
                    locale: ndays.locale.name
                    bottom: Math.min(fontSize.from, ndays.to)
                    top: Math.max(ndays.from, ndays.to)
                }
            }
        }

        QtLayouts.RowLayout {
            QtLayouts.Layout.fillWidth: true

            Kirigami.FormData.label: i18n("Mirror RTL:")
            Kirigami.FormData.buddyFor: mirror

            QtControls.CheckBox {
                id: mirror
            }
        }




        QtLayouts.RowLayout {
            QtLayouts.Layout.fillWidth: true

            Kirigami.FormData.label: i18n("Font style:")

            QtControls.ComboBox {
                id: fontFamilyComboBox
                QtLayouts.Layout.fillWidth: true
                currentIndex: 0
                // ComboBox's sizing is just utterly broken
                QtLayouts.Layout.minimumWidth: units.gridUnit * 10
                model: fontsModel
                // doesn't autodeduce from model because we manually populate it
                textRole: "text"

                onCurrentIndexChanged: {
                    var current = model.get(currentIndex)
                    if (current) {
                        cfg_fontFamily = current.value
                        appearancePage.configurationChanged()
                    }
                }
            }

            QtControls.Button {
                id: boldCheckBox
                QtControls.ToolTip {
                    text: i18n("Bold text")
                }
                icon.name: "format-text-bold"
                checkable: true
                Accessible.name: QtControls.ToolTip.text
            }

            QtControls.Button {
                id: italicCheckBox
                QtControls.ToolTip {
                    text: i18n("Italic text")
                }
                icon.name: "format-text-italic"
                checkable: true
                Accessible.name: QtControls.ToolTip.text
            }
        }


        QtLayouts.RowLayout {
            QtLayouts.Layout.fillWidth: true

            Kirigami.FormData.label: i18n("Panel font size:")
            Kirigami.FormData.buddyFor: fontSize

            QtControls.CheckBox {
                id: fixedFont
                text: i18n("Use fixed font size")
            }

            QtControls.SpinBox {
                id: fontSize
                enabled: cfg_fixedFont
                from: 1
                to: 60
                editable: true
                validator: IntValidator {
                    locale: fontSize.locale.name
                    bottom: Math.min(fontSize.from, fontSize.to)
                    top: Math.max(fontSize.from, fontSize.to)
                }
            }
        }
    }
    Item {
        QtLayouts.Layout.fillHeight: true
    }

    Component.onCompleted: {

    }
}
