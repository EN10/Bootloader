# Simple x86 Assembly Bootloader Examples

This is a basic x86 bootloader project that demonstrates the fundamentals of OS development. The bootloader prints "Hello, World!" to the screen using BIOS interrupts.

## Project Structure

- `hello_world.asm` - A bootloader that prints "Hello, World!" to the screen
- `hello_world_func.asm` - Same as hello_world.asm but using a function call to print
- `single_char.asm` - A minimal bootloader that prints a single character
- `single_char_min.asm` - An even more minimal version of single_char.asm
- `bochs_config.bxrc` - Configuration file for the Bochs emulator

## Prerequisites

To build and run this project, you'll need:
- FASM (Flat Assembler) for compiling the assembly code
- Bochs x86 emulator for running the bootloader

### Installing FASM

1. Download FASM from the [official website](https://flatassembler.net/download.php)
2. For Windows:
   - Download "flat assembler for Windows" package
   - Extract the zip file
   - The package includes an integrated editor with syntax highlighting
   - Documentation is provided in PDF format

### Installing Bochs

1. Download the latest Bochs release (currently 2.8) from the [official Bochs releases page](https://github.com/bochs-emu/Bochs/releases)
2. For Windows:
   - Download the .exe installer
   - Either run the installer directly
   - Or extract the files using 7-Zip if you prefer a portable installation

## Building

To compile the bootloaders, run either:
```bash
fasm hello_world.asm hello_world.bin
```
or
```bash
fasm single_char.asm single_char.bin
```

## Running

To run a bootloader in Bochs, first update the bochs_config.bxrc file to point to the desired .bin file, then:
```bash
bochs -f bochs_config.bxrc
```

## Technical Details

The bootloader implements these key features:
- Loads at memory address 0x7C00 (a fixed address chosen by IBM in 1981)
- Runs in 16-bit real mode
- Uses BIOS interrupt 0x10 with function 0x0E for teletype output, which automatically advances the cursor after printing
- Uses `lodsb` instruction to efficiently load and process string bytes into AL register while auto-incrementing SI
- Stores string characters using `db` (Define Byte) directive with a null terminator (0)
- Uses null-terminated strings for text output processing
- Implements an infinite loop after printing to prevent executing past our code
- Fits within the required 512 bytes for boot sectors:
  - Main code and data in first 510 bytes
  - Automatically pads unused space with zeros
  - Includes standard boot signature (0x55, 0xAA) in final 2 bytes, required by BIOS to mark the sector as bootable

## References

### Learning Resources
- [Single Character Bootloader Tutorial](https://www.youtube.com/watch?v=KEUgzn_Owxs) - Tutorial for the single character bootloader implementation
- [Writing a Simple Operating System — from Scratch](https://www.youtube.com/watch?v=EzjnaMGxFko) - Tutorial that inspired our Hello World bootloader implementation
- [Concise Hello World Bootloader](https://www.youtube.com/watch?v=xFrMXzKCXIc) - A streamlined implementation of the Hello World bootloader
- [OS Tutorial - Boot Sector Printing](https://github.com/cfenollosa/os-tutorial/tree/master/02-bootsector-print) - Detailed guide on implementing boot sector text printing, directly relevant to our Hello World implementation
- [Writing a Simple Operating System from Scratch](https://web.archive.org/web/20241112015613/http://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf) - The original source material that inspired the OS Tutorial series by cfenollosa

### Assembly and FASM Documentation
- [FASM Documentation](https://flatassembler.net/docs.php) - Official FASM documentation and manual

### BIOS and Hardware References
- [INT 10h - BIOS Video Services](https://stanislavs.org/helppc/int_10.html) - General documentation for BIOS video services
- [INT 10,E - Write Text in Teletype Mode](https://stanislavs.org/helppc/int_10-e.html) - Documentation for the BIOS interrupt used for text output

### Tools and Software
- [Bochs Releases](https://github.com/bochs-emu/Bochs/releases) - Official Bochs emulator downloads

## License

This project is open source and available under the MIT License. 