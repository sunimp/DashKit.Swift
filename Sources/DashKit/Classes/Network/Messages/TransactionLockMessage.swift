//
//  TransactionLockMessage.swift
//  DashKit
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import BitcoinCore
import WWExtensions

struct TransactionLockMessage: IMessage {
    let transaction: FullTransaction

    var description: String {
        "\(transaction.header.dataHash.ww.reversedHex)"
    }
}
