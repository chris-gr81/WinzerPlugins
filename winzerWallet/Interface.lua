-- Interface.lua

-- Klassenimporte
classDir = "WinzerPlugins.winzerWallet.classes.";
import (classDir.."PanelButton")
import (classDir.."BasicWindow")
import (classDir.."TextLabel")

Interface = {}

-- Hauptfenster und Label
Interface.mainWindow = BasicWindow(300, 40, 900, 30, true)
Interface.mainLabel = TextLabel(300, 50, 10, 10, Interface.mainWindow)

-- Funktion zum Aktualisieren des Labels
function Interface.updateLabelText(text)
    Interface.mainLabel:SetText(table.concat(text, "\n"))
end

-- Sidebar mit Buttons
Interface.sideBar = BasicWindow(50, 100, 0, 300, true)
Interface.mainSwitchButton = PanelButton(5, 5, true, Interface.sideBar)
Interface.mainSwitchButton:SetText(
    Interface.mainWindow:IsVisible() and "hide" or "show")

-- Click-Event für das Umschalten der Sichtbarkeit
Interface.mainSwitchButton.Click = function( sender, args )
    local current = Interface.mainWindow:IsVisible()
    Interface.mainWindow:SetVisible(not current)
    Interface.mainSwitchButton:SetText(current and "show" or "hide")
end


