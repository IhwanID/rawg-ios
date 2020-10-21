//
//  GameObject.swift
//  rawg
//
//  Created by Ihwan ID on 18/10/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import Foundation
import RealmSwift

final class GameObject: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var background_image = ""
    @objc dynamic var released = ""
    @objc dynamic var rating = 0.0
    @objc dynamic var rating_top = 0.0
    override static func primaryKey() -> String? {
        return "id"
    }
}

public protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}

extension Game: Persistable {
    public init(managedObject: GameObject) {
        id = managedObject.id
        name = managedObject.name
        background_image = managedObject.background_image
        released = managedObject.released
        rating = managedObject.rating
    }

    public func managedObject() -> GameObject {
        let game = GameObject()
        game.id = id ?? 0
        game.name = name ?? ""
        game.background_image = background_image ?? ""
        game.released = released ?? ""
        game.rating = rating ?? 0.0
        return game
    }
}

public final class WriteTransaction {
    private let realm: Realm

    internal init(realm: Realm) {
        self.realm = realm
    }

    public func add<T: Persistable>(_ value: T) {
        realm.add(value.managedObject())
    }

    public func delete<T: Persistable>(_ value: T) {
        realm.delete(value.managedObject())
    }
    func objectExist (id: String) -> Bool {
            return realm.object(ofType: GameObject.self, forPrimaryKey: id) != nil
    }

}

// Implement the Container
public final class Container {
    private let realm: Realm
    public convenience init() throws {
        try self.init(realm: Realm())
    }
    internal init(realm: Realm) {
        self.realm = realm
    }
    public func write(_ block: (WriteTransaction) throws -> Void)
    throws {
        let transaction = WriteTransaction(realm: realm)
        try realm.write {
            try block(transaction)
        }
    }
}
