-- Interface.lua

-- Klassenimporte
classDir = "WinzerPlugins.winzerWallet.classes.";
import (classDir.."PanelButton")
import (classDir.."BasicWindow")
import (classDir.."TextLabel")

Interface = {}

local function viewHide() 
    if (Interface.mainWindow:IsVisible()) then
        return "hide"
    else
        return "show"
    end
end

Interface.mainWindow = BasicWindow(300, 40, 900, 30, true)
Interface.mainLabel = TextLabel(300, 50, 10, 10, Interface.mainWindow)


-- Funktion, um das Label-Textfeld zu aktualisieren
function Interface.updateLabelText(text)
    Interface.mainLabel:SetText(table.concat(text, "\n"))
end

Interface.sideBar = BasicWindow(50, 100, 0, 300, true)


-- SidebarButton zum switchen der Bar
Interface.mainSwitchButton = PanelButton(5, 5, true, Interface.sideBar)
Interface.mainSwitchButton:SetText(viewHide())

Interface.mainSwitchButton.Click = function( sender, args )
    local current = Interface.mainWindow:IsVisible()
    Interface.mainWindow:SetVisible(not current)
    Interface.mainSwitchButton:SetText(viewHide())
end


