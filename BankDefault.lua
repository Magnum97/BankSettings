-- First, we create a namespace for our addon by declaring a top-level table that will hold everything else.
BankDefault = {}
local PAEM = PA.EventManager

-- This isn't strictly necessary, but we'll use this string later when registering events.
-- Better to define it in a single place rather than retyping the same string.

BankDefault.name = "BankDefault"
-- BankDefault.Name = “BankDefault”
-- BankDefault.version = “0.0.1”
-- BankDefault.author = “Magnum1997”
-- local 
-- Next we create a function that will initialize our addon

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
    --  if bankBag ~= BANK_BAG then return end
    d("Viewing bank bag", bankBag)
    ZO_MenuBar_SelectDescriptor(ZO_PlayerBankMenuBar, SI_BANK_DEPOSIT)
end

function BankDefault.OnBankClose(event, bankBag)
    --  if bankBag ~= BANK_BAG return end
    d("Closed bank window")
end

-- Finally, we'll register our event handler function to be called when the proper event occurs.
EVENT_MANAGER:RegisterForEvent(BankDefault.name, EVENT_ADD_ON_LOADED, BankDefault.OnAddOnLoaded)
EVENT_MANAGER:RegisterForEvent(BankDefault.name, EVENT_OPEN_BANK, BankDefault.OnBankOpen)
EVENT_MANAGER:RegisterForEvent(BankDefault.name, EVENT_CLOSE_BANK, BankDefault.OnBankClose)
