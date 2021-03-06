//
//  ScannerBle.swift
//  magnet
//
//  Created by Francisco Jordano on 13/04/2016.
//  Licencse MPL-2.0
//

import Foundation

@objc(ScannerBle)
class ScannerBle: NSObject, BeaconScannerDelegate {
  
  var bridge: RCTBridge!
  var scanner: BeaconScanner!
  
  @objc func start() -> Void {
    NSLog("Starting btle scanner");
    self.scanner = BeaconScanner();
    self.scanner.delegate = self
    self.scanner.start();
  }
  
  func notify(urls: Array<String>) {
    NSLog("Notifying JS context for the following urls");
    for url in urls {
      NSLog("%@", url);
    }
    self.bridge.eventDispatcher.sendDeviceEventWithName("magnet:urlfound", body: urls);
  }
  
  @objc func stop() -> Void {
    NSLog("Stoping scanner");
    self.scanner.stop();
  }
  
  func urlContextChanged(beaconScanner: BeaconScanner) {
    self.notify(beaconScanner.urls);
  }
}