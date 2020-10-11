//
//  Extensions.swift
//  iCoffee
//

import Firebase
import CodableFirebase

extension QuerySnapshot {
    func decode<T: Codable>() -> [T] {
        documents.compactMap { try? FirebaseDecoder().decode(T.self, from: $0.data()) }
    }
}

extension DocumentSnapshot {
    func decode<T: Codable>() -> T? {
       try? FirebaseDecoder().decode(T.self, from: data())
    }
}

extension Double {
    var clean: String {
        truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension Array {
    subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
}

extension Encodable {
    var defaultDictionary: [String: Any]? {
        return try? dictionary(dateStrategy: JSONEncoder.DateEncodingStrategy.iso8601)
    }
    
    func dictionary(dateStrategy: JSONEncoder.DateEncodingStrategy) throws -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = dateStrategy
        let data = try encoder.encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            preconditionFailure("Error during converting encodable to dictionary \(String(describing: type(of: self)))")
        }
        
        return dictionary
    }
}
