import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "Turbine.Gameplay";

mainBackClr = Turbine.UI.Color( 0, 0, 0 );

local mainWindow = Turbine.UI.Window();
mainWindow:SetVisible( true );
mainWindow:SetSize( 300, 40 );
mainWindow:SetPosition( 900, 30 );
mainWindow:SetBackColor( mainBackClr );
mainWindow:SetOpacity( 0.6 );

local targetLabel = Turbine.UI.Label();
targetLabel:SetParent( mainWindow );
targetLabel:SetPosition( 10, 10 );
targetLabel:SetSize( 300, 50 );

local Player = Turbine.Gameplay.LocalPlayer.GetInstance();
local pWall = Player:GetWallet();
local walletSize = pWall:GetSize();

local checkInterval = 2;
local timeSinceLastCheck = 0;

local foundItems = {};

-- Funktion, die beim Ändern der Wallet-Größe ausgeführt wird
local function onWalletSizeChanged(newSize)
    Turbine.Shell.WriteLine("Handler für SizeChange feuert")
    updateMainWindowContent();
    registerQuantityChangedHandlers();
end

-- Funktion zur Überwachung der Wallet-Größe
local function monitorWalletSize()
    local currentSize = pWall:GetSize();

    if currentSize ~= walletSize then
        onWalletSizeChanged(currentSize);
        walletSize = currentSize; -- Aktualisiere den letzten bekannten Zustand
    end
end

local function updateMainWindowContent()
    local wishedItems = { "Herbstfest-Medaille", "Zerfledderter Schatten" }; -- gewünschte Wallet-Items TODO: Dynamisiert ausbauen
    local text = {};
    foundItems = {};  -- Setze foundItems zurück, um neu zu sammeln

    for i = 1, #wishedItems do
        local currentWishedItem = wishedItems[i];
        local found = false;

        for j = 1, walletSize do  
            local currentItem = pWall:GetItem(j);
            -- Um das Wallet in den Chat zu loggen, die nächste Zeile entkommentieren
            -- Turbine.Shell.WriteLine(tostring(currentItem:GetName()));
            local currentItemName = tostring(currentItem:GetName());
            local currentItemQuantity = tostring(currentItem:GetQuantity());

            if currentItemName == currentWishedItem then
                text[i] = currentItemName .. ": " .. currentItemQuantity;
                found = true;

                -- Füge gefundene Items zu foundItems hinzu
                table.insert(foundItems, currentItem);
                break;
            end
        end

        if not found then
            text[i] = wishedItems[i] .. ": nichts";
        end
    end

    -- Update das Label mit allen gefundenen Items
    targetLabel:SetText( table.concat(text, "\n") );
end

-- Dynamische Eventhandler für Quantity-Änderungen registrieren
local function registerQuantityChangedHandlers()
    for _, item in ipairs(foundItems) do
        -- Entferne zuerst alte Handler, um doppelte Registrierungen zu vermeiden
        item.QuantityChanged = nil;

        item.QuantityChanged = function(sender, args)
            Turbine.Shell.WriteLine("Menge von " .. sender:GetName() .. " wurde geändert.");
            updateMainWindowContent();  -- Status aktualisieren
        end
    end
end

-- Initiale Anzeige und Registrierung der Event-Handler
updateMainWindowContent();
registerQuantityChangedHandlers();


-- TODO: Event-Handler auf SetSize


-- Event-Handler für hinzugefügte Items im Wallet
pWall.ItemAdded = function(sender, args)
    updateMainWindowContent();
    registerQuantityChangedHandlers();  -- Event-Handler erneut registrieren
end

-- Event-Handler für entfernte Items im Wallet
pWall.ItemRemoved = function(sender, args)
    updateMainWindowContent();
    registerQuantityChangedHandlers();  -- Event-Handler erneut registrieren
end

-- Doppelklick auf das Label versteckt das Fenster
targetLabel.MouseDoubleClick = function(sender, args)
    mainWindow:SetVisible(false);
end

-- Timer für die regelmäßige Überprüfung
local sizeMonitorTimer = Turbine.UI.Control();
sizeMonitorTimer:SetWantsUpdates(true);

-- Update-Funktion des Timers
sizeMonitorTimer.Update = function(sender, args)
    -- Sicherstellen, dass args.ElapsedTime existiert und nicht nil ist
    if args and args.ElapsedTime then
        timeSinceLastCheck = timeSinceLastCheck + args.ElapsedTime; -- Zeit seit dem letzten Aufruf

        if timeSinceLastCheck >= checkInterval then
            monitorWalletSize();
            timeSinceLastCheck = 0; -- Reset der Zeit
        end
    end
end