//
//  HomeViewModel.swift
//  SwiftUIScannerBLE
//
//  Created by Hiago Santos Martins Dias on 02/03/23.
//

import CoreBluetooth

class HomeViewModel: NSObject, ObservableObject, CBCentralManagerDelegate {
    private var centralManager: CBCentralManager!
    @Published var discoveredDevices = [DiscoveredDevice]()
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func startScanning() {
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func stopScanning() {
        centralManager.stopScan()
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            startScanning()
        default:
            break
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let name = advertisementData[CBAdvertisementDataLocalNameKey] as? String ?? advertisementData[CBAdvertisementDataManufacturerDataKey] as? String ?? "Unknown"
        let uuid = peripheral.identifier.uuidString
        let rssi = RSSI.stringValue
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        let dateString = dateFormatter.string(from: date)
        let device = DiscoveredDevice(name: name, uuid: uuid, rssi: rssi, date: dateString, peripheral: peripheral)
        
        // Check if the device is already in the array
        if !discoveredDevices.contains(where: { $0.uuid == device.uuid }) {
            discoveredDevices.append(device)
        }
    }

    
    func clearList() {
        discoveredDevices.removeAll()
    }
}
