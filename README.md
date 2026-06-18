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

## Templates

### Bingo's Template

A template project structure for Verilog module development.

**Location:** `Bingo's Template/`

**Files:**
- `bingo.v` - Template module
- `testbench.v` - Template testbench

Use this as a starting point for new Verilog projects.