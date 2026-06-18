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
 These modules are designed to perform both addition and subtraction on 8-bit inputs. The operation is controlled by a `mode` signal: when `mode` is `0`, the module performs addition (`A + B`); when `mode` is `1`, it performs subtraction (`A - B`). Subtraction is implemented efficiently using two's complement arithmetic (`A + ~B + 1`), where the `mode` signal simultaneously inverts the `B` input and serves as the initial carry-in.

### Unsigned Adder/Subtractor

These modules perform 8-bit unsigned addition and subtraction.

**Location:** `Adder_Subtractor/unsigned_without_overflow_detection/`

**Testbench (`tb.v`):** A powerful testbench that exhaustively checks all 131,072 possible input combinations to guarantee correctness. It is used to test both the `ripple_carry` and `carry_lookahead` implementations.

#### Architectures
-   **Ripple Carry:** A simple, sequential adder. (`ripple_carry/adder_subtractor.v`)
-   **Carry Lookahead:** A faster, parallel adder using a hierarchical design. (`carry_lookahead/adder_subtractor.v`)

### Signed Adder/Subtractor

These modules perform 8-bit signed (two's complement) addition and subtraction with overflow detection.

**Location:** `Adder_Subtractor/signed_with_overflow_detection/`

**Testbench (`tb.v`):** A dedicated testbench focused on verifying signed arithmetic edge cases and overflow conditions. It is used to test both the `ripple_carry` and `carry_lookahead` implementations.

#### Architectures
-   **Ripple Carry:** A sequential adder with signed overflow detection. (`ripple_carry/adder_subtractor.v`)
-   **Carry Lookahead:** A high-speed parallel adder with signed overflow detection. (`carry_lookahead/adder_subtractor.v`)

---

## Bingo's Template

A template project structure for Verilog module development.

**Location:** `Bingo's Template/`

**Files:**
- `bingo.v` - Template module
- `testbench.v` - Template testbench

Use this as a starting point for new Verilog projects.