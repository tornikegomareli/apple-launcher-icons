import Foundation

enum IconGeneratorError: LocalizedError {
    case invalidImageFile
    case notPNGFormat
    case imageNotSquare(width: Int, height: Int)
    case imageTooSmall(size: Int)
    case noXcodeProjectFound
    case noPlatformsDetected
    case failedToResizeImage(size: Int)
    case failedToSaveImage(path: String)
    
    var errorDescription: String? {
        switch self {
        case .invalidImageFile:
            return "Failed to load image file. Please ensure the file exists and is a valid image."
        case .notPNGFormat:
            return "Image must be in PNG format."
        case .imageNotSquare(let width, let height):
            return "Image must be square. Current dimensions: \(width)x\(height)"
        case .imageTooSmall(let size):
            return "Image must be at least 512x512 pixels (1024x1024 recommended for best quality). Current size: \(size)x\(size)"
        case .noXcodeProjectFound:
            return "No Xcode project found in the specified directory."
        case .noPlatformsDetected:
            return "No Apple platform targets detected in the project."
        case .failedToResizeImage(let size):
            return "Failed to resize image to \(size)x\(size)"
        case .failedToSaveImage(let path):
            return "Failed to save image to: \(path)"
        }
    }
}