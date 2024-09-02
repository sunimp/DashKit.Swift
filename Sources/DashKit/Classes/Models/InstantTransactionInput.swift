//
//  InstantTransactionInput.swift
//
//  Created by Sun on 2019/3/28.
//

import Foundation

import GRDB

class InstantTransactionInput: Record {
    // MARK: Nested Types

    enum Columns: String, ColumnExpression {
        case txHash
        case inputTxHash
        case timeCreated
        case voteCount
        case blockHeight
    }

    // MARK: Overridden Properties

    override class var databaseTableName: String {
        "instantTransactionInputs"
    }

    // MARK: Properties

    let txHash: Data
    let inputTxHash: Data
    let timeCreated: Int
    let voteCount: Int
    let blockHeight: Int?

    // MARK: Lifecycle

    required init(row: Row) throws {
        txHash = row[Columns.txHash]
        inputTxHash = row[Columns.inputTxHash]
        timeCreated = row[Columns.timeCreated]
        voteCount = row[Columns.voteCount]
        blockHeight = row[Columns.blockHeight]

        try super.init(row: row)
    }

    init(txHash: Data, inputTxHash: Data, timeCreated: Int, voteCount: Int, blockHeight: Int?) {
        self.txHash = txHash
        self.inputTxHash = inputTxHash
        self.timeCreated = timeCreated
        self.voteCount = voteCount
        self.blockHeight = blockHeight

        super.init()
    }

    // MARK: Overridden Functions

    override func encode(to container: inout PersistenceContainer) throws {
        container[Columns.txHash] = txHash
        container[Columns.inputTxHash] = inputTxHash
        container[Columns.timeCreated] = timeCreated
        container[Columns.voteCount] = voteCount
        container[Columns.blockHeight] = blockHeight
    }
}
