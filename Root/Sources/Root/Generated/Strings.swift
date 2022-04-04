// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// About
  internal static let about = L10n.tr("Localizable", "about")
  /// Automatically launch DeepL at pasted
  internal static let automaticallyLaunchDeeplAtPasted = L10n.tr("Localizable", "automatically_launch_deepl_at_pasted")
  /// Clear
  internal static let clear = L10n.tr("Localizable", "clear")
  /// Copy to Clipboard
  internal static let copyToClipboard = L10n.tr("Localizable", "copy_to_clipboard")
  /// Copy to DeepL
  internal static let copyToDeepl = L10n.tr("Localizable", "copy_to_deepl")
  /// Destination
  internal static let destination = L10n.tr("Localizable", "destination")
  /// Paste
  internal static let paste = L10n.tr("Localizable", "paste")
  /// Please paste documentation comment.
  internal static let pleasePasteDocumentationComment = L10n.tr("Localizable", "please_paste_documentation_comment")
  /// Quit
  internal static let quit = L10n.tr("Localizable", "quit")
  /// Source
  internal static let source = L10n.tr("Localizable", "source")
  /// Version
  internal static let version = L10n.tr("Localizable", "version")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
