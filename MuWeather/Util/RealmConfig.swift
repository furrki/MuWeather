//
//  RealmConfig.swift
//  MuWeather
//
//  Created by Admin on 16.03.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import Foundation
import RealmSwift

class RealmConfig {
    static var LocationConfig: Realm.Configuration {
        let realmPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(REALM_LOCATION_CONFIG)
        let config = Realm.Configuration(
            fileURL: realmPath,
            schemaVersion: 0,
            migrationBlock:{ migration, oldSchemaVersion in
                if(oldSchemaVersion < 0) {

                }
        })
        return config
    }
}
