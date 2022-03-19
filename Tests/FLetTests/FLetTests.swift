import XCTest
@testable import FLet

final class FLetTests: XCTestCase {
    func testExample() throws {
        XCTAssert(
            __.testing.suite {
                try __.testing.assert(true)
            }
        )
    }
}
