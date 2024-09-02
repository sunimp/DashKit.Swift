//
//  X11Hasher.swift
//
//  Created by Sun on 2019/4/17.
//

import Foundation

import BitcoinCore
import X11Kit

class X11Hasher: IDashHasher, IHasher {
    func hash(data: Data) -> Data {
        X11Kit.x11(data)
    }
}
