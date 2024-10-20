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
local maxWall = pWall:GetSize();

local function updateMainWindowContent()
    local wishedItems = { "Herbstfest-Medaille", "Zerfledderter Schatten" }; -- hier die gewünschten Wallet-Item eintragen,
    -- noch ist die Anzeige auf 2 optimiert
    local text = {};

    for i = 1, #wishedItems do
        local currentWishedItem = wishedItems[i];
        local found = false;

        for j = 1, maxWall do  
            local currentItem = pWall:GetItem(j);
            -- Um das Wallet in den Chat zu loggen, die nächste Zeile entkommentieren
            -- Turbine.Shell.WriteLine(tostring(currentItem:GetName()));
            local currentItemName = tostring(currentItem:GetName());
            local currentItemQuantity = tostring(currentItem:GetQuantity());

           if currentItemName == currentWishedItem then
                text[i] = currentItemName .. ": " .. currentItemQuantity;
                found = true;
                break;
            end
        end

        if not found then
            text[i] = wishedItems[i] .. ": nichts";
        end
    end

    -- Update the label with all the found items
    targetLabel:SetText( table.concat(text, "\n") );
end

updateMainWindowContent();
pWall.ItemAdded = function( sender, args )
    updateMainWindowContent();
end
pWall.ItemRemoved = function( sender, args )
    updateMainWindowContent();
end
targetLabel.MouseDoubleClick = function( sender, args )
    mainWindow:SetVisible( false );
end