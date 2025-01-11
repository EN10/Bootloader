# Simple Bootloader Project

This is a basic x86 bootloader project that demonstrates the fundamentals of OS development. The bootloader prints "Hello, World!" to the screen using BIOS interrupts.

## Project Structure

- `bootloader.asm` - The main bootloader source code written in x86 assembly
- `bootloader.bin` - The compiled binary bootloader image
- `bochs_config.bxrc` - Configuration file for the Bochs emulator

## Prerequisites

To build and run this project, you'll need:
- FASM (Flat Assembler) for compiling the assembly code
- Bochs x86 emulator for running the bootloader

## Building

To compile the bootloader, run:
```bash
fasm bootloader.asm bootloader.bin
```

## Running

To run the bootloader in Bochs:
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

This project was inspired by:
- [Writing a Simple Operating System — from Scratch](https://www.youtube.com/watch?v=EzjnaMGxFko)

Technical references:
- [INT 10h - BIOS Video Services](https://stanislavs.org/helppc/int_10.html) - General documentation for BIOS video services
- [INT 10,E - Write Text in Teletype Mode](https://stanislavs.org/helppc/int_10-e.html) - Documentation for the BIOS interrupt used for text output


## License

This project is open source and available under the MIT License. 
