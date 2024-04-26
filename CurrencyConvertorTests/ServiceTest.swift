//
//  ServiceTest.swift
//  CurrencyConvertorTests
//
//  Created by Prateek Sujaina on 26/04/24.
//

import XCTest

final class ServiceTest: XCTestCase {
    var networkService = NetworkMock()
    var service: Service!

    override func setUpWithError() throws {
        service = Service(networkSetvice: networkService)
        UserDefaults.standard.removeObject(forKey: service.keyLastDataLoadTimestamp)
    }

    func testCachePolicyOnFirstLoad() {
        XCTAssertTrue(service.canLoadFromRemote(), "On first load \"canLoadFromRemote()\" should return true!")
        XCTAssertEqual(service.cachePolicy(), URLRequest.CachePolicy.reloadIgnoringLocalCacheData)
    }
    
    func testLastDataRefreshTimestampUpdate() throws {
        XCTAssertEqual(service.dataLoadTimestamp, 0, "Initial value should be 0")
        let timestamp = Date().timeIntervalSince1970
        service.markLoadFromRemoteComplete()
        XCTAssertTrue(service.dataLoadTimestamp > timestamp, "\"dataLoadTimestamp\" not updating!")
    }
    
    func testCachePolicyPostRecentRemoteFetch() {
        service.markLoadFromRemoteComplete()
        XCTAssertEqual(service.cachePolicy(), URLRequest.CachePolicy.returnCacheDataElseLoad)
    }
}
