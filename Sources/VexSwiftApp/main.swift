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

        // _ = vexSerialWriteChar(channel: 1, "H".utf8.first!)
        // _ = vexSerialWriteChar(channel: 1, "E".utf8.first!)
        // _ = vexSerialWriteChar(channel: 1, "L".utf8.first!)
        // _ = vexSerialWriteChar(channel: 1, "L".utf8.first!)
        // _ = vexSerialWriteChar(channel: 1, "O".utf8.first!)
        // _ = vexSerialWriteChar(channel: 1, "\n".utf8.first!)

        // 2. instantiating a class, or using UnsafeMutablePointer.allocate() - posix_memalign, free

        // 3. Hashable, Set, Dictionary, or random-number generating APIs - arc4random_buf

        while true {
            vexTasksRun()
        }
    }
}