//
//  CoinbaseTransactionSerializer.swift
//  DashKit
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import BitcoinCore

class CoinbaseTransactionSerializer: ICoinbaseTransactionSerializer {
    func serialize(coinbaseTransaction: CoinbaseTransaction) -> Data {
        var data = Data()

        data += TransactionSerializer.serialize(transaction: coinbaseTransaction.transaction)
        data += coinbaseTransaction.coinbaseTransactionSize
        data += Data(from: coinbaseTransaction.version)
        data += Data(from: coinbaseTransaction.height)
        data += coinbaseTransaction.merkleRootMNList

        if let merkleRootQuorums = coinbaseTransaction.merkleRootQuorums {
            data += merkleRootQuorums
        }

        return data
    }
}
