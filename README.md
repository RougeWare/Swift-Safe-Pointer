# SafePointer #

Lets you pass anything using reference semantics without the danger of unsafe pointers.

Do note that this is more of a conceptual pointer; one which points to some instance. This acknowledges no concept of memory addresses nor traversing memory. For that, you can use Swift's built-in `UnsafePointer` and its sisters.


## Kinds ##

* [`SafePointer`](https://github.com/RougeWare/Swift-Lazy-Patterns/blob/SafePointer%20(Swift%20Package)/Sources/SafePointer/SafePointer.swift#L64-L93): A pointer which carries no danger in its use. If there's a crash, it won't be `SafePointer`'s fault!
* [`MutableSafePointer`](https://github.com/RougeWare/Swift-Lazy-Patterns/blob/SafePointer%20(Swift%20Package)/Sources/SafePointer/SafePointer.swift#L96-L134): A mutable version of `SafePointer`. Also lets you provide a did-set listener!

* And a framework for building your own kinds of pointers!
