//
//  DashKitErrors.swift
//
//  Created by Sun on 2019/4/12.
//

import Foundation

public enum DashKitErrors {
    public enum LockVoteValidation: Error {
        case masternodeNotFound
        case masternodeNotInTop
        case txInputNotFound
        case signatureNotValid
    }

    public enum ISLockValidation: Error {
        case signatureNotValid
        case quorumNotFound
    }

    public enum InstantSendLockValidation: Error {
        case signatureNotValid
    }

    enum MasternodeListValidation: Error {
        case wrongMerkleRootList
        case wrongCoinbaseHash
        case noMerkleBlockHeader
        case wrongMerkleRoot
    }

    enum QuorumListValidation: Error {
        case wrongMerkleRootList
    }
}
