//
//  InstantTransactionSyncer.swift
//
//  Created by Sun on 2019/5/1.
//

import Foundation

import BitcoinCore

class InstantTransactionSyncer: IDashTransactionSyncer {
    // MARK: Properties

    private let transactionSyncer: ITransactionSyncer

    // MARK: Lifecycle

    init(transactionSyncer: ITransactionSyncer) {
        self.transactionSyncer = transactionSyncer
    }

    // MARK: Functions

    func handleRelayed(transactions: [FullTransaction]) {
        transactionSyncer.handleRelayed(transactions: transactions)
    }
}
