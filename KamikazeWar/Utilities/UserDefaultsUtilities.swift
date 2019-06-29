//
//  UserDefaultsUtilities.swift
//  KamikazeWar
//
//  Created by Alberto García-Muñoz on 29/06/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

extension UserDefaults {
    func write<T: Encodable>(key: String, value: T) {
        guard let data = try? JSONEncoder().encode(value) else { return }
        set(data, forKey: key)
    }
    
    func read<T: Decodable>(key: String) -> T? {
        guard let data = data(forKey: key) else { return nil}
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
