// The Swift Programming Language
// https://docs.swift.org/swift-book

import VexV5
import VexSdk

@main
struct VexSwiftApp {
    static func main() {
        // Make sure all the dependencies work
        // https://docs.swift.org/embedded/documentation/embedded/externaldependencies

        // 1. using print() - putchar
        print("Hello, world!")

        // 2. instantiating a class, or using UnsafeMutablePointer.allocate() - posix_memalign, free
        let myClass = TestClass(value: "Hello from a class")
        myClass.printValue()

        print("My number is \(40)")

        // 3. Hashable, Set, Dictionary, or random-number generating APIs - arc4random_buf
        var generator = SystemRandomNumberGenerator()
        print("Random number: \(generator.next())")

        while true {
            vexTasksRun()
        }
    }
}

class TestClass {
    var value: String

    init(value: String) {
        self.value = value
    }

    func printValue() {
        print(value)
    }
}