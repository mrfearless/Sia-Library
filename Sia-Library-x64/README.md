# ![](../assets/sialogo.png) Sia Library

Sia Library - a library written in assembler (for x86 and x64) for accessing Sia rpc api endpoints.

> Sia is a decentralized storage platform secured by blockchain technology.
>

Sia: https://sia.tech/get-started


# Installation & Usage

* Download the latest release for whichever assembler and architecture you require:
    - [Sia-Library-x86.zip](https://github.com/mrfearless/Sia-Library/blob/master/releases/Sia-Library-x86.zip?raw=true)
    - [Sia-Library-x64.zip](https://github.com/mrfearless/Sia-Library/blob/master/releases/Sia-Library-x64.zip?raw=true)
* Copy `Sia.inc` to your `masm32\include` folder for Sia Library x86, or `uasm\include` for Sia Library x64 (or wherever your include files are located)
* Copy `Sia.lib` to your `masm32\lib` folder for Sia Library x86, or `uasm\lib\x64` for Sia Library x64 (or wherever your libraries are located)
* Add the following to your project:
```assembly
include Sia.inc
includelib Sia.lib
```


# Functions

Basic documentation on the functions in this library are located on the wiki [here](https://github.com/mrfearless/libraries/wiki/Sia-Library-Functions)


# Resources

Included with the releases are additional RadASM autocomplete / intellisense type files. Each `*.api.txt` file contains instructions as to where to paste their contents. 

The Sia Library makes use of the following required libraries:

- [RPC Library](https://github.com/mrfearless/libraries/tree/master/RPC)
- [cJSON Library](https://github.com/mrfearless/libraries/tree/master/cJSON)

Other resources may be required to build the libraries:

- [RadASM IDE](http://www.softpedia.com/get/Programming/File-Editors/RadASM.shtml)
- [MASM32 SDK](http://www.masm32.com/download.htm)
- [UASM - x86/x64 assembler](http://www.terraspace.co.uk/uasm.html)
- [WinInc - include files for x64 assembler](http://www.terraspace.co.uk/WinInc209.zip)
- [UASM-with-RadASM](https://github.com/mrfearless/UASM-with-RadASM)

