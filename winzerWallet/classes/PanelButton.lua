-- PanelButton.lua

-- PanelButton-Class
PanelButton = class(Turbine.UI.Button)

function PanelButton:Constructor()
    Turbine.UI.Button.Constructor(self)
    self:SetBackColor ( Turbine.UI.Color (0.2, 0.2, 0.2) );
    self:SetSize( 40, 30 );

    self.MouseDown = function (sender, args)
        sender:SetBackColor ( Turbine.UI.Color (0.1, 0.1, 0.1) );
    end

    self.MouseUp = function(sender, args)
        sender:SetBackColor ( Turbine.UI.Color (0.2, 0.2, 0.2) );
    end
end

return PanelButton