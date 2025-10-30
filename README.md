# Synchronous-FIFO-Verilog-Project

Here’s a clean, professional, and beginner-friendly **README.md** file for your **Synchronous FIFO Verilog Project** 👇

---

##  Synchronous FIFO (First-In First-Out) – Verilog Project

###  **Project Overview**

This project implements a **parameterized Synchronous FIFO (First-In First-Out)** memory buffer using **Verilog HDL**.
The FIFO allows temporary storage of data between modules operating on the **same clock domain**.
It includes **read/write control logic**, **status flags (FULL, EMPTY)**, and **parameterized data width and depth** for flexible usage in digital systems.

### **Module Description**

#### `sync_fifo.v`

Implements the FIFO logic.

| Signal     | Direction | Width      | Description         |
| :--------- | :-------- | :--------- | :------------------ |
| `CLK`      | Input     | 1          | System clock        |
| `RST`      | Input     | 1          | Asynchronous reset  |
| `W_EN`     | Input     | 1          | Write enable signal |
| `R_EN`     | Input     | 1          | Read enable signal  |
| `DATA_IN`  | Input     | DATA_WIDTH | Data to be written  |
| `DATA_OUT` | Output    | DATA_WIDTH | Data read from FIFO |
| `FULL`     | Output    | 1          | FIFO full flag      |
| `EMPTY`    | Output    | 1          | FIFO empty flag     |

**Parameters:**

| Parameter    | Default | Description                      |
| :----------- | :------ | :------------------------------- |
| `DATA_WIDTH` | 4       | Number of bits in each data word |
| `FIFO_DEPTH` | 8       | Total number of entries          |
| `ADDR_WIDTH` | 3       | Address width = log₂(FIFO_DEPTH) |

---

###  **Testbench Description**

#### `sync_fifo_tb.v`

This file tests all major FIFO operations:

1. Reset operation
2. Write until FULL
3. Read until EMPTY
4. Verify status flag transitions
5. Generates timing waveform (`sync_fifo_tb.vcd`)



### **How to Run the Simulation**
####  Using **Vivado **

1. Create a new simulation project.
2. Add both files: `sync_fifo.v` and `sync_fifo_tb.v`.
3. Set `sync_fifo_tb` as the top module.
4. Run behavioral simulation and view waveforms.



### **Applications**

* Data buffering between modules operating at the same clock rate
* Pipelined data paths
* UART, SPI, or memory controller designs
* Digital signal processing systems

