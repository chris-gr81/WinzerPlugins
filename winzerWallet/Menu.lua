import (AppDir.."discOperations")

Menu = {}
Menu.itemList = {}

-- Funktion zum Design für ausgewählte Checkbox
function Menu:SetTrueCheckboxDesign(button)
    button:SetBackColor(Turbine.UI.Color(0.6, 0.6, 0.6))
    button:SetOpacity(0.6)
end

-- Funktion zum Design für nicht ausgewählte Checkbox
function Menu:SetFalseCheckboxDesign(button)
    button:SetBackColor(Turbine.UI.Color(0.2, 0.2, 0.2))
    button:SetOpacity(0.6)
end

-- Funktion zum Speichern der gewünschten Items-Status über discOperations
function Menu:SaveWishedItems()
    DiscOperations.SaveWishedItems(self.itemList)
end

-- Initialisiere itemList basierend auf Wallet-Daten
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

-- Lädt die gespeicherten wishedItems und gleicht sie ab
function Menu:LoadWishedItemsAndSync()
    DiscOperations.LoadWishedItems(function(savedItems)
        -- Setze den isSelected-Status auf Basis der gespeicherten Items
        for _, item in ipairs(self.itemList) do
            item.isSelected = false  -- Standardmäßig auf false setzen
            for _, savedItem in ipairs(savedItems) do
                if item.name == savedItem then
                    item.isSelected = true
                    break
                end
            end
        end
    end)
end

-- Funktion zum Erstellen der Checkbox-Buttons und Labels
function Menu:CreateCheckBoxButtons(parent)
    local elements = {}
    local yPosition = 5
    local itemHeight = 20

    for _, item in ipairs(self.itemList) do
        local checkboxButton = PanelButton(5, yPosition, true, parent) 
        checkboxButton:SetSize(10, 10)

        -- Setze das Design abhängig von isSelected
        if item.isSelected then
            self:SetTrueCheckboxDesign(checkboxButton)
        else
            self:SetFalseCheckboxDesign(checkboxButton)
        end

        -- Eventhandler zum Umschalten von isSelected und Speichern der Daten
        checkboxButton.Click = function(sender, args)
            item.isSelected = not item.isSelected
            if item.isSelected then
                self:SetTrueCheckboxDesign(sender) 
            else
                self:SetFalseCheckboxDesign(sender) 
            end

            -- Speichern und direktes Aktualisieren des mainWindows
            self:SaveWishedItems()
            UpdateWishedItemsAndRefresh()  -- Aktualisiere das Interface
        end

        -- Erstelle ein Label für den Item-Text
        local itemLabel = TextLabel(parent) 
        itemLabel:SetPosition(20, yPosition)
        itemLabel:SetSize(500, 15)
        itemLabel:SetText(item.name .. " (" .. item.quantity ..")")

        table.insert(elements, checkboxButton)
        table.insert(elements, itemLabel)

        yPosition = yPosition + itemHeight
    end

    local totalHeight = #self.itemList * itemHeight + 10
    parent:SetHeight(totalHeight)

    return elements
end

-- Funktion, um alle ausgewählten Items zurückzugeben
function Menu:GetWishedItems()
    local wishedItems = {}
    for _, item in ipairs(self.itemList) do
        if item.isSelected then
            table.insert(wishedItems, item.name)
        end
    end
    return wishedItems
end
