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
    
    func testExample4() throws {
        let s = """
        /// Unregister the given factory closure with given key.
        ///
        /// - note: This method is thread-safe.
        /// - parameter componentPath: The dependency graph path of the component
        /// the provider is for.
        """
        
        XCTAssertEqual(
            s.extractEnglishText(),
            "Unregister the given factory closure with given key." +
            "\n\n" +
            "- note: This method is thread-safe.\n" +
            "- parameter componentPath: The dependency graph path of the component the provider is for."
        )
    }
    
    
    func testExample5() throws {
        let s = """
        /// Returns the distance between two indices.
        ///
        /// - Parameters:
        ///   - start: A valid index of the collection.
        ///   - end: Another valid index of the collection. If `end` is equal to
        ///     `start`, the result is zero.
        /// - Returns: The distance between `start` and `end`.
        """
        
        XCTAssertEqual(
            s.extractEnglishText(),
            "Returns the distance between two indices." +
            "\n\n" +
            """
            - Parameters:
              - start: A valid index of the collection.
              - end: Another valid index of the collection. If `end` is equal to `start`, the result is zero.
            - Returns: The distance between `start` and `end`.
            """
        )
    }
    
    func testExample6() throws {
        let s = """
        /// The array's "past the end" position---that is, the position one greater
        /// than the last valid subscript argument.
        ///
        /// When you need a range that includes the last element of an array, use the
        /// half-open range operator (`..<`) with `endIndex`. The `..<` operator
        /// creates a range that doesn't include the upper bound, so it's always
        /// safe to use with `endIndex`. For example:
        ///
        ///     let numbers = [10, 20, 30, 40, 50]
        ///     if let i = numbers.firstIndex(of: 30) {
        ///         print(numbers[i ..< numbers.endIndex])
        ///     }
        ///     // Prints "[30, 40, 50]"
        ///
        /// If the array is empty, `endIndex` is equal to `startIndex`.
        """
        
        XCTAssertEqual(
            s.extractEnglishText(),
            "The array's \"past the end\" position---that is, the position one greater " +
            "than the last valid subscript argument." +
            "\n\n" +
            "When you need a range that includes the last element of an array, use the " +
            "half-open range operator (`..<`) with `endIndex`. The `..<` operator " +
            "creates a range that doesn't include the upper bound, so it's always " +
            "safe to use with `endIndex`. For example:" +
            "\n\n" +
            """
                let numbers = [10, 20, 30, 40, 50]
                if let i = numbers.firstIndex(of: 30) {
                    print(numbers[i ..< numbers.endIndex])
                }
                // Prints "[30, 40, 50]"
            
            If the array is empty, `endIndex` is equal to `startIndex`.
            """
        )
    }
}
