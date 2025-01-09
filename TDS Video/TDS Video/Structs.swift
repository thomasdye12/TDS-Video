//
//  Structs.swift
//  TDS McdonaldsApi
//
//  Created by Thomas Dye on 02/08/2024.
//

import Foundation

// MARK: - McDonaldsOrder
struct McDonaldsOrder: Codable,Hashable {
    let id: String?
    let creationTime, lastUpdateTime: String?
    let restaurantID: Int?
    let channelData: ChannelData?
    let expectedFulfillmentRequestTime: String?
    let state: String?
    let scheduled, needsAttention: Bool?
    let deliveryStatus: String?
    let orderRequest: OrderRequest?
    let cartTotal: CartTotal?
    let paymentData: PaymentData?
    let fulfillmentArea: FulfillmentArea?
    let completionDetails: CompletionDetails?
    let refundData: RefundData?
    let restaurantORBCode, shortCode, longCode: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case creationTime, lastUpdateTime, restaurantID, channelData, expectedFulfillmentRequestTime, state, scheduled, needsAttention, deliveryStatus, orderRequest, cartTotal, paymentData, fulfillmentArea, completionDetails, refundData, restaurantORBCode, shortCode, longCode
    }
}

// MARK: - ChannelData
struct ChannelData: Codable,Hashable {
    let name, restaurantFulfillmentFlow: String?
    let isRoa: Bool?
}

// MARK: - OrderRequest
struct OrderRequest: Codable,Hashable {
    let cart: Cart?
    let promotions, discounts: [String]?
    let additionalFees, additionalDeposits, additionalDonations, additionalConditions: String?
}

// MARK: - Cart
struct Cart: Codable,Hashable {
    let items: [Item]?
    let feeChoices, discountChoices, depositChoices, donationChoices: String?
}

// MARK: - Item
struct Item: Codable,Hashable {
    let reference: Reference?
    let quantity, id: Int?
    let customizations: [String: Int]?
    let choices: [String]?

    enum CodingKeys: String, CodingKey {
        case reference, quantity
        case id = "ID"
        case customizations, choices
    }
}

// MARK: - Reference
struct Reference: Codable,Hashable {
    let source, id: String?

    enum CodingKeys: String, CodingKey {
        case source
        case id = "ID"
    }
}

// MARK: - CartTotal
struct CartTotal: Codable,Hashable {
    let pricing: String?
    let items: [CartTotalItem]?
    let fees, appliedDiscounts, discounts, deposits: [String]?
    let donations: [String]?
    let originalAmount, finalAmount, net: Int?
    let taxes: [Tax]?
    let gross, subtotal, fiscalRoundingAdjust, totalDue: Int?
    let totalEnergy: Int?
    let displayDataLookup: DisplayDataLookup?
    let externalItemLocalizationLookup, menuItemLocalizationLookup: String?
    let externalReferenceLocalizations: [String]?
}

// MARK: - CartTotalItem
struct CartTotalItem: Codable,Hashable {
    let reference: Reference?
    let type: String?
    let id, quantity: Int?
    let customizations, choices: [Customization]?
    let baseAmount, originalAmount, adjustedBaseAmount, finalAmount: Int?
    let net, gross, totalEnergy: Int?
    let taxes: [Tax]?

    enum CodingKeys: String, CodingKey {
        case reference, type, quantity, customizations, choices, baseAmount, originalAmount, adjustedBaseAmount, finalAmount, net, gross, totalEnergy, taxes
        case id = "ID"
    }
}

// MARK: - Customization
struct Customization: Codable,Hashable {
    let id, defaultOption, selectedOption, amount: Int?
    let changeInEnergy: Int?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case defaultOption, selectedOption, amount, changeInEnergy, type
        case id = "ID"
    }
}

// MARK: - Tax
struct Tax: Codable,Hashable {
    let base: Int?
    let type: String?
    let rate, amount: Int?
}

// MARK: - DisplayDataLookup
struct DisplayDataLookup: Codable,Hashable {
//    let menu: [String: Menu]?
//
//    enum CodingKeys: String, CodingKey {
//        case menu = "MENU"
//    }
}

// MARK: - Menu
struct Menu: Codable,Hashable {
    let additionalData: AdditionalData?
    let localizations: Localizations?
}

// MARK: - AdditionalData
struct AdditionalData: Codable,Hashable {
    let sugarLevy: SugarLevy?

    enum CodingKeys: String, CodingKey {
        case sugarLevy = "SUGAR_LEVY"
    }
}

// MARK: - SugarLevy
struct SugarLevy: Codable,Hashable {
    let amount, disclaimer: String?

    enum CodingKeys: String, CodingKey {
        case amount = "AMOUNT"
        case disclaimer = "DISCLAIMER"
    }
}

// MARK: - Localizations
struct Localizations: Codable,Hashable {
    let enGB: EnGB?

    enum CodingKeys: String, CodingKey {
        case enGB = "en-GB"
    }
}

// MARK: - EnGB
struct EnGB: Codable,Hashable {
    let name: String?
    let image: String?
}

// MARK: - PaymentData
struct PaymentData: Codable,Hashable {
    let preselectedFundingSource: PreselectedFundingSource?
    let channelPaymentInitiationData, channelPaymentInitiationConfirmation, channelPaymentResult: ChannelPaymentData?
    let restaurantPaymentResult, channelReversalInitiationConfirmation, channelReversalConfirmation, channelPaymentContinuationData: String?
}

// MARK: - ChannelPaymentData
struct ChannelPaymentData: Codable,Hashable {
    let timestamp: String?
    let estimatedTimeOfCompletion: String?
    let amount: Int?
    let status: String?
    let transactionData: TransactionData?
}

// MARK: - TransactionData
struct TransactionData: Codable,Hashable {
    let customerReason: String?
}

// MARK: - PreselectedFundingSource
struct PreselectedFundingSource: Codable,Hashable {
    let providerID, methodID: String?
}

// MARK: - FulfillmentArea
struct FulfillmentArea: Codable,Hashable {
    let storeArea: String?
    let locationIdentifier: String?
}

// MARK: - CompletionDetails
struct CompletionDetails: Codable,Hashable {
    let reason: String?
}

// MARK: - RefundData
struct RefundData: Codable,Hashable {
    let details, initiationConfirmation, confirmation: String?
}
