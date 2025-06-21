let jumpTableStart: UInt = 0x037fc000

@inline(__always)
@_cdecl("vexSerialWriteChar")
public func vexSerialWriteChar(channel: UInt32, _ c: UInt8) -> Int32 {
    typealias RawFunc = @convention(c) (UInt32, UInt8) -> Int32

    let rawFunc = UnsafeRawPointer(bitPattern: jumpTableStart)!
        .load(fromByteOffset: 0x898, as: RawFunc.self)

    return rawFunc(channel, c)
}

@inline(__always)
@_cdecl("vexSerialWriteBuffer")
public func vexSerialWriteBuffer(
    channel: UInt32,
    data: UnsafePointer<UInt8>,
    length: UInt32
) -> Int32 {
    typealias RawFunc = @convention(c) (UInt32, UnsafePointer<UInt8>, UInt32) -> Int32

    let rawFunc = UnsafeRawPointer(bitPattern: jumpTableStart)!
        .load(fromByteOffset: 0x89c, as: RawFunc.self)

    return rawFunc(channel, data, length)
}

@inline(__always)
@_cdecl("vexSerialWriteFree")
public func vexSerialWriteFree(channel: UInt32) -> Int32 {
    typealias RawFunc = @convention(c) (UInt32) -> Int32

    let rawFunc = UnsafeRawPointer(bitPattern: jumpTableStart)!
        .load(fromByteOffset: 0x8ac, as: RawFunc.self)

    return rawFunc(channel)
}

@inline(__always)
@_cdecl("vexBatteryCapacityGet")
public func vexBatteryCapacityGet() {
    typealias RawFunc = @convention(c) () -> Void

    let rawFunc = UnsafeRawPointer(bitPattern: jumpTableStart)!
        .load(fromByteOffset: 0x05c, as: RawFunc.self)

    return rawFunc()
}