# Verilog Modules (with testbench)

A collection of Verilog hardware modules with comprehensive testbenches by Bingo.

## Table of Contents

- [Adders](#adders)
  - [Full Adder](#full-adder)
  - [Four-Bit Adders](#four-bit-adders)
- [8-bit Adder/Subtractor](#8-bit-addersubtractor)
  - [Unsigned Adder/Subtractor](#unsigned-addersubtractor)
  - [Signed Adder/Subtractor](#signed-addersubtractor)
- [Sequential Elements](#sequential-elements)
  - [D Latch](#d-latch)
  - [D Flip-Flops](#d-flip-flops)
  - [D Flip-Flop with Reset and Enable](#d-flip-flop-with-reset-and-enable)
  - [4-bit Shift Register](#4-bit-shift-register)
  - [Synchronous Counter](#synchronous-counter)
  - [Comparator](#comparator)
- [Bingo's Template](#bingos-template)

---

## Arithmetic Modules

This section covers modules designed for arithmetic operations, ranging from basic building blocks to more complex multi-bit systems.

### 1-bit Full Adder

Complete implementation of a 1-bit full adder with multiple design approaches.

**Location:** `Adders/full_adder/`
**Files:**
- `tb.v` - Testbench for full adder
- `Data Flow Level/full_adder.v` - Behavioral/dataflow implementation
- `Gate Level/full_adder.v` - Gate-level implementation

The full adder adds three input bits (A, B, Carry In) and produces a Sum and Carry Out.

---

### Four-Bit Adders

Multi-bit adder implementations demonstrating different design techniques.

**Location:** `Adders/four_bit_adders/`

#### Ripple Carry Adder
A simple cascaded 4-bit adder where carry bits ripple from one stage to the next.
**Files:**
- `ripple_carry_adder/four_bit_ripple_carry_adder.v` - Core module
- `tb.v` - Testbench for ripple carry adder
**Characteristics:**
- Simple design
- Lower cost but slower (carry propagation delay)

#### Carry Lookahead Adder
An optimized 4-bit adder that generates carry signals in parallel, reducing propagation delay.
**Files:**
- `carry_lookahead_adder/four_bit_carry_lookahead_adder.v` - Core module
- `tb.v` - Testbench for carry lookahead adder
**Characteristics:**
- More complex logic
- Faster operation (parallel carry generation)
- Better for high-performance designs

---

## 8-bit Adder/Subtractor

These modules are designed to perform both addition and subtraction on 8-bit inputs. The operation is controlled by a `mode` signal: when `mode` is `0`, the module performs addition (`A + B`); when `mode` is `1`, it performs subtraction (`A - B`). Subtraction is implemented efficiently using two's complement arithmetic (`A + ~B + 1`), where the `mode` signal simultaneously inverts the `B` input and serves as the initial carry-in.

### Unsigned Adder/Subtractor

These modules perform 8-bit unsigned addition and subtraction.
**Location:** `Adder_Subtractor/unsigned_without_overflow_detection/`
**Testbench (`tb.v`):** A powerful testbench that exhaustively checks all 131,072 possible input combinations to guarantee correctness. It is used to test both the `ripple_carry` and `carry_lookahead` implementations.

**Architectures:**
-   **Ripple Carry:** A simple, sequential adder. (`ripple_carry/adder_subtractor.v`)
-   **Carry Lookahead:** A faster, parallel adder using a hierarchical design. (`carry_lookahead/adder_subtractor.v`)

### Signed Adder/Subtractor

These modules perform 8-bit signed (two's complement) addition and subtraction with overflow detection.
**Location:** `Adder_Subtractor/signed_with_overflow_detection/`
**Testbench (`tb.v`):** A dedicated testbench focused on verifying signed arithmetic edge cases and overflow conditions. It is used to test both the `ripple_carry` and `carry_lookahead` implementations.

**Architectures:**
-   **Ripple Carry:** A sequential adder with signed overflow detection. (`ripple_carry/adder_subtractor.v`)
-   **Carry Lookahead:** A high-speed parallel adder with signed overflow detection. (`carry_lookahead/adder_subtractor.v`)

---

## Sequential Elements

This section contains various sequential logic elements, which are fundamental building blocks for memory and state machines in digital circuits.

### D Latch

Level-sensitive D latch implementation.
**Location:** `Sequential_Elements/d_latch/`
**Files:**
- `d_latch.v` - Core module
**Characteristics:**
- Transparent when `clk=1`
- Holds previous value when `clk=0`

---

### D Flip-Flops

Edge-triggered 1-bit D flip-flop implementations.
**Location:** `Sequential_Elements/d_flip_flop/`
**Files:**
- `Postitive Edge d flip-flop/d_flip_flop.v` - Positive-edge triggered DFF
- `Postitive Edge d flip-flop/d_flip_flop_tb.v` - Testbench for positive-edge DFF
- `Negative Edge d flip-flop/d_flip_flop.v` - Negative-edge triggered DFF
**Characteristics:**
- Captures `Din` on selected clock edge
- Simple single-bit storage element

---

### D Flip-Flop with Reset and Enable

8-bit D flip-flop with write-enable and reset control.
**Location:** `Sequential_Elements/d_flip_flop_with_reset_and_enable/`
**Files:**
- `d_flip_flop.v` - Core module
**Characteristics:**
- 8-bit data input/output
- Write-enable controlled update (`w_en`)
- Includes reset logic

---

### 4-bit Shift Register

A 4-bit serial-in, parallel-out (SIPO) shift register with an asynchronous reset. Data is shifted in on the rising edge of the clock.
**Location:** `Sequential_Elements/four_bit_shift_register/`
**Files:**
- `four_bit_shift_register.v` - Core module
**Characteristics:**
- Synchronous operation with active-high asynchronous reset
- Serial input (`Sin`), parallel output (`Pout`), and serial output (`Sout`)

---

### Synchronous Counter

Parameterized synchronous up-counter with enable and clear controls.
**Location:** `Sequential_Elements/syncronous_counter/`
**Files:**
- `syncronous_counter.v` - Core counter module
- `syncronous_counter_tb.v` - Testbench
**Characteristics:**
- Configurable width via `parameter WIDTH`
- Counts up when `en=1`
- Clears on `reset` or `clr`

---

### Comparator

Single-bit comparator that reports greater-than, equal, and less-than results.
**Location:** `Sequential_Elements/comparator/`
**Files:**
- `comparator.v` - Core module
**Characteristics:**
- 3-bit output encoding:
- `Out[0]` for `In1 > In2`
- `Out[1]` for `In1 == In2`
- `Out[2]` for `In1 < In2`

---

## Bingo's Template

A template project structure for Verilog module development.
**Location:** `Bingo's Template/`
**Files:**
- `bingo.v` - Template module
- `testbench.v` - Template testbench

Use this as a starting point for new Verilog projects.
