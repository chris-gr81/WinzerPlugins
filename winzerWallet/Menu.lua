-- Menu.lua

Menu = {}
Menu.itemList = {}

-- Stelle sicher, dass Wallet und pWall definiert ist und pWall Elemente enthält
local walletSize = Wallet.pWall:GetSize()
Turbine.Shell.WriteLine(walletSize .. " Items gefunden")

for i = 1, walletSize do
    local item = Wallet.pWall:GetItem(i)
    if item then
        table.insert(Menu.itemList, {
            name = item:GetName(),
            quantity = item:GetQuantity(),
            isSelected = false
        })
    end
end

-- Design für die ausgewählte Checkbox
function Menu:SetTrueCheckboxDesign(button)
    button:SetBackColor(Turbine.UI.Color(0.6, 0.6, 0.6))
    button:SetOpacity(0.6)
end

-- Design für die nicht ausgewählte Checkbox
function Menu:SetFalseCheckboxDesign(button)
    button:SetBackColor(Turbine.UI.Color(0.2, 0.2, 0.2))
    button:SetOpacity(0.6)
end

-- Funktion zum Erstellen der Checkbox-Buttons und Labels und dynamische Anpassung der Fensterhöhe
function Menu:CreateCheckBoxButtons(parent)
    local elements = {}
    local yPosition = 5
    local itemHeight = 20  -- Höhe für jedes Item (Checkbox + Label)

    for _, item in ipairs(self.itemList) do
        -- Erstelle einen Button als Checkbox 
        local checkboxButton = PanelButton(5, yPosition, true, parent) 
        checkboxButton:SetSize(10, 10)

        -- Setze das Design abhängig von isSelected
        if item.isSelected then
            self:SetTrueCheckboxDesign(checkboxButton)
        else
            self:SetFalseCheckboxDesign(checkboxButton)
        end

        -- Eventhandler zum Umschalten von isSelected
        checkboxButton.Click = function(sender, args)
            item.isSelected = not item.isSelected
            if item.isSelected then
                self:SetTrueCheckboxDesign(sender) 
            else
                self:SetFalseCheckboxDesign(sender) 
            end

            -- Rufe die Aktualisierungsfunktion in Main.lua auf 
            UpdateWishedItemsAndRefresh()
        end

        -- Erstelle ein Label für den Item-Text
        local itemLabel = TextLabel(parent) 
        itemLabel:SetPosition(20, yPosition)
        itemLabel:SetSize(500, 15)
        itemLabel:SetText(item.name .. " (" .. item.quantity ..")")

        -- Element zur Liste hinzufügen
        table.insert(elements, checkboxButton)
        table.insert(elements, itemLabel)

        yPosition = yPosition + itemHeight  -- Abstand für das nächste Item
    end

    -- Passe die Höhe des Elternfensters an die Anzahl der Items an
    local totalHeight = #self.itemList * itemHeight + 10  -- 10 Pixel Puffer oben und unten
    parent:SetHeight(totalHeight)

    return elements
end

-- Funtkion, um alle ausgewählten Items zurückzugeben
function Menu:GetWishedItems()
    local wishedItems = {}
    for _, item in ipairs(self.itemList) do
        if item.isSelected then
            table.insert(wishedItems, item.name)
        end
    end
    return wishedItems
end
