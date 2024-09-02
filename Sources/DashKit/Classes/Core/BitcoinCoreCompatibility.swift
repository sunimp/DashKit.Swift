//
//  BitcoinCoreCompatibility.swift
//
//  Created by Sun on 2019/4/22.
//

import Foundation

import BitcoinCore

// MARK: - DifficultyEncoder + IDashDifficultyEncoder

extension DifficultyEncoder: IDashDifficultyEncoder { }

// MARK: - BlockValidatorHelper + IDashBlockValidatorHelper

extension BlockValidatorHelper: IDashBlockValidatorHelper { }

// MARK: - TransactionSizeCalculator + IDashTransactionSizeCalculator

extension TransactionSizeCalculator: IDashTransactionSizeCalculator { }

// MARK: - TransactionSyncer + IDashTransactionSyncer

extension TransactionSyncer: IDashTransactionSyncer { }

// MARK: - DoubleShaHasher + IDashHasher

extension DoubleShaHasher: IDashHasher { }
