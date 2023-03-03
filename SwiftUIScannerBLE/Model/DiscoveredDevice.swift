//
//  DiscoveredDevice.swift
//  SwiftUIScannerBLE
//
//  Created by Hiago Santos Martins Dias on 02/03/23.
//

import CoreBluetooth

struct DiscoveredDevice: Identifiable {
    var id = UUID()
    var name: String
    var uuid: String
    var rssi: String
    var date: String
    var peripheral: CBPeripheral
}

