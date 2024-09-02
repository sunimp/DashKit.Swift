//
//  MasternodeListState.swift
//
//  Created by Sun on 2019/3/1.
//

import Foundation

import GRDB

class MasternodeListState: Record {
    // MARK: Nested Types

    enum Columns: String, ColumnExpression {
        case primaryKey
        case baseBlockHash
    }

    // MARK: Static Properties

    private static let primaryKey = "primaryKey"

    // MARK: Overridden Properties

    override class var databaseTableName: String {
        "masternodeListState"
    }

    // MARK: Properties

    let baseBlockHash: Data

    private let primaryKey: String = MasternodeListState.primaryKey

    // MARK: Lifecycle

    required init(row: Row) throws {
        baseBlockHash = row[Columns.baseBlockHash]

        try super.init(row: row)
    }

    init(baseBlockHash: Data) {
        self.baseBlockHash = baseBlockHash

        super.init()
    }

    // MARK: Overridden Functions

    override func encode(to container: inout PersistenceContainer) throws {
        container[Columns.primaryKey] = primaryKey
        container[Columns.baseBlockHash] = baseBlockHash
    }
}
