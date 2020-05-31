import XCTest

import ArmatureTests
import ArmatureToolsTests

var tests = [XCTestCaseEntry]()
tests += ArmatureTests.__allTests()
tests += ArmatureToolsTests.__allTests()

XCTMain(tests)
