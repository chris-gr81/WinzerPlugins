-- Wallet.lua
Wallet = {}

local Player = Turbine.Gameplay.LocalPlayer.GetInstance()
Wallet.pWall = Player:GetWallet()
-- Wallet.walletSize = Wallet.pWall:GetSize()
Wallet.foundItems = {}

-- Aktualisiert das Hauptfenster basierend auf den Wallet-Items
function Wallet.updateMainWindowContent(removedItemName)
    Wallet.walletSize = Wallet.pWall:GetSize()
    local text = {}
    Wallet.foundItems = {}  -- Setze gefundene Items zurück

    for i = 1, #Wallet.wishedItems do
        local currentWishedItem = Wallet.wishedItems[i]
        if (removedItemName == currentWishedItem) 
        then
            text[i] = currentWishedItem .. ": 0"
        else
            local found = false

            for j = 1, Wallet.walletSize do
                local currentItem = Wallet.pWall:GetItem(j)
                if currentItem then
                    local currentItemName = tostring(currentItem:GetName())
                    local currentItemQuantity = tostring(currentItem:GetQuantity())

                    if currentItemName == currentWishedItem then
                        text[i] = currentItemName .. ": " .. currentItemQuantity
                        found = true
                        table.insert(Wallet.foundItems, currentItem)
                        break
                    end
                end
            end
            if not found then
            text[i] = Wallet.wishedItems[i] .. ": nichts"
        end
        
        end
    end

    return text
end

-- Dynamische Eventhandler für Quantity-Änderungen registrieren
function Wallet.registerQuantityChangedHandlers(updateLabelText)
    -- Entferne zuerst alte Event-Handler
    for _, item in ipairs(Wallet.foundItems) do 
        item.QuantityChanged = nil    
    end
    -- Füge die neuen Event-Handler hinzu
    for _, item in ipairs(Wallet.foundItems) do
        item.QuantityChanged = function(sender, args)
            updateLabelText(Wallet.updateMainWindowContent(Wallet.wishedItems))
        end
    end
end
