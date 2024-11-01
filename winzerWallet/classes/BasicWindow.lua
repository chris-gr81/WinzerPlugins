-- BasicWindow.lua

-- BasicWindow-Class
BasicWindow = class ( Turbine.UI.Window )

function BasicWindow:Constructor(width, height, x, y, vis)
    Turbine.UI.Window.Constructor(self)  
    self.initialWidth = width
    self.initialHeight = height
    self:SetSize(self.initialWidth, self.initialHeight)
    self:SetPosition(x, y)
    self:SetVisible(vis)
    self:SetBackColor(Turbine.UI.Color(0, 0, 0))
    self:SetOpacity(0.6)

    -- Drag-Funktionalität initialisieren
    self.isDragging = false
    self.dragStartX = 0
    self.dragStartY = 0

    -- MouseDown-Event-Handler
    self.MouseDown = function(sender, args)
        if args.Button == Turbine.UI.MouseButton.Left then
            self.isDragging = true
            self.dragStartX = args.X
            self.dragStartY = args.Y
        end
    end

    -- MouseUp-Event-Handler
    self.MouseUp = function(sender, args)
        if args.Button == Turbine.UI.MouseButton.Left then
            self.isDragging = false
        end
    end

    -- MouseMove-Event-Handler
    self.MouseMove = function(sender, args)
        if self.isDragging then
            local newX = self:GetLeft() + (args.X - self.dragStartX)
            local newY = self:GetTop() + (args.Y - self.dragStartY)
            self:SetPosition(newX, newY)
        end
    end
end

_G.BasicWindow = BasicWindow