<a href='https://cafecito.app/nelux' rel='noopener' target='_blank'><img srcset='https://cdn.cafecito.app/imgs/buttons/button_6.png 1x, https://cdn.cafecito.app/imgs/buttons/button_6_2x.png 2x, https://cdn.cafecito.app/imgs/buttons/button_6_3.75x.png 3.75x' src='https://cdn.cafecito.app/imgs/buttons/button_6.png' alt='Invitame un café en cafecito.app' /></a>

# Findext
Script Description: URL File Finder

This Bash script is designed to automate the process of finding URLs with specific file extensions on a given website. The script utilizes the gau tool to discover URLs recursively and then filters them based on various file extensions. The identified URLs are saved in separate text files for each extension within a 'files' directory. The script also keeps track of the number of files found for each extension and prints this information at the end of each search. Empty files, resulting from the absence of matching URLs, are automatically deleted to maintain a clean output.

Usage:

  ./Findext.sh -u URL

  ./Findext.sh -l lista.txt

Dependencies: 

https://github.com/lc/gau.git

https://github.com/projectdiscovery/httpx.git




