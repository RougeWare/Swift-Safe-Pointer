[![CodeFactor](https://www.codefactor.io/repository/github/rougeware/swift-safe-pointer/badge)](https://www.codefactor.io/repository/github/rougeware/swift-safe-pointer)

# SafePointer #

Lets you pass anything using reference semantics without the danger of unsafe pointers.

Do note that this is more of a conceptual pointer; one which points to some instance. This acknowledges no concept of memory addresses nor traversing memory. For that, you can use Swift's built-in `UnsafePointer` and its sisters.


## Kinds ##

* [`SafePointer`](https://github.com/RougeWare/Swift-Lazy-Patterns/blob/SafePointer%20(Swift%20Package)/Sources/SafePointer/SafePointer.swift#L64-L93): A pointer which carries no danger in its use. If there's a crash, it won't be `SafePointer`'s fault!
* [`MutableSafePointer`](https://github.com/RougeWare/Swift-Lazy-Patterns/blob/SafePointer%20(Swift%20Package)/Sources/SafePointer/SafePointer.swift#L96-L134): A mutable version of `SafePointer`. Also lets you provide a did-set listener!

* And a framework for building your own kinds of pointers!


## Compatibility ##

In version `1.0.0`, the key file was located at `./SafePointer (Swift Package)/Sources/SafePointer/SafePointer.swift`. Now, it is located at `./Sources/SafePointer/SafePointer.swift`. Because the location of the file in the repo changed entirely, the version number was changed to `2.0.0`, although **the API has not changed at all since `1.0.0`**. As long as you make your project point to `SafePointer.swift`, it will be precisely the same in `2.0.0` as it was in `1.0.0`.
