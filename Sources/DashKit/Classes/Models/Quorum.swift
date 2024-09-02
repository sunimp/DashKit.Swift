//
//  Quorum.swift
//
//  Created by Sun on 2019/5/30.
//

import Foundation

import GRDB

// MARK: - Quorum

class Quorum: Record {
    // MARK: Nested Types

    enum Columns: String, ColumnExpression {
        case hash
        case version
        case type
        case quorumHash
        case typeWithQuorumHash
        case quorumIndex
        case signers
        case validMembers
        case quorumPublicKey
        case quorumVvecHash
        case quorumSig
        case sig
    }

    // MARK: Overridden Properties

    override class var databaseTableName: String {
        "quorums"
    }

    // MARK: Properties

    let dataHash: Data
    let version: UInt16
    let type: UInt8
    let quorumHash: Data
    let typeWithQuorumHash: Data
    let quorumIndex: UInt16?
    let signers: Data
    let validMembers: Data
    let quorumPublicKey: Data
    let quorumVvecHash: Data
    let quorumSig: Data
    let sig: Data

    // MARK: Lifecycle

    required init(row: Row) throws {
        dataHash = row[Columns.hash]
        version = row[Columns.version]
        type = row[Columns.type]
        quorumHash = row[Columns.quorumHash]
        typeWithQuorumHash = row[Columns.typeWithQuorumHash]
        quorumIndex = row[Columns.quorumIndex]
        signers = row[Columns.signers]
        validMembers = row[Columns.validMembers]
        quorumPublicKey = row[Columns.quorumPublicKey]
        quorumVvecHash = row[Columns.quorumVvecHash]
        quorumSig = row[Columns.quorumSig]
        sig = row[Columns.sig]

        try super.init(row: row)
    }

    init(
        hash: Data,
        version: UInt16,
        type: UInt8,
        quorumHash: Data,
        typeWithQuorumHash: Data,
        quorumIndex: UInt16?,
        signers: Data,
        validMembers: Data,
        quorumPublicKey: Data,
        quorumVvecHash: Data,
        quorumSig: Data,
        sig: Data
    ) {
        dataHash = hash
        self.version = version
        self.type = type
        self.quorumHash = quorumHash
        self.typeWithQuorumHash = typeWithQuorumHash
        self.quorumIndex = quorumIndex
        self.signers = signers
        self.validMembers = validMembers
        self.quorumPublicKey = quorumPublicKey
        self.quorumVvecHash = quorumVvecHash
        self.quorumSig = quorumSig
        self.sig = sig

        super.init()
    }

    // MARK: Overridden Functions

    override func encode(to container: inout PersistenceContainer) throws {
        container[Columns.hash] = dataHash
        container[Columns.version] = version
        container[Columns.type] = type
        container[Columns.quorumHash] = quorumHash
        container[Columns.typeWithQuorumHash] = typeWithQuorumHash
        container[Columns.quorumIndex] = quorumIndex
        container[Columns.signers] = signers
        container[Columns.validMembers] = validMembers
        container[Columns.quorumPublicKey] = quorumPublicKey
        container[Columns.quorumVvecHash] = quorumVvecHash
        container[Columns.quorumSig] = quorumSig
        container[Columns.sig] = sig
    }
}

// MARK: Hashable, Comparable

extension Quorum: Hashable, Comparable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(dataHash)
    }

    public static func == (lhs: Quorum, rhs: Quorum) -> Bool {
        lhs.dataHash == rhs.dataHash
    }

    public static func < (lhs: Quorum, rhs: Quorum) -> Bool {
        lhs.dataHash < rhs.dataHash
    }
}
