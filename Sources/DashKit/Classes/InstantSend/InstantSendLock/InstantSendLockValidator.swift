//
//  InstantSendLockValidator.swift
//
//  Created by Sun on 2019/5/27.
//

import Foundation

import BlsKit

class InstantSendLockValidator: IInstantSendLockValidator {
    // MARK: Properties

    private let quorumListManager: IQuorumListManager
    private let hasher: IDashHasher

    // MARK: Lifecycle

    init(quorumListManager: QuorumListManager, hasher: IDashHasher) {
        self.quorumListManager = quorumListManager
        self.hasher = hasher
    }

    // MARK: Functions

    func validate(isLock: ISLockMessage) throws {
        // 01. Get quorum for islock requestID
        let quorum = try quorumListManager.quorum(for: isLock.requestID, type: QuorumType.quorum50_60)

        // 02. Make signID data to verify signature
        var signID = quorum.typeWithQuorumHash +
            isLock.requestID +
            isLock.txHash
        signID = hasher.hash(data: signID)

        // 03. Verify signature by BLS
        let verified = BlsKit.verify(signID, publicKey: quorum.quorumPublicKey, signature: isLock.sign)

        guard verified else {
            throw DashKitErrors.ISLockValidation.signatureNotValid
        }
    }
}
