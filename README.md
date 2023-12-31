# NTLMSleuth
NTLMSleuth: NTLM Hash Analysis Tool using https://ntlm.pw

## Project Overview:

**NTLMSleuth** is a powerful and intuitive tool designed to enhance security and aid cybersecurity professionals in analyzing NTLM hashes. Leveraging the capabilities of both PowerShell and Bash, NTLMSleuth offers a cross-platform solution to verify NTLM hash integrity against the robust database of ntlm.pw. This tool is essential for IT security analysts, penetration testers, and anyone involved in network security.

## Features

- Dual Script Functionality: With both PowerShell and Bash scripts, NTLMSleuth ensures compatibility across various operating systems, including Windows and Unix/Linux.

- Hash Verification: Quickly and accurately check NTLM hashes to assess their security levels and potential vulnerabilities.

- File Input Support: Easy-to-use interface accepting -i parameter for input files, allowing batch processing of multiple hashes.

- Output Flexibility: Offers an optional -o parameter for users to specify output destinations, streamlining the documentation process.

- User-Friendly Design: Despite its powerful features, NTLMSleuth is user-friendly, catering to both novice and expert users with its straightforward syntax and clear instructions.

## Use Cases:

- Security Audits: Ideal for conducting thorough security audits in organizational networks.

- Education and Training: An excellent tool for educational purposes, aiding in teaching the fundamentals of hash algorithms and network security.

- Incident Response: Crucial for rapid analysis during security incidents/assessments involving NTLM hash compromises.

## Getting Started:

To get started with NTLMSleuth, clone the repository, make the files executable, and begin enhancing your network security analysis today!

### Help (-h)

**BASH**
```
Usage of NTLMSleuth Shell Script
----------------------------

This script reads each line from a specified input file and performs a web request for each line.

Parameters:
-i [InputFilePath]   Specifies the path of the input file.
-o [OutputFilePath]  Specifies the path of the output file to save the results (optional).
-h                   Displays this help message.

Example:
./NTLMSleuth.sh -i /path/to/input.txt -o /path/to/output.txt
This example reads lines from 'input.txt' and saves the results to 'output.txt'.
```

**PowerShell**
```
Usage of NTLMSleuth PowerShell Script
---------------------------
This script reads each line from a specified input file and performs a web request for each line.

Parameters:
-i or -InputFilePath   Specifies the path of the input file.
-o or -OutputFilePath  Specifies the path of the output file to save the results (optional).
-h or -Help            Displays this help message.

Example:
.\NTLMSleuth.ps1 -i 'C:\path\to\input.txt' -o 'C:\path\to\output.txt'
This example reads lines from 'input.txt' and saves the results to 'output.txt'.
```