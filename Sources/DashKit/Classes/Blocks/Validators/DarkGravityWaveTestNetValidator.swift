//
//  DarkGravityWaveTestNetValidator.swift
//
//  Created by Sun on 2019/4/15.
//

import Foundation

import BitcoinCore

class DarkGravityWaveTestNetValidator: IBlockChainedValidator {
    // MARK: Properties

    private let difficultyEncoder: IDashDifficultyEncoder

    private let targetSpacing: Int
    private let targetTimeSpan: Int
    private let maxTargetBits: Int
    private let powDGWHeight: Int

    // MARK: Lifecycle

    init(
        difficultyEncoder: IDashDifficultyEncoder,
        targetSpacing: Int,
        targetTimeSpan: Int,
        maxTargetBits: Int,
        powDGWHeight: Int
    ) {
        self.difficultyEncoder = difficultyEncoder

        self.targetSpacing = targetSpacing
        self.targetTimeSpan = targetTimeSpan
        self.maxTargetBits = maxTargetBits
        self.powDGWHeight = powDGWHeight
    }

    // MARK: Functions

    func validate(block: Block, previousBlock: Block) throws {
        if block.timestamp > previousBlock.timestamp + 2 * targetTimeSpan { // more than 2 cycles
            if block.bits != maxTargetBits {
                throw BitcoinCoreErrors.BlockValidation.notEqualBits
            }
            return
        }

        let blockTarget = difficultyEncoder.decodeCompact(bits: previousBlock.bits)

        var expectedBits = difficultyEncoder.encodeCompact(from: 10 * blockTarget)
        if expectedBits > maxTargetBits {
            expectedBits = maxTargetBits
        }
        if expectedBits != block.bits {
            throw BitcoinCoreErrors.BlockValidation.notEqualBits
        }
    }

    func isBlockValidatable(block: Block, previousBlock: Block) -> Bool {
        block.height >= powDGWHeight && (block.timestamp > previousBlock.timestamp + 4 * targetSpacing)
    }
}
