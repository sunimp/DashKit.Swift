//
//  DashExtensions.swift
//  DashKit
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import BitcoinCore

class DashTransactionInfoConverter: ITransactionInfoConverter {
    public var baseTransactionInfoConverter: IBaseTransactionInfoConverter!
    private let instantTransactionManager: IInstantTransactionManager

    init(instantTransactionManager: IInstantTransactionManager) {
        self.instantTransactionManager = instantTransactionManager
    }

    func transactionInfo(fromTransaction transactionForInfo: FullTransactionForInfo) -> TransactionInfo {
        let txInfo: DashTransactionInfo = baseTransactionInfoConverter.transactionInfo(fromTransaction: transactionForInfo)
        txInfo.instantTx = instantTransactionManager.isTransactionInstant(txHash: transactionForInfo.transactionWithBlock.transaction.dataHash)
        return txInfo
    }
}
