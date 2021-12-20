import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }

    override func applicationDidFinishLaunching(_ notification: Notification) {
        let controller : FlutterViewController = mainFlutterWindow?.contentViewController as! FlutterViewController
        let channel = FlutterMethodChannel.init(name: "clipboard/image", binaryMessenger: controller.engine.binaryMessenger)
        channel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if (call.method == "getClipboardFile") {
                self.getClipboardFile(result: result)
            } else if (call.method == "setClipboardFile") {
                self.setClipboardFile(call: call, result: result)
            } else if (call.method == "getClipboardImage") {
                self.getClipboardImage(result: result)
            } else if (call.method == "setClipboardImage") {
                self.setClipboardImage(call: call, result: result)
            }else {
                result(FlutterMethodNotImplemented)
            }
        })
    }

    private func getClipboardImage(result: FlutterResult) {
        let pb = NSPasteboard.general
        let type = NSPasteboard.PasteboardType.tiff
        guard let imgData = pb.data(forType: type) else {
            print("no image in clipboard")
            return
        }
        let bitmap: NSBitmapImageRep = NSBitmapImageRep(data: imgData)!
        guard let data = bitmap.representation(using: NSBitmapImageRep.FileType.png, properties: [NSBitmapImageRep.PropertyKey.compressionFactor: 1.0]) else {
            print("Couldn't create PNG")
            return
       }
        let base64 = data.base64EncodedString()
        result(base64)
    }
    
    
    private func setClipboardImage(call: FlutterMethodCall, result: FlutterResult) {
        let imgData = Data (base64Encoded: call.arguments as! String, options: .ignoreUnknownCharacters)!
        let image = NSImage (data: imgData)!
        let pb = NSPasteboard.general
        pb.clearContents()
        pb.writeObjects([image])
        result(NSNull())
    }
    
    private func getClipboardFile(result: FlutterResult) {
        let pb = NSPasteboard.general
        if #available(macOS 10.13, *) {
            guard let data = pb.data(forType: NSPasteboard.PasteboardType.fileURL) else {
                print("no file in clipboard")
                result(NSNull())
                return
            }
            guard let str = String(bytes: data, encoding: .utf8) else {
                print("can not transform to string")
                result(NSNull())
                return
            }
            result(str)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func setClipboardFile(call: FlutterMethodCall, result: FlutterResult) {
        let ins = FileManager.default
        let urlStr = call.arguments as! String
        guard let url = URL(string: urlStr) else {
            print("can not transform to url")
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
