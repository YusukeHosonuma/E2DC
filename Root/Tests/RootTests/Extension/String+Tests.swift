import XCTest
@testable import Root

final class StringExtensionTests: XCTestCase {
    func testExample1() throws {
        let s = """
        /// A type to generate an `AXChartDescriptor` object that you use to provide
        /// information about a chart and its data for an accessible experience
        /// in VoiceOver or other assistive technologies.
        """
        
        XCTAssertEqual(
            s.extractEnglishText(),
            "A type to generate an `AXChartDescriptor` object that you use to provide " +
            "information about a chart and its data for an accessible experience " +
            "in VoiceOver or other assistive technologies."
        )
    }

    func testExample2() throws {
        let s = """
        /// A gesture that recognizes one or more taps.
        ///
        /// To recognize a tap gesture on a view, create and configure the gesture, and
        /// then add it to the view using the ``View/gesture(_:including:)`` modifier.
        /// The following code adds a tap gesture to a ``Circle`` that toggles the color
        /// of the circle.
        """
        
        XCTAssertEqual(
            s.extractEnglishText(),
            "A gesture that recognizes one or more taps." +
            "\n\n" +
            "To recognize a tap gesture on a view, create and configure the gesture, and " +
            "then add it to the view using the `View/gesture(_:including:)` modifier. " +
            "The following code adds a tap gesture to a `Circle` that toggles the color " +
            "of the circle."
        )
    }
    
    func testExample3() throws {
        let s = """
            /// Creates a text view that displays a string literal without localization.
            ///
            /// Use this initializer to create a text view with a string literal without
            /// performing localization:
        """
        
        XCTAssertEqual(
            s.extractEnglishText(),
            "Creates a text view that displays a string literal without localization." +
            "\n\n" +
            "Use this initializer to create a text view with a string literal without " +
            "performing localization:"
        )
    }
}
