import Foundation

/// Detects the type of Apple project in a directory
struct ProjectDetector {
    let projectPath: String
    let fileManager = FileManager.default
    
    /// Detect all Apple platforms in the project
    func detectPlatforms() throws -> [DetectedProject] {
        var detectedProjects: [DetectedProject] = []
        
        let projectURL = URL(fileURLWithPath: projectPath)
        
        let contents = try fileManager.contentsOfDirectory(
            at: projectURL,
            includingPropertiesForKeys: nil
        )
        let xcodeProjects = contents.filter { $0.pathExtension == "xcodeproj" }
        let workspaces = contents.filter { $0.pathExtension == "xcworkspace" }
        let projectFile = xcodeProjects.first ?? workspaces.first
        
        guard let projectFile = projectFile else {
            throw IconGeneratorError.noXcodeProjectFound
        }
        if let iosProject = try detectiOSProject(at: projectURL, projectName: projectFile.deletingPathExtension().lastPathComponent) {
            detectedProjects.append(iosProject)
        }
        
        if let macProject = try detectMacOSProject(at: projectURL, projectName: projectFile.deletingPathExtension().lastPathComponent) {
            detectedProjects.append(macProject)
        }
        
        if let watchProject = try detectWatchOSProject(at: projectURL, projectName: projectFile.deletingPathExtension().lastPathComponent) {
            detectedProjects.append(watchProject)
        }
        
        if let tvProject = try detectTvOSProject(at: projectURL, projectName: projectFile.deletingPathExtension().lastPathComponent) {
            detectedProjects.append(tvProject)
        }
        
        return detectedProjects
    }
    
    private func detectiOSProject(at projectURL: URL, projectName: String) throws -> DetectedProject? {
        let possiblePaths = [
            projectName,
            "iOS",
            projectName + " iOS",
            projectName + "-iOS"
        ]
        
        for path in possiblePaths {
            let targetURL = projectURL.appendingPathComponent(path)
            if fileManager.fileExists(atPath: targetURL.path) {
                let infoPlistPath = targetURL.appendingPathComponent("Info.plist").path
                let assetsPath = targetURL.appendingPathComponent("Assets.xcassets").path
                
                if fileManager.fileExists(atPath: assetsPath) {
                    return DetectedProject(
                        platform: .iOS,
                        projectPath: targetURL.path,
                        assetsPath: assetsPath,
                        infoPlistPath: fileManager.fileExists(atPath: infoPlistPath) ? infoPlistPath : nil
                    )
                }
            }
        }
        
        return nil
    }
    
    private func detectMacOSProject(at projectURL: URL, projectName: String) throws -> DetectedProject? {
        let possiblePaths = [
            projectName,
            "macOS",
            projectName + " macOS",
            projectName + "-macOS"
        ]
        
        for path in possiblePaths {
            let targetURL = projectURL.appendingPathComponent(path)
            if fileManager.fileExists(atPath: targetURL.path) {
                let infoPlistPath = targetURL.appendingPathComponent("Info.plist").path
                let assetsPath = targetURL.appendingPathComponent("Assets.xcassets").path
                
                let mainSwiftPath = targetURL.appendingPathComponent("main.swift").path
                let appDelegatePath = targetURL.appendingPathComponent("AppDelegate.swift").path
                
                if fileManager.fileExists(atPath: assetsPath) &&
                   (fileManager.fileExists(atPath: mainSwiftPath) || fileManager.fileExists(atPath: appDelegatePath)) {
                    return DetectedProject(
                        platform: .macOS,
                        projectPath: targetURL.path,
                        assetsPath: assetsPath,
                        infoPlistPath: fileManager.fileExists(atPath: infoPlistPath) ? infoPlistPath : nil
                    )
                }
            }
        }
        
        return nil
    }
    
    private func detectWatchOSProject(at projectURL: URL, projectName: String) throws -> DetectedProject? {
        let possiblePaths = [
            projectName + " Watch App",
            projectName + " WatchKit App",
            "WatchApp",
            projectName + "-watchOS"
        ]
        
        for path in possiblePaths {
            let targetURL = projectURL.appendingPathComponent(path)
            if fileManager.fileExists(atPath: targetURL.path) {
                let infoPlistPath = targetURL.appendingPathComponent("Info.plist").path
                let assetsPath = targetURL.appendingPathComponent("Assets.xcassets").path
                
                if fileManager.fileExists(atPath: assetsPath) {
                    return DetectedProject(
                        platform: .watchOS,
                        projectPath: targetURL.path,
                        assetsPath: assetsPath,
                        infoPlistPath: fileManager.fileExists(atPath: infoPlistPath) ? infoPlistPath : nil
                    )
                }
            }
        }
        
        return nil
    }
    
    private func detectTvOSProject(at projectURL: URL, projectName: String) throws -> DetectedProject? {
        let possiblePaths = [
            projectName + "-tvOS",
            "tvOS",
            projectName + " tvOS"
        ]
        
        for path in possiblePaths {
            let targetURL = projectURL.appendingPathComponent(path)
            if fileManager.fileExists(atPath: targetURL.path) {
                let infoPlistPath = targetURL.appendingPathComponent("Info.plist").path
                let assetsPath = targetURL.appendingPathComponent("Assets.xcassets").path
                
                if fileManager.fileExists(atPath: assetsPath) {
                    return DetectedProject(
                        platform: .tvOS,
                        projectPath: targetURL.path,
                        assetsPath: assetsPath,
                        infoPlistPath: fileManager.fileExists(atPath: infoPlistPath) ? infoPlistPath : nil
                    )
                }
            }
        }
        
        return nil
    }
}

struct DetectedProject {
    let platform: Platform
    let projectPath: String
    let assetsPath: String
    let infoPlistPath: String?
}