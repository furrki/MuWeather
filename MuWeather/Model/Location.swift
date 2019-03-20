//
//  Location.swift
//  MuWeather
//
//  Created by Admin on 16.03.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import Foundation
import RealmSwift

class Location: Object {
    @objc dynamic public private(set) var woeid = ""
    @objc dynamic public private(set) var name = ""
    
    static var delegate: LocationDelegate?
    
    static let obj = Location.self
    static let config = RealmConfig.LocationConfig
    
    override class func primaryKey() -> String {
        return "woeid"
    }
    
    override class func indexedProperties() -> [String] {
        return []
    }
    
    convenience required init(woeid: String, name: String){
        self.init()
        self.woeid = woeid
        self.name = name
    }
    
    static func insert(woeid: String, name: String){
        REALM_QUEUE.sync {
            if getLocation(byId: woeid) == nil{
                let message = Location(woeid: woeid, name: name)
                do {
                    let realm = try Realm(configuration: config)
                    try realm.write {
                        realm.add(message)
                        try realm.commitWrite()
                        delegate?.locationUpdated()
                    }
                } catch {
                    
                }
            }
        }
    }
    
    static func checkInitLocations() {
        print(Location.locationCount())
        if Location.locationCount() == 0 {
            Location.insert(woeid: "839722", name: "Sofia")
            Location.insert(woeid: "2459115", name: "New York")
            Location.insert(woeid: "1118370", name: "Tokyo")
        }
    }
    
    static func getLocations() -> Results<Location>?{
        do {
            let realm = try Realm(configuration: config)
            return realm.objects(obj)
        } catch {
            return nil
        }
    }
    
    static func locationCount() -> Int {
        if let locations = getLocations() {
            return locations.count
        }
        return 0
    }
    
    static func getLocation(byId id: String) -> Location?{
        do {
            let realm = try Realm(configuration: config)
            let location = realm.object(ofType: obj, forPrimaryKey: id)
            return location
        } catch {
            return nil
        }
    }
    
    static func removeAll(){
        do {
            let realm = try Realm(configuration: config)
            try realm.write {
                realm.deleteAll()
                try realm.commitWrite()
                delegate?.locationUpdated()
            }
        } catch {
            
        }
    }
}

protocol LocationDelegate {
    func locationUpdated()
}

