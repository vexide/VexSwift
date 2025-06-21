@inline(__always)
@_cdecl("vexSystemExitRequest")
public func vexSystemExitRequest() {
    typealias RawFunc = @convention(c) () -> Void

    let rawFunc = UnsafeRawPointer(bitPattern: jumpTableStart)!
        .load(fromByteOffset: 0x130, as: RawFunc.self)

    return rawFunc()
}
