BankSettings = {
    name = "BankSettings", -- Matches folder and Manifest file names.
    version = "0.2.0", -- A nuisance to match to the Manifest.
    author = "@Magnum1997",
    menuName = "Mag's Bank Settings", -- A UNIQUE identifier for menu object.
}

function BankSettings.OnAddOnLoaded(event, addonName)
    -- The event fires each time *any* addon loads - but we only care about when our own addon loads.
    if addonName == BankSettings.name then
        EVENT_MANAGER:UnregisterForEvent("BankSettings", EVENT_ADD_ON_LOADED)
    end
    BankSettings:Initialize()
end

function BankSettings:Initialize()
    local bankScene = SCENE_MANAGER:GetScene("bank")
    bankScene:RegisterCallback("StateChange", function(oldState, newState)
        if newState == SCENE_SHOWN then
            BankSettings.selectDeposit()
        end
    end)
end

function BankSettings.selectDeposit(bankBag)
    if (IsBankOpen and IsHouseBankBag(bankBag)) then
        d("Bag is house bank")
        ZO_MenuBar_SelectDescriptor(ZO_HouseBankMenuBar, SI_BANK_DEPOSIT, true, true)
    else
        d("Bag is normal bank")
        ZO_MenuBar_SelectDescriptor(ZO_PlayerBankMenuBar, SI_BANK_DEPOSIT, true, true)
    end
end

-- When any addon is loaded, but before UI (Chat) is loaded.
EVENT_MANAGER:RegisterForEvent(BankSettings.name, EVENT_ADD_ON_LOADED, BankSettings.OnAddOnLoaded)
