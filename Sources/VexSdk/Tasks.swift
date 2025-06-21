@inline(__always)
@_cdecl("vexTasksRun")
public func vexTasksRun() {
    typealias RawFunc = @convention(c) () -> Void

    let rawFunc = UnsafeRawPointer(bitPattern: jumpTableStart)!
        .load(fromByteOffset: 0x05c, as: RawFunc.self)

    return rawFunc()
}
