import XCTest
@testable import HeimDall

final class HeimDallTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(HeimDall().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
