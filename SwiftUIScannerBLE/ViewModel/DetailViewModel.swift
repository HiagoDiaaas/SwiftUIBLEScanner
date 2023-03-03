//
//  DetailViewModel.swift
//  SwiftUIScannerBLE
//
//  Created by Hiago Santos Martins Dias on 02/03/23.
//
import CoreBluetooth
import SwiftUI

import CoreBluetooth
import SwiftUI

class DetailViewModel: NSObject, ObservableObject {
    @Published var manufacturerName: String = ""
    @Published var modelName: String = ""
    @Published var isConnecting: Bool = false
    var selectedPeripheral: CBPeripheral?
    var centralManager: CBCentralManager?
    let heartRateDeviceService = CBUUID(string: "0x180A")
    let modelNumberStringCharacteristicCBUUID = CBUUID(string: "2A24")
    let manufacturerNameStringCBUUID = CBUUID(string: "2A29")
    
    var device: DiscoveredDevice
    
    init(device: DiscoveredDevice) {
        self.device = device
    }
    
    func connectToDevice(peripheral: CBPeripheral) {
        selectedPeripheral = peripheral
        centralManager = CBCentralManager(delegate: self, queue: nil)
        isConnecting = true
    }
}

extension DetailViewModel: CBCentralManagerDelegate, CBPeripheralDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            centralManager?.scanForPeripherals(withServices: [heartRateDeviceService], options: nil)
        default:
            break
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if peripheral == selectedPeripheral {
            selectedPeripheral?.delegate = self
            centralManager?.connect(selectedPeripheral!, options: nil)
            centralManager?.stopScan()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices([heartRateDeviceService])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics {
            if characteristic.uuid == modelNumberStringCharacteristicCBUUID {
                peripheral.readValue(for: characteristic)
            }
            if characteristic.uuid == manufacturerNameStringCBUUID {
                peripheral.readValue(for: characteristic)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if characteristic.uuid == modelNumberStringCharacteristicCBUUID {
            if let model = characteristic.value {
                modelName = String(data: model, encoding: .utf8) ?? ""
            }
        }
        if characteristic.uuid == manufacturerNameStringCBUUID {
            if let manufacturer = characteristic.value {
                manufacturerName = String(data: manufacturer, encoding: .utf8) ?? ""
            }
        }
    }
}
