# RSP Game

[SwiftUI 2.0 - How to make an iPhone App (2020)]: https://www.youtube.com/watch?v=68g4z6CVIaQ

## Markup Comments

1. `// MARK:`    설명
2. `// FIXME:`    버그 수정
3. `// TODO:`    할 일
4. `-` 구분선 추가

**대문자**로 써야 한다는 것과 **콜론**을 꼭 붙여 써야 한다는 점

위와 같은 지시자를 사용하면 Xcode 편집창 상단 네비게이터를 좀 더 구조적으로 표현할 수 있게 됨.

사용예시:

```swift
// MARK: - your text goes here
-> 드롭다운 목록에 'your text goes here' 라고 굵은 글씨로 표시되며, 수평 구분자가 그 위에 나타나게 된다.
```

Objective-C에서는 메소드 탐색 기능을 활용할 때 #pragma mark를 사용했었음

## QuickHelp

'///' 주석을 활용해 Quick Help를 이용할 수 있음. (사용방법은 **변수 위에다 Option + 커서**)

 `/// 내용` -> QuickHelp의 Summary 부분

`/// - 내용` -> QuickHelp의 Discussion 부분으로 나오게 됨

