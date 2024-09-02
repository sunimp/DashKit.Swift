//
//  RequestTransactionLockRequestsTask.swift
//
//  Created by Sun on 2019/3/18.
//

import Foundation

import BitcoinCore

class RequestTransactionLockRequestsTask: PeerTask {
    // MARK: Properties

    var hashes = [Data]()
    var transactions = [FullTransaction]()

    // MARK: Lifecycle

    init(hashes: [Data], dateGenerator: @escaping () -> Date = Date.init) {
        self.hashes = hashes

        super.init(dateGenerator: dateGenerator)
    }

    // MARK: Overridden Functions

    override func start() {
        let items = hashes.map { hash in InventoryItem(type: DashInventoryType.msgTxLockRequest.rawValue, hash: hash) }
        requester?.send(message: GetDataMessage(inventoryItems: items))

        super.start()
    }

    override func handle(message: IMessage) -> Bool {
        if let lockMessage = message as? TransactionLockMessage {
            return handleTransactionLockRequest(transaction: lockMessage.transaction)
        }
        return false
    }

    // MARK: Functions

    private func handleTransactionLockRequest(transaction: FullTransaction) -> Bool {
        guard let index = hashes.firstIndex(of: transaction.header.dataHash) else {
            return false
        }

        hashes.remove(at: index)
        transactions.append(transaction)
        if hashes.isEmpty {
            delegate?.handle(completedTask: self)
        }

        return true
    }
}
