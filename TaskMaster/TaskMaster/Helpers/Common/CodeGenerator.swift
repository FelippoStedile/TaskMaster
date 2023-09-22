//
//  CodeGenerator.swift
//  TaskMaster
//
//  Created by Filipe Ilunga on 22/09/23.
//

import Foundation
import CommonCrypto

final class CodeGenerator {
    static let shared: CodeGenerator = CodeGenerator()
    
    func generate6DigitHash() -> String {
        let allowedCharacters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var code = ""

        for _ in 0..<5 {
            let randomIndex = Int(arc4random_uniform(UInt32(allowedCharacters.count)))
            let randomCharacter = allowedCharacters[allowedCharacters.index(allowedCharacters.startIndex, offsetBy: randomIndex)]
            code.append(randomCharacter)
        }

        return code.uppercased()
    }

}
