//
//  MerkleRootCreator.swift
//
//  Created by Sun on 2019/3/26.
//

import Foundation

import BitcoinCore

class MerkleRootCreator: IMerkleRootCreator {
    // MARK: Nested Types

    private struct MerkleChunk {
        let first: Data
        let last: Data
    }

    // MARK: Properties

    let hasher: IDashHasher

    // MARK: Lifecycle

    public init(hasher: IDashHasher) {
        self.hasher = hasher
    }

    // MARK: Functions

    func create(hashes: [Data]) -> Data? {
        guard !hashes.isEmpty else {
            return nil
        }
        var tmpHashes = hashes
        repeat {
            tmpHashes = joinHashes(hashes: tmpHashes)
        } while tmpHashes.count > 1

        return tmpHashes.first
    }

    private func joinHashes(hashes: [Data]) -> [Data] {
        let chunks = chunked(data: hashes, into: 2)

        return chunks.map {
            hasher.hash(data: $0.first + $0.last)
        }
    }

    private func chunked(data: [Data], into size: Int) -> [MerkleChunk] {
        let count = data.count
        return stride(from: 0, to: count, by: size).map {
            let upperBound = max($0, min($0 + size, count) - 1)
            return MerkleChunk(first: data[$0], last: data[upperBound])
        }
    }
}
