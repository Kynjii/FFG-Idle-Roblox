local AnalyticsService: AnalyticsService = game:GetService("AnalyticsService")

local Economy = {}
Economy.TransactionType = {
	["IAP"] = Enum.AnalyticsEconomyTransactionType.IAP.Name, -- Represents a source of currency purchased via Robux, for example in-experience "gold" purchased for Robux.
	["Shop"] = Enum.AnalyticsEconomyTransactionType.Shop.Name, -- Purchases within a shop, for example in-experience "coins" used to buy an item within the experience.
	["Gameplay"] = Enum.AnalyticsEconomyTransactionType.Gameplay.Name, -- Currency earned or paid through gameplay, for example in-experience "gold" earned from winning a match.
	["ContextualPurchase"] = Enum.AnalyticsEconomyTransactionType.ContextualPurchase.Name, -- Purchase with direct context to a reward, for example in-experience "gold" used to purchase an extra life.
	["TimedReward"] = Enum.AnalyticsEconomyTransactionType.TimedReward.Name, -- Time-based reward, for example in-experience "gold" rewarded for logging in daily.
	["Onboarding"] = Enum.AnalyticsEconomyTransactionType.Onboarding.Name, -- Transaction related to onboarding, for example in-experience "gold" rewarded for completing the tutorial.
}

Economy.FlowType = {
	CurrencyAdd = Enum.AnalyticsEconomyFlowType.Source, -- Currency is being added to the player's account.
	CurrencyRemove = Enum.AnalyticsEconomyFlowType.Sink, -- Currency is being removed from the player's account.
}

function Economy.Log(player: Player, flowType: Enum.AnalyticsEconomyFlowType, currencyType: string, amount: number, endingBalance: number, transactionType: string, itemSku: string?)
	if not player or not flowType or not currencyType or not amount or not endingBalance or not transactionType then return end

	AnalyticsService:LogEconomyEvent(
		player,
		flowType,
		currencyType,
		amount, -- How many coins are in the bundle
		endingBalance, -- balance after transaction
		transactionType,
		itemSku or "" -- Unique identifier of the coin bundle
	)
end

export type EconomyType = typeof(Economy)

return Economy
