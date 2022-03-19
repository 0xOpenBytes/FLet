# FLet

*A collection of micro frameworks*

## Frameworks

- [t (FLet.testing)](https://github.com/0xOpenBytes/t): 🧪 Quickly test expectations
    - `t` is a simple testing framework using closures and errors. You have the ability to create a `suite` that has multiple steps, expectations, and asserts. Expectations can be used to `expect` one or multiple assertions. `t` can be used to test quickly inside a function to make sure something is working as expected. `t` can also be used in unit test if wanted.

- [c (FLet.composition)](https://github.com/0xOpenBytes/c): 📦 Micro Composition using Transformations and Cache
    - `c` is a simple composition framework. You have the ability to create transformations that are either unidirectional or bidirectional. There is also a cache that values can be set and resolved. `c` can be used anywhere to create transformations or interact with the cache.
    
- [o (FLet.transput)](https://github.com/0xOpenBytes/o): Output and Input for File, URL, and Console
    - `o` is a simple framework to output to a file, url, the console, or even register notification using UserNotifications. `o` can also get input from a file, url, or console. Currently, `o` can be used on macOS, iOS, and watchOS. 

## Usage

### Testing

<details> 
  <summary>Suite</summary> 

```swift
t.suite {
    // Add an expectation that asserting true is true and that 2 is equal to 2
    try t.expect {
        try t.assert(true)
        try t.assert(2, isEqualTo: 2)
    }
    
    // Add an assertion that asserting false is not true
    try t.assert(notTrue: false)
    
    // Add an assertion that "Hello" is not equal to "World"
    try t.assert("Hello", isNotEqualTo: "World")
    
    // Log a message
    t.log("📣 Test Log Message")
    
    // Log a t.error
    t.log(error: t.error(description: "Mock Error"))
    
    // Log any error
    struct SomeError: Error { }
    t.log(error: SomeError())
    
    // Add an assertion to check if a value is nil
    let someValue: String? = nil
    try t.assert(isNil: someValue)
    
    // Add an assertion to check if a value is not nil
    let someOtherValue: String? = "💠"
    try t.assert(isNotNil: someOtherValue)
}
```

</details> 

<details> 
  <summary>Expect</summary> 

```swift 
try t.expect {
    let someValue: String? = "Hello"
    try t.assert(isNil: someValue)
}
```

</details> 

<details> 
  <summary>Assert</summary> 

```swift 
try t.assert("Hello", isEqualTo: "World")
```

</details> 

<details> 
  <summary>Logging</summary> 

```swift 
t.log("📣 Test Log Message")
```

</details> 

<details> 
  <summary>XCTest</summary> 

```swift 

// Assert suite is true
XCTAssert(
    t.suite {
        try t.assert(true)
    }
)

// Assert expectation is true
XCTAssertNoThrow(
    try t.expect("true is true and that 2 is equal to 2") {
        try t.assert(true)
        try t.assert(2, isEqualTo: 2)
    }
)

// Assert is false
XCTAssertThrowsError(
    try t.assert(false)
)
```

</details> 

### Composition

<details> 
  <summary>Local Cache</summary> 

```swift 
let cache = c.cache()

cache.set(value: Double.pi, forKey: "🥧")

let pi: Double = cache.get("🥧") ?? 0

try t.assert(pi, isEqualTo: .pi)

let resolvedValue: Double = cache.resolve("🥧")

try t.assert(resolvedValue, isEqualTo: .pi)
```

</details> 

<details> 
  <summary>Global Cache</summary> 

```swift 
let someCache: Cache = ...

// Set the value of a Cache with any hashable key
c.set(value: someCache, forKey: "someCache")

// Get an optional Cache using any hashable key
let anotherCache: Cache? = c.get(0)

// Require that a Cache exist using a `.get` with a force unwrap
let requiredCache: Cache = c.resolve(0)
```

</details> 

<details> 
  <summary>Transformation</summary> 

```swift 
let transformer = c.transformer(
    from: { string in Int(string) },
    to: { int in "\(String(describing: int))" }
)

let string = transformer.to(3)
let int = transformer.from("3")

try t.assert(transformer.to(int), isEqualTo: string)
```

</details> 

### Transput

<details> 
  <summary>Console</summary> 

```swift 
o.console.out("Value to print: ", terminator: "") //    (oTests/oTests.swift@7) [testExample()]: Value to print:
o.console.out(o.console.in()) // Type in "???";         (oTests/oTests.swift@8) [testExample()]: Optional("???")
```

</details> 

<details> 
  <summary>File</summary> 

```swift 
let filename: String = ...

// Write the value 4, an Int, to the file named `filename`. Files using o.file are base64Encoded.
try o.file.out(4, filename: filename)

// Asserts
XCTAssertNoThrow(try o.file.in(filename: filename) as Int)
XCTAssertEqual(try? o.file.in(filename: filename), 4)

// Delete the File
try o.file.delete(filename: filename)

// Assert deletion
XCTAssertThrowsError(try o.file.in(filename: filename) as Int)
```

</details> 

<details> 
  <summary>URL</summary> 

```swift 
struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

// GET Request

o.url.in(
    url: URL(string: "api/posts")!,
    successHandler: { (posts: [Post], response) in
        print(posts)
    }
)

// POST Request

let post = Post(userId: 1, id: 1, title: "First!", body: "")

try o.url.out(
    url: URL(string: "api/posts/\(post.id)")!,
    value: post,
    successHandler: { data, response in
        print(response)
    }
)
```

</details> 

<details> 
  <summary>Notification</summary> 

```swift
// Request Notification Authorization 
o.notification.requestAuthorization()

// Set UNUserNotificationCenter.current's delegate to `o.notification.delegate`
o.notification.registerDelegate()

// Schedule a Notification
o.notification.post(
    title: "Hello!",
    subtitle: "o.notification",
    body: "Woo Hoo!",
    trigger: UNTimeIntervalNotificationTrigger(
        timeInterval: 3,
        repeats: false
    )
)
```

</details> 


### Shorthand Typealias
```swift
public typealias __ = FLet
```
