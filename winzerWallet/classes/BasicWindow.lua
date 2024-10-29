-- BasicWindow.lua

-- BasicWindwow-Class
BasicWindow = class ( Turbine.UI.Window )

function BasicWindow:Constructor(sizeY, sizeX, posY, posX, vis)
    Turbine.UI.Window.Constructor(self) 
    self:SetBackColor ( Turbine.UI.Color (0, 0, 0) );
    self:SetVisible( vis );
    self:SetOpacity ( 0.6 );
    self:SetSize(sizeY, sizeX)
    self:SetPosition(posY, posX)
end

_G.BasicWindow = BasicWindow