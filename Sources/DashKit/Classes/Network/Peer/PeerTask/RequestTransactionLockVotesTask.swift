//
//  RequestTransactionLockVotesTask.swift
//
//  Created by Sun on 2019/3/18.
//

import Foundation

import BitcoinCore

class RequestTransactionLockVotesTask: PeerTask {
    // MARK: Properties

    var hashes = [Data]()
    var transactionLockVotes = [TransactionLockVoteMessage]()

    // MARK: Lifecycle

    init(hashes: [Data], dateGenerator: @escaping () -> Date = Date.init) {
        self.hashes = hashes

        super.init(dateGenerator: dateGenerator)
    }

    // MARK: Overridden Functions

    override func start() {
        let items = hashes.map { hash in InventoryItem(type: DashInventoryType.msgTxLockVote.rawValue, hash: hash) }
        requester?.send(message: GetDataMessage(inventoryItems: items))

        super.start()
    }

    override func handle(message: IMessage) -> Bool {
        if let lockMessage = message as? TransactionLockVoteMessage {
            return handleTransactionLockRequest(transactionLockVote: lockMessage)
        }
        return false
    }

    // MARK: Functions

    private func handleTransactionLockRequest(transactionLockVote: TransactionLockVoteMessage) -> Bool {
        guard let index = hashes.firstIndex(of: transactionLockVote.hash) else {
            return false
        }

        hashes.remove(at: index)
        transactionLockVotes.append(transactionLockVote)
        if hashes.isEmpty {
            delegate?.handle(completedTask: self)
        }

        return true
    }
}
