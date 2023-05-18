//
//  foodRestrictionsUnitTests.swift
//  foodRestrictionsUnitTests
//
//  Created by Teaching on 5/17/23.
//

import XCTest
@testable import textReads

class foodRestrictionsUnitTests: XCTestCase {
    
    var sut: String!

    //everytime test runs
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
     try super.setUpWithError()
    sut = String()
    }

    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        let textReader = nil
        let fileName = nil
        var checkString = nil
        var result = nil
    }
    
    func testTxtReads(beforeString: String, afterString:String)
    {
        let textReader = textReads()
        
        // Call the txtReads function and provide a test file name
        let fileName = "meat and chicken and bread"
        var checkString = textReader.txtReads(fileName: fileName)
        
        // Perform assertions to verify the expected behavior
        XCTAssertEqual(fileName, checkString)
        
    }
    
    func test_UserCameraCheck() {
        requestDataScannerAccessStatus()
        var result = sut?.requestDataScannerAccessStatus()
        XCTAssert(result, "authorized")
    }
     
    /*
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
     */

}
