-- PanelButton.lua

-- PanelButton-Class
PanelButton = class(Turbine.UI.Button)

function PanelButton:Constructor(posY, posX, vis, parent)
    Turbine.UI.Button.Constructor(self)
    self:SetParent( parent )
    self:SetBackColor ( Turbine.UI.Color (0.2, 0.2, 0.2) );
    self:SetSize( 40, 30 );
    self:SetPosition( posY, posX )
    self:SetVisible ( vis )

    self.MouseDown = function (sender, args)
        sender:SetBackColor ( Turbine.UI.Color (0.1, 0.1, 0.1) );
    end

    self.MouseUp = function(sender, args)
        sender:SetBackColor ( Turbine.UI.Color (0.2, 0.2, 0.2) );
    end
end

_G.PanelButton = PanelButton