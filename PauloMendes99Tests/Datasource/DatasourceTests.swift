//
//  DatasourceTests.swift
//  PauloMendes99
//
//  Created by Paulo Mendes on 26/02/17.
//  Copyright © 2017 99. All rights reserved.
//

import XCTest
@testable import PauloMendes99

class DatasourceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testDatasourceShouldCallReadPersonsFileOnGetPersons() {
        class FauxFileUtils: FileUtilsProtocol {
            var passed = false
            internal func readPersonsFile(success: @escaping (Data, FileUtilsError) -> Void) {
                passed = true
                success(Data(), .none)
            }
        }
        
        let fauxFileUtils = FauxFileUtils()
        let personsDataSource = PersonsDataSource(fileUtils: fauxFileUtils)
        
        personsDataSource.getPersons(success: { (persons) in
            XCTAssertTrue(fauxFileUtils.passed)
        }) { (err) in
            XCTAssertTrue(fauxFileUtils.passed)
        }
    }
    
    func testShouldReturnFileErrorInCaseOfFileUtilsReturnFileNotFound() {
        class FauxFileUtils: FileUtilsProtocol {
            var passed = false
            internal func readPersonsFile(success: @escaping (Data, FileUtilsError) -> Void) {
                passed = true
                success(Data(), .fileNotFound)
            }
        }
        
        let fauxFileUtils = FauxFileUtils()
        let personsDataSource = PersonsDataSource(fileUtils: fauxFileUtils)
        
        personsDataSource.getPersons(success: { (persons) in
            XCTFail()
        }) { (err) in
            XCTAssertEqual(err, .fileError)
        }
    }
    
    func testShouldReturnFileErrorInCaseOfFileUtilsReturnInvalidFile() {
        class FauxFileUtils: FileUtilsProtocol {
            var passed = false
            internal func readPersonsFile(success: @escaping (Data, FileUtilsError) -> Void) {
                passed = true
                success(Data(), .invalidFileFormat)
            }
        }
        
        let fauxFileUtils = FauxFileUtils()
        let personsDataSource = PersonsDataSource(fileUtils: fauxFileUtils)
        
        personsDataSource.getPersons(success: { (persons) in
            XCTFail()
        }) { (err) in
            XCTAssertEqual(err, .fileError)
        }
    }
    
    func testShouldReturnJsonSerializationErrorInCaseOfInvalidDataObject() {
        class FauxFileUtils: FileUtilsProtocol {
            var passed = false
            internal func readPersonsFile(success: @escaping (Data, FileUtilsError) -> Void) {
                passed = true
                success(Data(), .none)
            }
        }
        
        let fauxFileUtils = FauxFileUtils()
        let personsDataSource = PersonsDataSource(fileUtils: fauxFileUtils)
        
        personsDataSource.getPersons(success: { (persons) in
            XCTAssertTrue(true)
        }) { (err) in
            XCTAssertEqual(err, .jsonSerializationError)
        }
    }
    
    func testShouldReturnPersonSerializationErrorInCaseOfInvalidPersonDataObject() {
        class FauxFileUtils: FileUtilsProtocol {
            var passed = false
            internal func readPersonsFile(success: @escaping (Data, FileUtilsError) -> Void) {
                passed = true
                let str = "[{\"Invalid\" : \"Json Array\"}, {\"Invalid\" : \"Json Array\"}]"
                let data = str.data(using: String.Encoding.utf8)
                success(data!, .none)
            }
        }
        
        let fauxFileUtils = FauxFileUtils()
        let personsDataSource = PersonsDataSource(fileUtils: fauxFileUtils)
        
        personsDataSource.getPersons(success: { (persons) in
            XCTFail()
        }) { (err) in
            XCTAssertEqual(err, .personSerializationError)
        }
    }
    
    func testShouldReturnSuccessInCaseOfCorrectPersonData() {
        class FauxFileUtils: FileUtilsProtocol {
            var passed = false
            internal func readPersonsFile(success: @escaping (Data, FileUtilsError) -> Void) {
                passed = true
                let str = "[{ \"id\": \"97d16abc-1569-43e0-929b-cef05cd850fb\", \"name\": \"Steve Jobs\", \"image\": \"http://adsoftheworld.com/files/steve-jobs.jpg\", \"birthday\": \"1955-02-24T00:00:00Z\" }]"
                
                let data = str.data(using: String.Encoding.utf8)
                success(data!, .none)
            }
        }
        
        let fauxFileUtils = FauxFileUtils()
        let personsDataSource = PersonsDataSource(fileUtils: fauxFileUtils)
        
        personsDataSource.getPersons(success: { (persons) in
            XCTAssertTrue(true)
            XCTAssertEqual(persons.entries.count, 1)
            XCTAssertEqual(persons.entries[0].name, "Steve Jobs")
            XCTAssertEqual(persons.entries[0].image, URL.init(string: "http://adsoftheworld.com/files/steve-jobs.jpg"))
            XCTAssertEqual(persons.entries[0].id, "97d16abc-1569-43e0-929b-cef05cd850fb")
            
        }) { (err) in
            XCTFail()
        }
    }
}
