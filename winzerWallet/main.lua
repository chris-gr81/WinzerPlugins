-- Main.lua

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "Turbine.Gameplay";

AppDir = "WinzerPlugins.winzerWallet.";

import (AppDir.."Interface")
import (AppDir.."Wallet")
import (AppDir.."Menu")
import (AppDir.."discOperations")

-- Funktion zur Aktualisierung von wishedItems und Interface
function UpdateWishedItemsAndRefresh()
    Wallet.wishedItems = Menu:GetWishedItems()
    Interface.updateLabelText(Wallet.updateMainWindowContent())
    Wallet.registerQuantityChangedHandlers(function(text)
        Interface.updateLabelText(text)
        Interface.UpdateMainWindowLayout(Wallet.wishedItems)
    end)
    Interface.UpdateMainWindowLayout(Wallet.wishedItems)
end

-- Lädt und synchronisiert die wishedItems beim Start und aktualisiert das Interface
Menu:LoadWishedItemsAndSync()
UpdateWishedItemsAndRefresh()

-- Event für hinzugefügte Items
Wallet.pWall.ItemAdded = function(sender, args)
    local text = Wallet.updateMainWindowContent()
    Interface.updateLabelText(text)
    Wallet.registerQuantityChangedHandlers(function(newText)
        Interface.updateLabelText(newText)
        Interface.UpdateMainWindowLayout(Wallet.wishedItems)
    end)
end

-- Event für entfernte Items
Wallet.pWall.ItemRemoved = function(sender, args)
    local removedItemName = tostring(args.Item:GetName())
    local text = Wallet.updateMainWindowContent(removedItemName)
    Interface.updateLabelText(text)
    Wallet.registerQuantityChangedHandlers(function(newText)
        Interface.updateLabelText(newText)
        Interface.UpdateMainWindowLayout(Wallet.wishedItems)
    end)
end
