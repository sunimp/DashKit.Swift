//
//  ConfirmedUnspentOutputProvider.swift
//
//  Created by Sun on 2019/5/7.
//

import Foundation

import BitcoinCore

// MARK: - ConfirmedUnspentOutputProvider

class ConfirmedUnspentOutputProvider {
    // MARK: Properties

    let storage: IDashStorage
    let confirmationsThreshold: Int

    // MARK: Lifecycle

    init(storage: IDashStorage, confirmationsThreshold: Int) {
        self.storage = storage
        self.confirmationsThreshold = confirmationsThreshold
    }
}

// MARK: IUnspentOutputProvider

extension ConfirmedUnspentOutputProvider: IUnspentOutputProvider {
    func spendableUtxo(filters: UtxoFilters) -> [UnspentOutput] {
        let lastBlockHeight = storage.lastBlock?.height ?? 0

        // Output must have a public key, that is, must belong to the user
        return storage.unspentOutputs().filter { utxo in
            guard isOutputConfirmed(unspentOutput: utxo, lastBlockHeight: lastBlockHeight) else {
                return false
            }

            if let scriptTypes = filters.scriptTypes, !scriptTypes.contains(utxo.output.scriptType) {
                return false
            }

            if
                let outputsCount = filters.maxOutputsCountForInputs,
                storage.outputsCount(transactionHash: utxo.transaction.dataHash) > outputsCount {
                return false
            }

            return true
        }
    }

    func confirmedSpendableUtxo(filters: UtxoFilters) -> [UnspentOutput] {
        spendableUtxo(filters: filters)
    }

    private func isOutputConfirmed(unspentOutput: UnspentOutput, lastBlockHeight: Int) -> Bool {
        guard let blockHeight = unspentOutput.blockHeight else {
            return false
        }

        return blockHeight <= lastBlockHeight - confirmationsThreshold + 1
    }
}
