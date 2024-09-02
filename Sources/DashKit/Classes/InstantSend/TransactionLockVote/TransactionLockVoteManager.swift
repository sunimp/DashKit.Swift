//
//  TransactionLockVoteManager.swift
//
//  Created by Sun on 2019/5/1.
//

import Foundation

import BitcoinCore

class TransactionLockVoteManager: ITransactionLockVoteManager {
    // MARK: Properties

    private(set) var relayedLockVotes = Set<TransactionLockVoteMessage>()
    private(set) var checkedLockVotes = Set<TransactionLockVoteMessage>()

    private let transactionLockVoteValidator: ITransactionLockVoteValidator

    // MARK: Lifecycle

    init(transactionLockVoteValidator: ITransactionLockVoteValidator) {
        self.transactionLockVoteValidator = transactionLockVoteValidator
    }

    // MARK: Functions

    func takeRelayedLockVotes(for txHash: Data) -> [TransactionLockVoteMessage] {
        let votes = relayedLockVotes.filter {
            $0.txHash == txHash
        }
        relayedLockVotes.subtract(votes)
        return Array(votes).sorted { $0.hash < $1.hash }
    }

    func add(relayed: TransactionLockVoteMessage) {
        relayedLockVotes.insert(relayed)
    }

    func add(checked: TransactionLockVoteMessage) {
        checkedLockVotes.insert(checked)
    }

    func processed(lvHash: Data) -> Bool {
        relayedLockVotes.first(where: { $0.hash == lvHash }) != nil || checkedLockVotes
            .first(where: { $0.hash == lvHash }) != nil
    }

    func validate(lockVote: TransactionLockVoteMessage) throws {
        // validate masternode in top 10 masternodes for quorumModifier and has right signature
        try transactionLockVoteValidator.validate(lockVote: lockVote)
    }
}
