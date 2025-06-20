// The Swift Programming Language
// https://docs.swift.org/swift-book

import VexV5
import VexV5Startup

@main
struct VexSwiftApp {
    static func main() {
        let character: UInt8 = "A".utf8.first ?? 0
        _ = vexSerialWriteChar(stdioChannel, character)

        while true {
            vexTasksRun()
        }
    }
}
