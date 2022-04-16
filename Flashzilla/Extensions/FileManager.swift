//
//  FileManager.swift
//  Flashzilla
//
//  Created by Andres camilo Raigoza misas on 15/04/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func decode<T: Codable>(from url: URL) throws -> T {
        let data = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    }
    
    func save<T:Codable>(_ items: T, to url: URL) {
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: url)
        } catch {
            print("Error saving data to url: \(error.localizedDescription)")
        }
    }
}
