import Foundation
import CoreGraphics
import ImageIO
import UniformTypeIdentifiers

/// Handles image loading, validation, and resizing
struct ImageProcessor {
    private let sourceImagePath: String
    private let cgImage: CGImage
    
    init(imagePath: String) throws {
        self.sourceImagePath = imagePath
        
        guard let imageSource = CGImageSourceCreateWithURL(URL(fileURLWithPath: imagePath) as CFURL, nil),
              let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil) else {
            throw IconGeneratorError.invalidImageFile
        }
        guard let uti = CGImageSourceGetType(imageSource),
              UTType(uti as String) == UTType.png else {
            throw IconGeneratorError.notPNGFormat
        }
        
        self.cgImage = image
        guard cgImage.width == cgImage.height else {
            throw IconGeneratorError.imageNotSquare(width: cgImage.width, height: cgImage.height)
        }
        guard cgImage.width >= 512 else {
            throw IconGeneratorError.imageTooSmall(size: cgImage.width)
        }
    }
    
    /// Get the source image
    func getSourceImage() -> CGImage {
        return cgImage
    }
    
    /// Resize image to specified size
    func resize(to size: Int) -> CGImage? {
        let context = CGContext(
            data: nil,
            width: size,
            height: size,
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )
        
        context?.interpolationQuality = .high
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: size, height: size))
        
        return context?.makeImage()
    }
    
    /// Save image as PNG to specified path
    static func savePNG(_ image: CGImage, to path: String) throws {
        let url = URL(fileURLWithPath: path)
        let directory = url.deletingLastPathComponent()
        try FileManager.default.createDirectory(
            at: directory,
            withIntermediateDirectories: true,
            attributes: nil
        )
        
        guard let destination = CGImageDestinationCreateWithURL(url as CFURL, UTType.png.identifier as CFString, 1, nil) else {
            throw IconGeneratorError.failedToSaveImage(path: path)
        }
        
        CGImageDestinationAddImage(destination, image, nil)
        
        guard CGImageDestinationFinalize(destination) else {
            throw IconGeneratorError.failedToSaveImage(path: path)
        }
    }
}