BankDefault = {}

BankDefault.name = "BankDefault"
-- BankDefault.Name = “BankDefault”
-- BankDefault.version = “0.0.1”
-- BankDefault.author = “Magnum1997”

function BankDefault:Initialize()
    d(BankDefault.name, "loaded.")
end

-- Then we create an event handler function which will be called when the "addon loaded" event
-- occurs. We'll use this to initialize our addon after all of its resources are fully loaded.

function BankDefault.OnAddOnLoaded(event, addonName)
    -- The event fires each time *any* addon loads - but we only care about when our own addon loads.
    if addonName == BankDefault.name then
        EVENT_MANAGER:UnregisterForEvent("BankDefault", EVENT_ADD_ON_LOADED)
        BankDefault:Initialize()
    end
end

function BankDefault.OnBankOpen(event, bankBag)
    local bankScene = SCENE_MANAGER:GetScene("bank")
    bankScene:RegisterCallback("StateChange", function(oldState, newState)
        if newState == SCENE_SHOWING then
            selectDeposit()
        end
    end)
end

function selectDeposit()
    -- Two method that work shown below. When run with debug or /script command
    -- with the bank window open it works perfectly.
    -- Run in callback the item categories misalign.
    -- Can be fixed by clicking withdraw button.

    ZO_MenuBar_SelectDescriptor(ZO_PlayerBankMenuBar, SI_BANK_DEPOSIT)

    --local bankFragmentBar = ZO_SceneFragmentBar:New(ZO_PlayerBankMenuBar)
    --bankFragmentBar:SelectFragment(SI_BANK_DEPOSIT)
end

--EVENT_MANAGER:RegisterForEvent(BankDefault.name, EVENT_ADD_ON_LOADED, BankDefault.OnAddOnLoaded)
EVENT_MANAGER:RegisterForEvent(BankDefault.name, EVENT_OPEN_BANK, BankDefault.OnBankOpen)
