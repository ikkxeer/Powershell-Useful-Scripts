# Powershell-Useful-Scripts ⭐
Repository of small scripts that can be used for specific tasks such as Networking, automation, file conversion, server administration and more.

## Main objectives
The main goal of the project is to create a well-organized repository with tools that empower and help both system administrators and PowerShell developers. I also value continuous learning and knowledge sharing, so I would appreciate any feedback or ideas that would support the project.

## Available Scripts

### Server Administration
- **Add-SvManager.ps1**: Adds servers to Server Manager, formats the XML document before adding the server, and saves the changes.
- **Get-SvManager.ps1**: Retrieves and organizes the servers added to Server Manager, displaying information such as status and the date of the last update.

### Backup and Cleanup
- **BackupFiles.ps1**: Creates a backup of important installers from one location to another.
- **Clean-Temp.ps1**: Cleans temporary files from assigned folders.
- **Optimize-Register.ps1**: Cleans the Windows Registry for proper system and component operation.
- **Remove-Secure.ps1**: Deletes a file so that it is untraceable by file recovery software.

### File Conversion
- **Convert-Image-To-PDF.ps1**: Converts image files (.bmp, .jpg, .jpeg, .png, .gif, .tiff, .ico) to PDF files.
- **Convert-VHDX-To-Qcow2.ps1**: Converts .vhdx files to .qcow2 files.
- **Convert-Docx-To-PDF.ps1**: Exports .docx files to PDF files. 
  - **Requirements**: Word Application.
- **Convert-PDF-To-Docx.ps1**: Exports PDF files to .docx files.
  - **Requirements**: Word Application.
- **Convert-Docx-To-HTML.ps1**: Converts .docx files to HTML files.
  - **Requirements**: Word Application.
- **Convert-HTML-To-Docx.ps1**: Converts HTML files to .docx files.
  - **Requirements**: Word Application.
- **Convert-Video-To-MP4.ps1**: Converts video files to MP4 format.

### Security and Passwords
- **Decrypt-Password.ps1**: Decrypts a password stored in ".\Password.txt" and outputs the result in clear text.
- **Encrypt-Password.ps1**: Encrypts a password provided through input and saves it encrypted in a ".\Password.txt" file.

### System Information
- **Get-ActiveUsersReport.ps1**: Saves a report of active users into an "ActiveUsersReport.txt" file.
- **Get-HW.ps1**: Discovers and organizes information about the hardware of the specific computer.
- **Get-CPU-Temp.ps1**: Prints the CPU temperature in Celsius on the terminal.
- **Get-Disk-Temp.ps1**: Prints the disk temperatures in Celsius on the terminal.
- **Get-HighResourcesProcess.ps1**: Prints the top 10 processes with the highest CPU consumption in an orderly manner.
- **Get-VolumeInfo.ps1**: Lists and selects volumes to review their main characteristics in an organized and clear manner.
- **Verify-SystemFiles.ps1**: Checks and repairs system files using the `sfc /scannow` command.

### Network and Connectivity
- **Get-IPReport.ps1**: Generates a detailed report of the current device's IP information, including public IP, private IP, subnet mask, address family, and MAC address.
- **Monitor-Website.ps1**: Monitors a specific web URL with a customizable interval, providing details about the date and time.
- **Test-Latency.ps1**: Generates a report of the current device latency by setting six targets (Google, Cloudflare, OpenDNS, Verizon DNS, AWS, Microsoft Azure).

### Updates and Synchronization
- **Get-SoftwareUpdates.ps1**: Checks for and installs pending software updates on the system.
- **Sincronize-NTP.ps1**: Synchronizes the system's NTP server with the following parameters:
  - **Wait**: Time to wait before executing the NTP server synchronization (in seconds).
  - **Confirm**: Ask for confirmation before executing the command.
- **Update-MSEdge.ps1**: Forces Microsoft Edge to update to the latest available version.

### Compression and Formatting
- **UltraCompress-File.ps1**: Compresses the specified file to a .zip with the highest compression allowed in PowerShell.
- **Format-XML.ps1**: Formats an XML document to make it easier to view, with file selection functionality using the file explorer.
- **Extract-Files.ps1**: Extracts files from a specified archive (e.g., .zip, .rar) to a target directory.

## How to Use

1. Run PowerShell.
      > It is recommended to use the latest version of Powershell available.

2. Locate the path where the scripts you want to run are located.

   ```powershell
   Set-Location -Path "path\to\repository\folder"
   ```
   
3. Run the script you want to use.

   **Example:**
   ```powershell
   .\Test-Latency.ps1
    ```

## Common problems

- **AccessDenied**
  - Solution: Run Powershell as administrator
    ```powershell
    if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
    {  
      $arguments = "& '" +$myinvocation.mycommand.definition + "'"
      Start-Process powershell.exe -Verb runAs -ArgumentList $arguments
      Break
    }
    ```

- **Running scripts is disabled on this system**
  - Solution: Change Execution Policy
    ```powershell
    Set-ExecutionPolicy Unrestricted # Recommended for personal use
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
    Set-ExecutionPolicy Bypass
    ```

    For more information about:
    
    - [Set-ExecutionPolicy](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-7.4)

- **Module or Assembly not found**
  - Description: This error indicates that the script is trying to load a module or assembly that is not installed on your system.
  - **Solution**: Install the required module or assembly. For example, to install a missing PowerShell module:
    ```powershell
    Install-Module -Name ModuleName
    ```

    ```powershell
    Add-Type -AssemblyName "AssemblyName"
    ```

- **Syntax Errors**
  - Description: These errors occur due to incorrect syntax or commands in the script.
  - Solution: Review the script for syntax errors and ensure commands are correctly written and used.


## Contributing
Contributions to enhance the repository or address issues are welcome. Please open a GitHub issue or submit a pull request.

## Author

These scripts were created by ``Ikkxeer``

For any inquiries or issues, please contact @ikkxeer
