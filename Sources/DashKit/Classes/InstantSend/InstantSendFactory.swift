//
//  InstantSendFactory.swift
//  DashKit
//
//  Created by Sun on 2024/8/21.
//

import Foundation

class InstantSendFactory: IInstantSendFactory {
    func instantTransactionInput(txHash: Data, inputTxHash: Data, voteCount: Int, blockHeight: Int?) -> InstantTransactionInput {
        let timeCreated = Int(Date().timeIntervalSince1970)

        return InstantTransactionInput(
            txHash: txHash,
            inputTxHash: inputTxHash,
            timeCreated: timeCreated,
            voteCount: voteCount,
            blockHeight: blockHeight
        )
    }
}
