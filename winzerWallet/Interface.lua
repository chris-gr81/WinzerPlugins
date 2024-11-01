-- Interface.lua

-- Klassenimporte
classDir = "WinzerPlugins.winzerWallet.classes.";
import (classDir.."PanelButton")
import (classDir.."BasicWindow")
import (classDir.."TextLabel")

Interface = {}
Interface.menuCheckboxElements = {}
Turbine.Shell.WriteLine("menuCheckboxElements is a table")

-- Hauptfenster und Label
Interface.mainWindow = BasicWindow(400, 100, 900, 30, true)
Interface.mainLabel = TextLabel(Interface.mainWindow)

-- Funktion zum Aktualisieren des Labels
function Interface.updateLabelText(text)
    -- Überprüfe, ob der Input ein String ist, und setze ihn direkt
    if type(text) == "string" then
        Interface.mainLabel:SetText(text)
    else
        -- Falls aus Versehen eine Tabelle übergeben wird, konkatenieren
        Interface.mainLabel:SetText(table.concat(text, "\n"))
    end
end

-- Funktion zur dynamischen Anpassung des mainWindow und Label
function Interface.UpdateMainWindowLayout(wishedItems)
    local rowHeight = 12
    local numRows = #wishedItems
    local windowHeight = numRows * rowHeight

    -- Setze die Höhe für mainWindow und mainLabel basierend auf der Anzahl der true-Einträge
    Interface.mainWindow:SetHeight(windowHeight + 20)
    Interface.mainLabel:SetHeight(windowHeight)

    -- Aktualisiere die Label-Anzeige basierend auf wishedItems
    Interface.updateLabelText(Wallet.updateMainWindowContent())
end

-- Menüfenster und Label
Interface.menuWindow = BasicWindow(500,500, 50, 150, false)
Interface.menuCheckBoxElements = {}

-- Funktion zum Aktualisieren der Checkbox-Elemente
function Interface:UpdateMenuCheckboxes()
    if not Interface.menuCheckboxElements then
        Interface.menuCheckboxElements = {}  -- Fallback-Initialisierung
    end
    
    Turbine.Shell.WriteLine("Updating menu checkboxes...")  -- Debug-Ausgabe

    for _, element in ipairs(Interface.menuCheckboxElements) do
        element:SetVisible(false)
    end

    -- Rufe die Checkbox-Buttons über Menu auf
    Interface.menuCheckboxElements = Menu:CreateCheckBoxButtons(Interface.menuWindow)
    Turbine.Shell.WriteLine("Checkbox elements count: " .. #Interface.menuCheckboxElements)
end

-- Sidebar mit Buttons
Interface.sideBar = BasicWindow(50, 75, 0, 300, true)

-- Main-Switch-Button
Interface.mainSwitchButton = PanelButton(5, 5, true, Interface.sideBar)
Interface.mainSwitchButton:SetText(
    Interface.mainWindow:IsVisible() and "hide" or "show")

-- Click-Event für das Umschalten der Sichtbarkeit
Interface.mainSwitchButton.Click = function( sender, args )
    local current = Interface.mainWindow:IsVisible()
    Interface.mainWindow:SetVisible(not current)
    Interface.mainSwitchButton:SetText(current and "show" or "hide")
end

-- MenüButton
Interface.menuButton = PanelButton(5, 40, true, Interface.sideBar)
Interface.menuButton:SetText("menu")

-- Click-Event für das Einblenden des Menüs
Interface.menuButton.Click = function(sender, args)
    local current = Interface.menuWindow:IsVisible()
    Interface.menuWindow:SetVisible(not current)

    -- Checkboxen aktualisieren, wenn das Menüfenster sichtbar gemacht wird
    if Interface.menuWindow:IsVisible() then
        Interface:UpdateMenuCheckboxes()
    end
end



