Perfect — here’s a **clean, professional version** of your FIFO README without emojis, while keeping it structured and polished:

---

# FIFO Model in Verilog

This repository contains a complete Verilog implementation of a **synthesizable FIFO (First-In-First-Out) Model**, supporting parameterized data width and depth, robust status flags, and a comprehensive testbench for verification.

---

## Table of Contents

* [Overview](#overview)
* [Block Diagram](#block-diagram)
* [I/O Port Descriptions](#io-port-descriptions)
* [Features](#features)
* [Modules](#modules)
* [Testbench Description](#testbench-description)
* [Simulation](#simulation)

---

## Overview

This project implements a **synchronous FIFO buffer** with configurable parameters:

* Parameterized **data width** (`FWIDTH`) and **depth** (`FDEPTH`)
* Separate **memory block** module for data storage
* Comprehensive **testbench** validating all edge cases
* Real-time **status flags** to monitor FIFO condition

---

## Block Diagram

![FIFO Block Diagram](https://raw.githubusercontent.com/Srikar109755/FIFO_Model/main/FIFO/images/FIFO_Block_Diagram.png)

---

## I/O Port Descriptions

**Note:** All signals ending in `N` are **active low**.

### Input Ports

| Port Name | Description               |
| --------- | ------------------------- |
| `Clk`     | Clock signal              |
| `RstN`    | Reset signal              |
| `Data_In` | 32-bit input data to FIFO |
| `FInN`    | Write-enable signal       |
| `FClrN`   | Clear FIFO                |
| `FOutN`   | Read-enable signal        |

### Output Ports

| Port Name  | Description                         |
| ---------- | ----------------------------------- |
| `F_Data`   | 32-bit output data from FIFO        |
| `F_FullN`  | FIFO is full                        |
| `F_EmptyN` | FIFO is empty                       |
| `F_LastN`  | Space left for one more data value  |
| `F_SLastN` | Space left for two more data values |
| `F_FirstN` | Only one data value remains in FIFO |

---

## Features

* **Parameterization:** Configurable FIFO width & depth using macros (`FWIDTH`, `FDEPTH`)

* **Synchronous Design:** Both write and read synchronized to the clock

* **Modular Architecture:** Dedicated memory block for clean design separation

* **Status Flags:**

  * `F_EmptyN` → FIFO is empty
  * `F_FullN` → FIFO is full
  * `F_FirstN` → Only one element left
  * `F_LastN` → One space left
  * `F_SLastN` → Two spaces left

* **Robust Testbench:** Tests all operational and boundary conditions

---

## Modules

### 1. `FIFO_Model.v`

* Controls FIFO logic (read/write pointers, counter)
* Generates status signals

### 2. `FIFO_MEM_BLK.v`

* Implements synchronous memory storage
* Controlled writes, asynchronous reads

### 3. `FIFO_Model_tb.v`

* Comprehensive testbench
* Stimuli generation and flag verification

---

## Testbench Description

The testbench verifies FIFO functionality through:

* Clock generation and reset sequencing
* Continuous writes until FIFO is full
* Validation of full and overflow conditions
* Continuous reads until FIFO is empty
* Validation of empty and underflow conditions
* Status flag checks:

  * `F_FirstN` → One element left
  * `F_SLastN` → Two spaces left
  * `F_LastN` → One space left

Verbose output is generated using `$display` for debugging.

---

## Simulation

This design can be simulated with:

* ModelSim
* Vivado XSIM
* Verilator
* Synopsys VCS

### Example (ModelSim):

```bash
# Compile all source files
vlog FIFO_MEM_BLK.v FIFO_Model.v FIFO_Model_tb.v

# Simulate
vsim FIFO_Model_tb
```

---
