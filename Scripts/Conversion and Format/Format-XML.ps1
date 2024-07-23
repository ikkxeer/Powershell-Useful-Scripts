Add-Type -AssemblyName System.Windows.Forms
$openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$openFileDialog.Filter = "XML Files (*.xml)|*.xml|All Files (*.*)|*.*"
$dialogResult = $openFileDialog.ShowDialog()

if ($dialogResult -eq [System.Windows.Forms.DialogResult]::OK) {
    $selectedXmlFile = $openFileDialog.FileName
}

[xml]$xmlContent = Get-Content $selectedXmlFile
$settings = New-Object System.Xml.XmlWriterSettings
$settings.Indent = $true
$settings.IndentChars = "  "
$settings.NewLineOnAttributes = $false
$writer = [System.Xml.XmlWriter]::Create($selectedXmlFile, $settings)
$xmlContent.WriteTo($writer)
$writer.Close()

Write-Host "Document Formatted Correctly!" -ForegroundColor Green