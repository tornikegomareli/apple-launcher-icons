import Foundation
import ArgumentParser

struct Generate: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Generate app icons for detected Apple platform projects",
        discussion: """
        This command will scan your project directory for Xcode projects and generate
        appropriately sized icons for each detected Apple platform.
        
        The tool automatically handles:
        • Empty icon sets (common in new projects) - overwrites without prompting
        • Existing icons - requires --force flag to overwrite
        • Multiple platforms in one project - generates icons for each
        • Proper naming and formatting for Xcode asset catalogs
        
        TIP: Run with --dry-run first to see what will be generated without making changes.
        """
    )
    
    @Argument(help: ArgumentHelp(
        "Path to the source PNG image file",
        discussion: "The image should be square and at least 512x512 pixels (1024x1024 recommended)."
    ))
    var imagePath: String
    
    @Option(name: .shortAndLong, help: ArgumentHelp(
        "Project directory path",
        discussion: "The directory containing your .xcodeproj or .xcworkspace file. Defaults to current directory."
    ))
    var projectPath: String = "."
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(
        "Force overwrite existing icons",
        discussion: "Use this when you want to replace icons that already exist. Not needed for empty icon sets."
    ))
    var force = false
    
    @Flag(name: .shortAndLong, help: ArgumentHelp(
        "Show verbose output",
        discussion: "Displays detailed information about each icon being generated and paths being used."
    ))
    var verbose = false
    
    @Flag(name: .long, help: ArgumentHelp(
        "Preview changes without applying them",
        discussion: "Shows what icons would be generated without actually creating any files. Useful for testing."
    ))
    var dryRun = false
    
    mutating func run() throws {
        let generator = IconGenerator(
            imagePath: imagePath,
            projectPath: projectPath,
            force: force,
            verbose: verbose,
            dryRun: dryRun
        )
        
        try generator.generate()
    }
}