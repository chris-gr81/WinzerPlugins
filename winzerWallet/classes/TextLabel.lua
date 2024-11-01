-- TextLabel.lua

-- TextLabel-Klasse
TextLabel = class( Turbine.UI.Label )

function TextLabel:Constructor(parent)
    Turbine.UI.Label.Constructor(self)
    self:SetParent( parent )

    -- Parent width und height abrufen
    local parentWidth = parent:GetWidth()
    local parentHeight = parent:GetHeight()
    local padding = 10;
    self:SetSize ( (parentWidth - padding*2), (parentHeight - padding*2) )
    self:SetPosition (padding, padding)
    self:SetMouseVisible(false)
    -- self:SetBackColor(Turbine.UI.Color(1, 1, 1))
end

_G.TextLabel = TextLabel