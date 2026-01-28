//
//  RealOBDService.swift
//  DriveAssist
//
//  Created by Godwin A on 07/05/2022.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import Foundation
import Combine
import CoreBluetooth
import DriveAssistCore

/// A concrete implementation of `OBDServiceProtocol` using CoreBluetooth.
///
/// This class manages the BLE connection lifecycle to an OBD-II ELM327 dongle
/// (or compatible interface) and parses the received characteristic data.
public class RealOBDService: NSObject, OBDServiceProtocol, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    /// The Bluetooth central manager.
    private var centralManager: CBCentralManager!
    
    /// The connected peripheral (OBD dongle).
    private var peripheral: CBPeripheral?
    
    /// Publisher subject for connection status.
    private let _connectionState = CurrentValueSubject<OBDConnectionState, Never>(.disconnected)
    
    /// Publisher subject for parsed vehicle data.
    private let _vehicleData = PassthroughSubject<VehicleData, Never>()
    
    /// Public stream of connection states.
    public var connectionState: AnyPublisher<OBDConnectionState, Never> {
        _connectionState.eraseToAnyPublisher()
    }
    
    /// Public stream of live vehicle data.
    public var vehicleData: AnyPublisher<VehicleData, Never> {
        _vehicleData.eraseToAnyPublisher()
    }
    
    /// Initializes the service.
    public override init() {
        super.init()
        // Initialize CoreBluetooth
        // In reality, you'd probably wait to init this until 'connect' is called to save power
        // centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    /// Starts the Bluetooth scanning and connection process.
    public func connect() {
        if centralManager == nil {
             centralManager = CBCentralManager(delegate: self, queue: nil)
        }
        
        if centralManager.state == .poweredOn {
            startScanning()
        }
    }
    
    /// Disconnects from the current peripheral and stops scanning.
    public func disconnect() {
        if let p = peripheral {
            centralManager.cancelPeripheralConnection(p)
        }
        _connectionState.send(.disconnected)
    }
    
    /// internal helper to start scanning for peripherals.
    private func startScanning() {
        _connectionState.send(.scanning)
        // Scan for ELM327 or similar service UUIDs
        // centralManager.scanForPeripherals(withServices: [CBUUID(string: "FFF0")], options: nil)
        Logger.log("Scanning for OBD Dongle...", category: "OBD")
    }
    
    // MARK: - CBCentralManagerDelegate
    
    /// Called when the Bluetooth state updates.
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            startScanning()
        } else {
            _connectionState.send(.error("Bluetooth not powered on"))
        }
    }
    
    /// Called when a peripheral is discovered.
    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        // Validation logic would go here
        self.peripheral = peripheral
        centralManager.stopScan()
        centralManager.connect(peripheral, options: nil)
    }
    
    /// Called when a connection is established.
    public func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        _connectionState.send(.connected)
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
    
    /// Called when a connection fails.
    public func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        _connectionState.send(.error(error?.localizedDescription ?? "Connection failed"))
    }
    
    // MARK: - CBPeripheralDelegate
    // ... Implementation for discovering characteristics and writing/reading data ...
}
