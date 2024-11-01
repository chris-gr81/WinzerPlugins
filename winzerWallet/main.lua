-- Main.lua

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "Turbine.Gameplay";

AppDir = "WinzerPlugins.winzerWallet.";

-- Importiere die Module und stelle sie global zur Verfügung
import (AppDir.."Interface")
import (AppDir.."Wallet")
import (AppDir.."Menu")

Wallet.wishedItems = Menu:GetWishedItems()

-- Funktion zur Aktualisierung wishedItems und Layout des Interface
function UpdateWishedItemsAndRefresh()
    Wallet.wishedItems = Menu:GetWishedItems()
    Interface.updateLabelText(Wallet.updateMainWindowContent())
    Wallet.registerQuantityChangedHandlers(function(text)
        Interface.updateLabelText(text)
        Interface.UpdateMainWindowLayout(Wallet.wishedItems)
    end)
    Interface.UpdateMainWindowLayout(Wallet.wishedItems)
end

-- Initialisiere das Interface und aktualisiere den Inhalt
UpdateWishedItemsAndRefresh()

Wallet.pWall.ItemAdded = function(sender, args)
    local text = Wallet.updateMainWindowContent()
    Interface.updateLabelText(text)
    Wallet.registerQuantityChangedHandlers(function(newText)
        Interface.updateLabelText(newText)
        Interface.UpdateMainWindowLayout(Wallet.wishedItems)
    end)
end

Wallet.pWall.ItemRemoved = function(sender, args)
    local removedItemName = tostring(args.Item:GetName())
    local text = Wallet.updateMainWindowContent(removedItemName)
    Interface.updateLabelText(text)
    Wallet.registerQuantityChangedHandlers(function(newText)
        Interface.updateLabelText(newText)
        Interface.UpdateMainWindowLayout(Wallet.wishedItems)
    end)
end
