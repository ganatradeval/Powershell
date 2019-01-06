# Config
$Username = "UserName@domain"
$Password = "Password"
$LocalFile = "C:\Users\Dev\Desktop\TEst2.txt"
$RemoteFile = "ftp://MyDomain.com/TEst2.txt"

# Create FTP Rquest Object
$FTPRequest = [System.Net.FtpWebRequest]::Create("$RemoteFile")
$FTPRequest = [System.Net.FtpWebRequest]$FTPRequest
$FTPRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
$FTPRequest.Credentials = new-object System.Net.NetworkCredential($Username, $Password)
$FTPRequest.UseBinary = $true
$FTPRequest.UsePassive = $true

# Read the File for Upload
#If you use Next 2 lines then there may be upload limit as larger files it will have Memory Error. That's why it is commented.
#$FileContent = gc -en byte $LocalFile
#$FTPRequest.ContentLength = $FileContent.Length
$FileContent  = [System.IO.File]::ReadAllBytes($LocalFile)
$FTPRequest.ContentLength = $content.Length

# Get Stream Request by bytes
$Run = $FTPRequest.GetRequestStream()
$Run.Write($FileContent, 0, $FileContent.Length)

# Cleanup
$Run.Close()
$Run.Dispose()