//
//  SpecialTransaction.swift
//
//  Created by Sun on 2022/7/21.
//

import Foundation

import BitcoinCore

class SpecialTransaction: FullTransaction {
    // MARK: Properties

    let extraPayload: Data

    // MARK: Lifecycle

    init(transaction: FullTransaction, extraPayload: Data, forceHashUpdate: Bool = true) {
        self.extraPayload = extraPayload
        super.init(
            header: transaction.header,
            inputs: transaction.inputs,
            outputs: transaction.outputs,
            forceHashUpdate: forceHashUpdate
        )
    }
}
