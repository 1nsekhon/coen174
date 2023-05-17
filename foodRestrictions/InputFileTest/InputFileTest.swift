//
//  InputFileTest.swift
//  InputFileTest
//
//  Created by Nanki Sekhon on 5/17/23.
//

import XCTest
@testable import foodRestrictions

final class InputFileTest: XCTestCase {

    override func setUpWithError() throws {
        print("Smoke Test")
    }
    
    
     
     //ONE STRING
    func TestInputFile() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let fileType = ".txt";
        XCTAssertTrue(fileType == inputFile); //fail otherwise
    }
    
    /*
    func FoodRestrictionChoice () throws {
        //var choices:[String] = ["vegetarian", "gluten free"]; //given options
        //var chosen: Bool; //has the user chosen?
    }
     

    func SmokeTest () throws {
        print("Smoke Test");
    }
     */
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        //erase sample file type
    }

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
            //measure camera quality
        }
    }

}
