//
//  Tests_iOSLaunchTests.swift
//  Tests iOS
//
//  Created by Yusuke Hosonuma on 2022/03/28.
//

import XCTest

class FastlaneSnapshotTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        XCUIDevice.shared.orientation = .portrait

        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        
        let sourceTextField = app.textViews.firstMatch
        sourceTextField.tap()
        sourceTextField.typeText("""
          /// The position of the first element in a nonempty array.
          ///
          /// For an instance of `Array`, `startIndex` is always zero. If the array
          /// is empty, `startIndex` is equal to `endIndex`.
        """)

        snapshot("launch")
        
        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app
        // let attachment = XCTAttachment(screenshot: app.screenshot())
        // attachment.name = "Launch Screen"
        // attachment.lifetime = .keepAlways
        // add(attachment)
    }
}
