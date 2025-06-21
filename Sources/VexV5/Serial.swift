import VexSdk

public struct SerialChannel: RawRepresentable, Sendable {
    public let rawValue: UInt32

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let maxCapacity: Int32 = 2048

    public static let stdio = Self(rawValue: 1)
}

public struct SerialOutputStream: Sendable {
    public let channel: SerialChannel

    public init(channel: SerialChannel) {
        self.channel = channel
    }

    public static let stdout = Self(channel: .stdio)

    public func capacity() -> UInt32 {
        UInt32(vexSerialWriteFree(channel: channel.rawValue))
    }

    public func write(_ byte: UInt8) {
        while true {
            let written = vexSerialWriteChar(channel: channel.rawValue, byte)

            if written < 1 {
                vexTasksRun()
            } else {
                break
            }
        }
    }

    public func write(_ buffer: UnsafeBufferPointer<UInt8>) {
        guard let baseAddress = buffer.baseAddress else {
            return
        }

        var bytesWritten = 0

        while bytesWritten < buffer.count {
            let written = vexSerialWriteBuffer(
                channel: channel.rawValue,
                data: baseAddress.advanced(by: bytesWritten),
                length: UInt32(buffer.count - bytesWritten),
            )

            if written < 1 {
                vexTasksRun()
            } else {
                bytesWritten += Int(written)
            }
        }
    }

    public func write(_ bytes: [UInt8]) {
        bytes.withUnsafeBufferPointer { buffer in
            write(buffer)
        }
    }

    public func flush() {
        while capacity() < SerialChannel.maxCapacity {
            vexTasksRun()
        }
    }
}

extension SerialOutputStream: TextOutputStream {
    public func write(_ string: String) {
        string.utf8Span.span.withUnsafeBufferPointer { buffer in
            write(buffer)
        }
    }
}