//
//  TransactionLockMessageParser.swift
//
//  Created by Sun on 2019/3/18.
//

import Foundation

import BitcoinCore

/// todo identical code with transactionMessageParser
class TransactionLockMessageParser: IMessageParser {
    // MARK: Computed Properties

    var id: String { "ix" }

    // MARK: Functions

    func parse(data: Data) -> IMessage {
        TransactionLockMessage(transaction: TransactionSerializer.deserialize(data: data))
    }
}
