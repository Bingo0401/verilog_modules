# Verilog Modules (with testbench)

A collection of Verilog hardware modules with comprehensive testbenches by Bingo.

## Table of Contents

- [Adders](#adders)
  - [Full Adder](#full-adder)
  - [Four-Bit Adders](#four-bit-adders)
    - [Ripple Carry Adder](#ripple-carry-adder)
    - [Carry Lookahead Adder](#carry-lookahead-adder)
- [Templates](#templates)
  - [Bingo's Template](#bingos-template)

---

## Adders

### Full Adder

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

This section covers the 8-bit adder/subtractor modules found in the `Adder_Subtractor/` directory.

### Unsigned Adder/Subtractor

Performs 8-bit unsigned addition and subtraction.

**Location:** `Adder_Subtractor/unsigned_without_overflow_detection/`

**Testbench (`tb.v`):** A powerful testbench that exhaustively checks all 131,072 possible input combinations to guarantee correctness. It is used to test both the `ripple_carry` and `carry_lookahead` implementations.

### Signed Adder/Subtractor

Performs 8-bit signed (two's complement) addition and subtraction with overflow detection.

**Location:** `Adder_Subtractor/signed_with_overflow_detection/`

**Testbench (`tb.v`):** A dedicated testbench focused on verifying signed arithmetic edge cases and overflow conditions. It is used to test both the `ripple_carry` and `carry_lookahead` implementations.

---

## Bingo's Template

A template project structure for Verilog module development.

**Location:** `Bingo's Template/`

**Files:**
- `bingo.v` - Template module
- `testbench.v` - Template testbench

Use this as a starting point for new Verilog projects.