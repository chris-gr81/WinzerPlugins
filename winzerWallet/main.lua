-- Main.lua
import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "Turbine.Gameplay";

AppDir = "WinzerPlugins.winzerWallet.";

-- Importiere die Module und stelle sie global zur Verfügung
import (AppDir.."Interface")
import (AppDir.."Wallet")

Wallet.wishedItems = { "Herbstfest-Medaille", "Arnorische Bronzemünze" }

-- Initialisiere das Interface und aktualisiere den Inhalt
Interface.updateLabelText(Wallet.updateMainWindowContent(Wallet.wishedItems))
Wallet.registerQuantityChangedHandlers(function(text) Interface.updateLabelText(text) end, Wallet.wishedItems)

Wallet.pWall.ItemAdded = function(sender, args)
    local text = Wallet.updateMainWindowContent()

    Interface.updateLabelText(text)
    Wallet.registerQuantityChangedHandlers(function(newText) Interface.updateLabelText(newText) end) 
end

Wallet.pWall.ItemRemoved = function(sender, args)
    local removedItemName = tostring(args.Item:GetName())
    local text = Wallet.updateMainWindowContent(removedItemName)
    
    Interface.updateLabelText(text)
    Wallet.registerQuantityChangedHandlers(function(newText) Interface.updateLabelText(newText) end)
  
end