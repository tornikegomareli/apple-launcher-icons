import Foundation

/// Main icon generator that orchestrates the entire process
struct IconGenerator {
    let imagePath: String
    let projectPath: String
    let force: Bool
    let verbose: Bool
    let dryRun: Bool
    
    func generate() throws {
        print("🎨 Apple Launcher Icons Generator")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        
        if verbose {
            print("📸 Loading image from: \(imagePath)")
        }
        
        let imageProcessor = try ImageProcessor(imagePath: imagePath)
        let sourceImage = imageProcessor.getSourceImage()
        if sourceImage.width < 1024 {
            print("⚠️  Warning: Image size is \(sourceImage.width)x\(sourceImage.width). For best quality, use 1024x1024 or larger.")
        }
        if verbose {
            print("🔍 Detecting Apple platforms in: \(projectPath)")
        }
        
        let detector = ProjectDetector(projectPath: projectPath)
        let detectedProjects = try detector.detectPlatforms()
        
        guard !detectedProjects.isEmpty else {
            throw IconGeneratorError.noPlatformsDetected
        }
        
        print("\n✅ Detected platforms:")
        for project in detectedProjects {
            print("   • \(project.platform.rawValue) at \(project.projectPath)")
        }
        for project in detectedProjects {
            print("\n🚀 Generating \(project.platform.rawValue) icons...")
            try generateIcons(for: project, using: imageProcessor)
        }
        
        if dryRun {
            print("\n🔍 Dry run completed. No files were modified.")
        } else {
            print("\n✨ Successfully generated all icons!")
        }
    }
    
    private func generateIcons(for project: DetectedProject, using imageProcessor: ImageProcessor) throws {
        let assetsCatalogURL = URL(fileURLWithPath: project.assetsPath)
        let iconsetPath = assetsCatalogURL
            .appendingPathComponent(project.platform.assetCatalogName)
            .path
            
        if verbose {
            print("📁 Icon set path: \(iconsetPath)")
        }
        if !force && FileManager.default.fileExists(atPath: iconsetPath) && !dryRun {
            let iconsetURL = URL(fileURLWithPath: iconsetPath)
            let contents = try FileManager.default.contentsOfDirectory(
                at: iconsetURL,
                includingPropertiesForKeys: nil
            )
            let hasPNGFiles = contents.contains { $0.pathExtension.lowercased() == "png" }
            
            if hasPNGFiles {
                print("⚠️  Icon set already exists with icons at: \(iconsetPath)")
                print("   Use --force to overwrite")
                return
            } else {
                if verbose {
                    print("📝 Found empty icon set, will overwrite")
                }
            }
        }
        if !dryRun {
            try FileManager.default.createDirectory(
                at: URL(fileURLWithPath: iconsetPath),
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
        let templates = project.platform.iconTemplates
        var generatedCount = 0
        
        for template in templates {
            let outputPath = URL(fileURLWithPath: iconsetPath)
                .appendingPathComponent(template.filename)
                .path
            
            if verbose {
                print("   • Generating \(template.filename) (\(template.pixelSize)x\(template.pixelSize))")
            }
            
            if !dryRun {
                guard let resizedImage = imageProcessor.resize(to: template.pixelSize) else {
                    throw IconGeneratorError.failedToResizeImage(size: template.pixelSize)
                }
                
                try ImageProcessor.savePNG(resizedImage, to: outputPath)
            }
            
            generatedCount += 1
        }
        let contentsPath = URL(fileURLWithPath: iconsetPath)
            .appendingPathComponent("Contents.json")
            .path
        
        if verbose {
            print("   • Generating Contents.json")
        }
        
        if !dryRun {
            try generateContentsJSON(for: project.platform, at: contentsPath)
        }
        if let infoPlistPath = project.infoPlistPath {
            if verbose {
                print("   • Updating Info.plist")
            }
            
            if !dryRun {
                try PlistUpdater.updateInfoPlist(at: infoPlistPath, platform: project.platform)
            }
        }
        
        print("   ✓ Generated \(generatedCount) icons")
    }
    
    private func generateContentsJSON(for platform: Platform, at path: String) throws {
        var images: [[String: Any]] = []
        
        for template in platform.iconTemplates {
            let sizeString: String
            if template.size.truncatingRemainder(dividingBy: 1) == 0 {
                sizeString = "\(Int(template.size))x\(Int(template.size))"
            } else {
                sizeString = "\(template.size)x\(template.size)"
            }
            
            var image: [String: Any] = [
                "filename": template.filename,
                "idiom": template.idiom,
                "scale": "\(Int(template.scale))x",
                "size": sizeString
            ]
            
            if let platformValue = template.platform {
                image["platform"] = platformValue
            }
            
            images.append(image)
        }
        
        let contents: [String: Any] = [
            "images": images,
            "info": [
                "author": "apple-launcher-icons",
                "version": 1
            ]
        ]
        
        let jsonData = try JSONSerialization.data(withJSONObject: contents, options: [.prettyPrinted, .sortedKeys])
        try jsonData.write(to: URL(fileURLWithPath: path))
    }
}