import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
    let pasteboard: NSPasteboard = .general
    var lastChangeCount: Int = 0
    
    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }

    override func applicationDidFinishLaunching(_ notification: Notification) {
        let controller : FlutterViewController = mainFlutterWindow?.contentViewController as! FlutterViewController
        let channel = FlutterMethodChannel.init(name: "clipboard/image", binaryMessenger: controller.engine.binaryMessenger)
        
        if #available(macOS 10.13, *) {
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (t) in
                if self.lastChangeCount != self.pasteboard.changeCount {
                    self.lastChangeCount = self.pasteboard.changeCount
                    
                    // (1)读文件
                    guard let fileData = self.pasteboard.data(forType: NSPasteboard.PasteboardType.fileURL) else {
                        debugPrint("no file in clipboard")
                        // (2)读文本
                        guard let stringData = self.pasteboard.data(forType: NSPasteboard.PasteboardType.string) else {
                            debugPrint("no string in clipboard")
                            // (3)读图片
                            guard let imgData = self.pasteboard.data(forType: NSPasteboard.PasteboardType.tiff) else {
                                debugPrint("no image in clipboard")
                                return
                            }
                            let bitmap: NSBitmapImageRep = NSBitmapImageRep(data: imgData)!
                            guard let data = bitmap.representation(using: NSBitmapImageRep.FileType.png, properties: [NSBitmapImageRep.PropertyKey.compressionFactor: 1.0]) else {
                                debugPrint("can not create PNG")
                                return
                            }
                            let imgValue = data.base64EncodedString()
                            channel.invokeMethod("postContent", arguments: ["type":1, "value":imgValue])
                            return
                        }
                        guard let stringValue = String(bytes: stringData, encoding: .utf8) else {
                            debugPrint("can not transform stringData to string")
                            return
                        }
                        channel.invokeMethod("postContent", arguments: ["type":0, "value":stringValue])
                        return
                    }
                    guard let fileValue = String(bytes: fileData, encoding: .utf8) else {
                        debugPrint("can not transform fileData to string")
                        return
                    }
                    channel.invokeMethod("postContent", arguments: ["type":2, "value":fileValue])
                }
            }
        }
        
        channel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if (call.method == "setClipboardFile") {
                self.setClipboardFile(call: call, result: result)
            } else if (call.method == "setClipboardImage") {
                self.setClipboardImage(call: call, result: result)
            }else {
                result(FlutterMethodNotImplemented)
            }
        })
    }
    
    private func setClipboardImage(call: FlutterMethodCall, result: FlutterResult) {
        let imgData = Data (base64Encoded: call.arguments as! String, options: .ignoreUnknownCharacters)!
        let image = NSImage (data: imgData)!
        let pb = NSPasteboard.general
        pb.clearContents()
        pb.writeObjects([image])
        result(NSNull())
    }
        
    private func setClipboardFile(call: FlutterMethodCall, result: FlutterResult) {
        let ins = FileManager.default
        let urlStr = call.arguments as! String
        guard let url = URL(string: urlStr) else {
            debugPrint("can not transform to url")
            result(NSNull())
            return
        }
        let exist = ins.fileExists(atPath: url.path)
        if exist {
            let pb = NSPasteboard.general
            if let fileRefURL = (url as NSURL).fileReferenceURL() as NSURL? {
                pb.clearContents()
                pb.writeObjects([fileRefURL])
                if #available(macOS 10.13, *) {
                    pb.setString(urlStr, forType: .fileURL)
                }
            }
        }
        result(NSNull())
    }
}
