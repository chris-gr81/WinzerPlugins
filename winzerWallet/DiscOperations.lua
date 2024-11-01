-- DiscOperations.lua

DiscOperations = {}

-- Funktion zur Konvertierung einer Tabelle in eine JSON-ähnliche String-Repräsentation
local function tableToString(itemList)
    local str = "{"
    for i, item in ipairs(itemList) do
        str = str .. '"' .. item .. '"'
        if i < #itemList then
            str = str .. ", "
        end
    end
    return str .. "}"
end

-- Funktion zum Parsen des gespeicherten Strings in eine Tabelle
local function stringToTable(str)
    local items = {}
    for item in str:gmatch('"(.-)"') do
        table.insert(items, item)
    end
    return items
end

-- Speichert die true-markierten wishedItems als String
function DiscOperations.SaveWishedItems(itemList)
    -- Extrahiere die Namen der auf true gesetzten Items
    local selectedItems = {}
    for _, item in ipairs(itemList) do
        if item.isSelected then
            table.insert(selectedItems, item.name)
        end
    end

    -- Konvertiere die Tabelle in einen JSON-ähnlichen String
    local selectedItemsStr = tableToString(selectedItems)

    -- Speichern des Strings
    Turbine.PluginData.Save(Turbine.DataScope.Character, "winzerWallet_wishedItems", selectedItemsStr, function(status)
        if status then
            Turbine.Shell.WriteLine("Wished Items erfolgreich für den Charakter gespeichert!")
        else
            Turbine.Shell.WriteLine("Fehler beim Speichern der Wished Items.")
        end
    end)
end

-- Lädt die Namen der auf true gesetzten wishedItems und konvertiert sie in eine Tabelle
function DiscOperations.LoadWishedItems(callback)
    Turbine.PluginData.Load(Turbine.DataScope.Character, "winzerWallet_wishedItems", function(loadedData)
        if loadedData and type(loadedData) == "string" then
            local loadedItems = stringToTable(loadedData)
            Turbine.Shell.WriteLine("Wished Items erfolgreich geladen: " .. table.concat(loadedItems, ", "))
            callback(loadedItems)
        else
            Turbine.Shell.WriteLine("Keine gespeicherten Wished Items gefunden.")
            callback({})
        end
    end)
end

_G.DiscOperations = DiscOperations
