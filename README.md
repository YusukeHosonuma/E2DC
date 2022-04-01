# E2DC

**E**xtract **E**nglish text from Swift's **D**ocumentation **C**omment.

ドキュメンテーションコメントに書かれた英語を翻訳したい場合に、便利かもしれないツールです。<br>
（現時点では Swift のみ大雑把に対応）

https://user-images.githubusercontent.com/2990285/160504047-f336470b-011c-489b-be26-60d81ca29659.mov

## Requirements

- macOS 12+
- iOS 15+

## Development

```bash
brew install mint
mint bootstrap
```

## FAQ

Q. AppStore で配布して欲しい。<br>
A. [macOS版については AppStore で公開済み](https://apps.apple.com/app/id1616576556)です。iOS版も近日中にリリースを予定しています。

Q. うまく変換できないときがある。<br>
A. 現時点では**大雑把に動けばいい**というスタンスのため[実装は雑](https://github.com/YusukeHosonuma/E2DC/blob/main/Root/Sources/Root/Extension/String%2B.swift)です。改善PRについてはいつでも歓迎です 🙏

Q. Swift以外の言語は対応しないの？
A. 需要がありそうなら対応したいと考えています。（自分が欲しい物を優先した結果、Swiftのみ最初に対応しました）

Q. もっと実践的な SwiftUI アプリを作って。どうぞ。<br>
A. [Swift-Evolution-Browser](https://github.com/YusukeHosonuma/Swift-Evolution-Browser/)

## Links

- [Effective SwiftUI 候補（仮説）](https://zenn.dev/tobi462/scraps/905f2e6ac9b895)
- [SFReadableSymbols](https://github.com/YusukeHosonuma/SFReadableSymbols)

## Author

Yusuke Hosonuma / [@tobi462](https://twitter.com/tobi462)
