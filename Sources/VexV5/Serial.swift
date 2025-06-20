let jumpTableStart: UInt = 0x037fc000
public let stdioChannel: UInt32 = 1

@inline(__always)
@_cdecl("vexSerialWriteChar")
public func vexSerialWriteChar(_ channel: UInt32, _ c: UInt8) -> Int32 {
    typealias RawFunc = @convention(c) (UInt32, UInt8) -> Int32

    let rawFunc = UnsafeRawPointer(bitPattern: jumpTableStart)!
        .load(fromByteOffset: 0x898, as: RawFunc.self)

    return rawFunc(channel, c)
}

@inline(__always)
@_cdecl("vexTasksRun")
public func vexTasksRun() {
    typealias RawFunc = @convention(c) () -> Void

    let rawFunc = UnsafeRawPointer(bitPattern: jumpTableStart)!
        .load(fromByteOffset: 0x05c, as: RawFunc.self)

    return rawFunc()
}