<a href='https://cafecito.app/nelux' rel='noopener' target='_blank'><img srcset='https://cdn.cafecito.app/imgs/buttons/button_6.png 1x, https://cdn.cafecito.app/imgs/buttons/button_6_2x.png 2x, https://cdn.cafecito.app/imgs/buttons/button_6_3.75x.png 3.75x' src='https://cdn.cafecito.app/imgs/buttons/button_6.png' alt='Invitame un café en cafecito.app' /></a>

# Findext
File Scanner Tool

This script is a Bash-based tool designed to search for various file extensions within URLs or a list of URLs. It utilizes gau and httpx to find and verify the accessibility of files.

Features

Scan a single URL or a list of URLs.

Extract and check files with various extensions (e.g., .php, .js, .json, .pdf, .docx, etc.).

Save found URLs in categorized output files.

Store all results in a master file (all_urls.txt).

Usage

Usage:

    ./findext.sh [-u <url> | -l <file>]

Options

    -u <url>: Scan a single URL.
    
    -l <file>: Provide a file containing a list of URLs.

Installation

Make sure you have the following dependencies installed:

gau (Get All URLs)

httpx (HTTP probing tool)

To install them, run:
    
    go install -v github.com/lc/gau/v2/cmd/gau@latest
    GO111MODULE=on go get -u -v github.com/projectdiscovery/httpx/cmd/httpx

Example Usage

Scan a single URL:

    ./findext.sh -u example.com

Scan multiple URLs from a file:

    ./findext.sh -l urls.txt

Output

All discovered files are saved in the files/ directory.

Files are categorized by extension (e.g., php_example.com.txt, json_example.com.txt).

A master list of all found URLs is stored in files/all_urls.txt.



