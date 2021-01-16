//
// Created by Иван Лизогуб on 04.12.2020.
//

import Foundation

extension String {
    func containsOnlyCharactersIn(matchCharacters: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: matchCharacters).inverted
        return self.rangeOfCharacter(from: invalidCharacters) == nil
    }

    func doesNotContainCharactersIn(matchCharacters: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: matchCharacters)
        return self.rangeOfCharacter(from: invalidCharacters) == nil
    }
}