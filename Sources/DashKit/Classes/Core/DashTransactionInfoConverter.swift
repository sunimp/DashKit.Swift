//
//  DashTransactionInfoConverter.swift
//
//  Created by Sun on 2019/5/3.
//

import Foundation

import BitcoinCore

class DashTransactionInfoConverter: ITransactionInfoConverter {
    // MARK: Properties

    public var baseTransactionInfoConverter: IBaseTransactionInfoConverter!

    private let instantTransactionManager: IInstantTransactionManager

    // MARK: Lifecycle

    init(instantTransactionManager: IInstantTransactionManager) {
        self.instantTransactionManager = instantTransactionManager
    }

    // MARK: Functions

    func transactionInfo(fromTransaction transactionForInfo: FullTransactionForInfo) -> TransactionInfo {
        let txInfo: DashTransactionInfo = baseTransactionInfoConverter
            .transactionInfo(fromTransaction: transactionForInfo)
        txInfo.instantTx = instantTransactionManager
            .isTransactionInstant(txHash: transactionForInfo.transactionWithBlock.transaction.dataHash)
        return txInfo
    }
}
