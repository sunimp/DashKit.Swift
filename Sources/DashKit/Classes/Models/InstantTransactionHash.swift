//
//  InstantTransactionHash.swift
//
//  Created by Sun on 2019/5/3.
//

import Foundation

import GRDB

class InstantTransactionHash: Record {
    // MARK: Nested Types

    enum Columns: String, ColumnExpression {
        case txHash
    }

    // MARK: Overridden Properties

    override class var databaseTableName: String {
        "instantTransactionHashes"
    }

    // MARK: Properties

    let txHash: Data

    // MARK: Lifecycle

    required init(row: Row) throws {
        txHash = row[Columns.txHash]

        try super.init(row: row)
    }

    init(txHash: Data) {
        self.txHash = txHash

        super.init()
    }

    // MARK: Overridden Functions

    override func encode(to container: inout PersistenceContainer) throws {
        container[Columns.txHash] = txHash
    }
}
