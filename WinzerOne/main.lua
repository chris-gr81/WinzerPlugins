import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "Turbine.Gameplay";

mainBackClr = Turbine.UI.Color( 0, 0, 0);

mainWindow = Turbine.UI.Window();
mainWindow:SetVisible(true);
mainWindow:SetSize(300, 40);
mainWindow:SetPosition(900, 30);
mainWindow:SetBackColor(mainBackClr);
mainWindow:SetOpacity(0.6);

targetLabel = Turbine.UI.Label();
targetLabel:SetParent(mainWindow);
targetLabel:SetPosition(10, 10);
targetLabel:SetSize(300, 50);

Player = Turbine.Gameplay.LocalPlayer.GetInstance();
pWall = Player.GetWallet();

maxWall = pWall.GetSize();

function updateMainWindowContent()
    local text = {};

    local wishedItems = {}
    wishedItems[1] = "Hero's Mark";
    wishedItems[2] = "Token of Heroism";

    local sizeWishedItems = #wishedItems;
    local showStruct = {}
    local text = {}

    for i = 1, sizeWishedItems do
        local currentWishedItem = wishedItems[i];
        local found = false;

        for j = 1, maxWall do  
            local currentItem = pWall:GetItem(j);
            local currentItemName = tostring(currentItem:GetName());
        
            if (currentItemName == currentWishedItem) then
                showStruct[1] = currentItemName;
                showStruct[2] = tostring(currentItem:GetQuantity());
                found = true;
                break;
            end
        end
        if found then
            text[i] = showStruct[1] .. ": " .. showStruct[2];
        else
            text[i] = wishedItems[i] .. ": 0"
        end     
    end
    targetLabel:SetText(text[1] .. "\n" .. text[2]);
end

updateMainWindowContent()
pWall.ItemAdded = function(sender, args)
    updateMainWindowContent();
end
pWall.ItemRemoved = function(sender, args)
    updateMainWindowContent();
end
targetLabel.MouseDoubleClick = function(sender, args)
    mainWindow:SetVisible(false)
end
