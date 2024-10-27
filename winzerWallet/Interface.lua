-- Interface.lua
Interface = {}

mainBackClr = Turbine.UI.Color(0, 0, 0)

Interface.mainWindow = Turbine.UI.Window()
Interface.mainWindow:SetVisible(true)
Interface.mainWindow:SetSize(300, 40)
Interface.mainWindow:SetPosition(900, 30)
Interface.mainWindow:SetBackColor(mainBackClr)
Interface.mainWindow:SetOpacity(0.6)

Interface.targetLabel = Turbine.UI.Label()
Interface.targetLabel:SetParent(Interface.mainWindow)
Interface.targetLabel:SetPosition(10, 10)
Interface.targetLabel:SetSize(300, 50)

-- Funktion, um das Label-Textfeld zu aktualisieren
function Interface.updateLabelText(text)
    Turbine.Shell.WriteLine("updateLabelText springt an")
    Interface.targetLabel:SetText(table.concat(text, "\n"))
end

-- Event-Handler für Doppelklick zum Verstecken des Fensters
Interface.targetLabel.MouseDoubleClick = function(sender, args)
    Interface.mainWindow:SetVisible(false)
end
