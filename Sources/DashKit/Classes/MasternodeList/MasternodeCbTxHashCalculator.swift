//
//  MasternodeCbTxHashCalculator.swift
//
//  Created by Sun on 2019/3/26.
//

import Foundation

import BitcoinCore

class MasternodeCbTxHasher: IMasternodeCbTxHasher {
    // MARK: Properties

    private let coinbaseTransactionSerializer: ICoinbaseTransactionSerializer
    private let hasher: IDashHasher

    // MARK: Lifecycle

    init(coinbaseTransactionSerializer: ICoinbaseTransactionSerializer, hasher: IDashHasher) {
        self.coinbaseTransactionSerializer = coinbaseTransactionSerializer
        self.hasher = hasher
    }

    // MARK: Functions

    func hash(coinbaseTransaction: CoinbaseTransaction) -> Data {
        let serialized = coinbaseTransactionSerializer.serialize(coinbaseTransaction: coinbaseTransaction)

        return hasher.hash(data: serialized)
    }
}
