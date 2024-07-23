# Powershell-Useful-Scripts ⭐
Repository of small scripts that can be used for specific tasks such as obtaining hardware information among others.


## List and explanation 

- ### Add-SvManager.ps1
  Add servers to Server Manager, specifying the name.
  In addition to this, format the XML document before adding the server and save the changes for successful results.

- ### BackupFiles.ps1
  Creates a backup of important installers from one location to another, creating a backup copy.

- ### Convert-Image-To-PDF.ps1
  Converts .bmp, .jpg, .jpeg, .png, .gif, .tiff, .ico file to a .pdf file, file selection functionality with interaction box.

- ### Convert-VHDX-To-Qcow2.ps1
  Converts .vhdx file to a .qcow2 file, file selection functionality with interaction box.

- ### Convert-Docx-To-PDF.ps1
  Exports .docx file to a .pdf file, file selection functionality with interaction box.

  - **Requeriments**
    - Word Application
   
- ### Convert-PDF-To-Docx.ps1
  Exports .pdf file to a .docx file, file selection functionality with interaction box.

  - **Requeriments**
    - Word Application

- ### Decrypt-Password.ps1
  Decrypts password stored in ".\Password.txt" and outputs the password result in clear text.

- ### Defrag-Disk.ps1
  Defragment all disks installed on the computer.

- ### Encrypt-Password.ps1
  Encrypts password passed through an input and saves it encrypted in a ".\Password.txt" file.
  
- ### Format-XML.ps1
  Formats an XML document to make it easier to view.
  With file selection function using the file explorer.

- ### Get-ActiveUsersReport.ps1
  Save a report of active users into a "ActiveUsersReport.txt" file.

- ### Get-HW.ps1
  Useful command to discover the hardware that the specific computer is using.
  It distributes and organizes all the information so that it is visually clear.

- ### Get-CPU-Temp.ps1
  Print CPU temperature in Celsius on terminal.
  
- ### Get-SvManager.ps1
  Obtains and sorts the servers added to the Server Manager.
  So that they can be clearly displayed and information can be obtained from them such as the Status and the Date of the last update.

- ### Get-SoftwareUpdates.ps1
  This script checks for and installs pending software updates on the system.

- ### Get-VolumeInfo.ps1
  Allows you to list and select volumes to review the main characteristics in an organized and visually clear manner.

- ### Get-WeatherReport.ps1
  Get a weather report for the country/city you want through a web request.
  
- ### Get-IPReport.ps1
  Generates a detailed report of the current device's IP information including public IP, private IP, subnet mask, address family, and MAC address.
  Provides a clear, color-coded display of all relevant network information.
  
  - Information:
    - Public IP Address
    - Hostname Public IP
    - City of Public IP
    - Organization of Public IP
    - Postal Code of Public IP
    - Tiemzones of Public IP
    - Privates IP Addresses
    - Submasks of Private IPs
    - Addresses Family Private IPs
    - MAC Addresses
  
- ### Monitor-Website.ps1
  Monitor a specific web url with customizable interval seconds giving details about date and time.

  - Example:
 
    ![image](https://github.com/user-attachments/assets/b7ffaf31-ca1c-40bb-82b4-885e406951a4)

- ### Remove-Secure.ps1
  Deletes the selected file so that it is untraceable once cleaned by file recovery software.
  
- ### Set-ColorTheme.ps1
  Change the color of the Windows theme between light and dark with the option to decide between either of the two.

- ### Test-Latency.ps1
  Generates a report of the current device latency by setting six targets which are Google, Cloudflare, OpenDNS, Verizon DNS, AWS and Microsoft Azure.
  Provides latency, an indication of the state of latency, visual and error control.

  - Example:

  ![image](https://github.com/user-attachments/assets/ef2a0d74-51fd-45bd-b000-6c07fb7d10a7)

- ### Update-MSEdge.ps1
  Forces Microsoft Edge browser to update to the latest available version of the program.


## How to use
1. Run Powershell
   
![image](https://github.com/user-attachments/assets/6944f1c9-fd6f-4148-bcce-1ed0518726b3)

2. Locate the path where the scripts you want to run are located
   
![image](https://github.com/user-attachments/assets/e5df0556-6f06-4f29-9141-a36c237bd979)

3. Run the script you want to use

**Example:**
  ```powershell
.\Scripts\Test-Latency.ps1
````

## Contributing
Contributions to enhance the repository or address issues are welcome. Please open a GitHub issue or submit a pull request.

## Author

These scripts were created by ``Ikkxeer``

For any inquiries or issues, please contact @ikkxeer
