BankDefault = {}

BankDefault.name = "BankDefault"
-- BankDefault.Name = “BankDefault”
-- BankDefault.version = “0.0.1”
-- BankDefault.author = “Magnum1997”

function BankDefault:Initialize()
    d(BankDefault.name, "loaded.")
    local bankScene = SCENE_MANAGER:GetScene("bank")
    bankScene:RegisterCallback("StateChange", function(oldState, newState)
        if newState == SCENE_SHOWING then
            BankDefault.selectDeposit()
        end
    end)
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
    --Do not call the scene callback function registration with EACH bank open!
    --It's enopugh to do this once after addon init.
end

--Better do not name a function just selectDeposit as noone knows where it belongs to, and
--it polluates the global namespace (table _G["selectDeposit"]) -> same like selectDeposit)
--So move it to your addon's namespace (a table for your addon -> BankDefault)
function BankDefault.selectDeposit()
    -- Two method that work shown below. When run with debug or /script command
    -- with the bank window open it works perfectly.
    -- Run in callback the item categories misalign.
    -- Can be fixed by clicking withdraw button.

    ZO_MenuBar_SelectDescriptor(ZO_PlayerBankMenuBar, SI_BANK_DEPOSIT)

    --local bankFragmentBar = ZO_SceneFragmentBar:New(ZO_PlayerBankMenuBar)
    --bankFragmentBar:SelectFragment(SI_BANK_DEPOSIT)
    --> Do not manually mess with the fragments as this will most likely break other addons!!!
    --> Like LibFilters-3.0 which adds stuff to the fragment's layout to identify what is currently shown.
    --> There also exist functions in the SCENE_MANAGER to add/remove fragments to a scene, 
    --> which are called as the bank switches between deposit and withdraw.
    --> e.g. removes inventory fragment from bank scene as you switch from despoit to withdraw and adds the bank fragment
    -->  + vice versa
    --It should be enough to use ZO_MenuBar_SelectDescriptor to select the menubar's button, which will call the
    --scene change events and functions automatically afterwards.
end

--EVENT_MANAGER:RegisterForEvent(BankDefault.name, EVENT_ADD_ON_LOADED, BankDefault.OnAddOnLoaded)
EVENT_MANAGER:RegisterForEvent(BankDefault.name, EVENT_OPEN_BANK, BankDefault.OnBankOpen)
