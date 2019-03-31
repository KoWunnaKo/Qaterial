/** Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com */

import QtQuick 2.12
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Components 1.12
import QQuickMaterialHelper.Style 1.12

Item
{
    id: root

    Component
    {
        id: _dialogComp
        AlertIconDialog
        {
            id: _dialog

            text: root.settings && root.settings.text ? root.settings.text : ""
            title: root.settings && root.settings.title ? root.settings.title : ""

            Component.onCompleted:
            {
                if(root.settings && root.settings.iconSource)
                    iconSource = root.settings.iconSource
                if(root.settings && root.settings.iconColor)
                    iconColor = root.settings.iconColor
                if(root.settings && root.settings.standardButtons)
                   standardButtons = root.settings.standardButtons

                open()
            }

            onAccepted: 
            {
                if(root.settings && root.settings.acceptedCallback)
                    root.settings.acceptedCallback()
            }

            onApplied: 
            {
                if(root.settings && root.settings.appliedCallback)
                    root.settings.appliedCallback()
            }

            onHelpRequested: 
            {
                if(root.settings && root.settings.helpRequestedCallback)
                    root.settings.helpRequestedCallback()
            }

            onRejected:
            {
                if(root.settings && root.settings.rejectedCallback)
                    root.settings.rejectedCallback()       
            }

            onClosed:
            {
                root.settings = null
                _dialogLoader.sourceComponent = undefined
            }
        }
    }

    Loader
    {
        id: _dialogLoader
    }

    property var settings: null
    
    function openWithSettings(dialogManagerSettings)
    {
        // 1) Close if already open
        if(_dialogLoader.sourceComponent)
            _dialogLoader.sourceComponent = undefined

        // 2) Keep settings in memory
        settings = dialogManagerSettings

        // 3) Open the dialog
        _dialogLoader.sourceComponent = _dialogComp
    }
} // Item
