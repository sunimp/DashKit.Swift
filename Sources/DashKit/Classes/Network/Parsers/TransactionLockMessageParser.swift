//
//  TransactionLockMessageParser.swift
//  DashKit
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import BitcoinCore

/// todo identical code with transactionMessageParser
class TransactionLockMessageParser: IMessageParser {
    var id: String { "ix" }

    func parse(data: Data) -> IMessage {
        TransactionLockMessage(transaction: TransactionSerializer.deserialize(data: data))
    }
}
