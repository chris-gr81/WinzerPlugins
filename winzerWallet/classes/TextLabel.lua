-- TextLabel.lua

-- TextLabel-Klasse
TextLabel = class( Turbine.UI.Label )

function TextLabel:Constructor(sizeY, sizeX, posY, posX, parent)
    Turbine.UI.Label.Constructor(self)
    self:SetParent( parent )
    self:SetSize ( sizeY, sizeX)
    self:SetPosition (posY, posX)
end

_G.TextLabel = TextLabel