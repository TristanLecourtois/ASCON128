
# ASCON-128 Hardware Implementation
Simplified version of the ASCON128 encryption algorithm coded in SystemVerilog
## Project Overview

This project focuses on the hardware implementation of the ASCON-128 algorithm, a finalist in the NIST competition for lightweight cryptographic algorithms. The ASCON-128 algorithm is designed for authenticated encryption and is particularly suitable for resource-constrained environments like the Internet of Things (IoT).

## ASCON-128 Functionality

The ASCON-128 algorithm ensures both encryption and data authenticity through a series of steps:

1. **Initialization**: The algorithm initializes the state using a 64-bit initialization vector (IV), a 128-bit key (K), and a 128-bit nonce (N). This setup provides the initial state for subsequent operations.

2. **Processing Associated Data**: To guard against forgery, the algorithm processes any associated data. This step ensures that the associated data is bound to the ciphertext, preventing unauthorized modifications.

3. **Encryption**: The algorithm encrypts the plaintext in blocks of 64 bits. Each block undergoes multiple transformations:
    - **Substitution**: Non-linear transformations alter the data bits.
    - **Permutation**: Bit permutations rearrange the data bits.
    - **Addition**: Addition operations modify the data with key and nonce.
    - **XOR Operations**: XOR operations combine the data with previous state information.

4. **Finalization**: The algorithm generates a 128-bit tag that accompanies the ciphertext. This tag is used for verifying the authenticity and integrity of the encrypted data.

## Project Structure

- **/SRC/RTL**: Contains the compiled files.
- **/SRC/BENCH**: Contains the test files.
- **init_modelsim.txt**: Initializes ModelSim with necessary commands.
- **compil_ascon.txt**: Compiles all commands in one execution.

## How to Compile

To compile the code, use the `compil_ascon.txt` file. In the SSH terminal, enter the following commands:

```bash
source init_modelsim.txt
source compil_ascon.txt



