-- Interface.lua
Interface = {}

-- Button-Class
PanelButton = class ( Turbine.UI.Button );

function PanelButton:Constructor()
    Turbine.UI.Button.Constructor( self );
    self:SetBackColor ( Turbine.UI.Color (0.2, 0.2, 0.2));
    self:SetSize ( 40, 30 );

    self.MouseDown = function (sender, args)
        sender:SetBackColor(Turbine.UI.Color (0.1, 0.1, 0.1));
    end

    self.MouseUp = function (sender, args)
        sender:SetBackColor(Turbine.UI.Color (0.2, 0.2, 0.2));
    end
end

-- Erzeugt einheitliches Fenster-Design
Interface.setStandardDesign = function(designElement)
    local mainBackClr = Turbine.UI.Color(0, 0, 0)
    designElement:SetVisible(true)
    designElement:SetBackColor(mainBackClr)
    designElement:SetOpacity(0.6)
end

local innerPadding = 10

local function viewHide() 
    if (Interface.mainWindow:IsVisible()) then
        return "hide"
    else
        return "show"
    end
end

Interface.mainWindow = Turbine.UI.Window()
Interface.setStandardDesign(Interface.mainWindow)
Interface.mainWindow:SetSize(300, 40)
Interface.mainWindow:SetPosition(900, 30)

Interface.targetLabel = Turbine.UI.Label()
Interface.targetLabel:SetParent(Interface.mainWindow)
Interface.targetLabel:SetPosition(innerPadding, innerPadding)
Interface.targetLabel:SetSize(300, 50)

-- Funktion, um das Label-Textfeld zu aktualisieren
function Interface.updateLabelText(text)
    Turbine.Shell.WriteLine("updateLabelText springt an")
    Interface.targetLabel:SetText(table.concat(text, "\n"))
end

Interface.presentMenu = Turbine.UI.Window()
Interface.setStandardDesign(Interface.presentMenu)
Interface.presentMenu:SetSize(50, 100);
Interface.presentMenu:SetPosition(00, 300)

Interface.mainSwitchButton = PanelButton()
Interface.mainSwitchButton:SetParent(Interface.presentMenu)
Interface.mainSwitchButton:SetVisible(true)
Interface.mainSwitchButton:SetPosition (5, 5)
Interface.mainSwitchButton:SetText(viewHide())

Interface.mainSwitchButton.Click = function( sender, args )
    local current = Interface.mainWindow:IsVisible()
    Interface.mainWindow:SetVisible(not current)
    Interface.mainSwitchButton:SetText(viewHide())
end


