# Verilog Modules (with testbench)

A collection of Verilog hardware modules with comprehensive testbenches by Bingo.

## Table of Contents

- [Combinational Elements](#combinational-elements)
  - [2 to 1 Multiplexer](#2-to-1-multiplexer)
  - [4 to 1 Multiplexer](#4-to-1-multiplexer)
  - [8 to 1 Multiplexer](#8-to-1-multiplexer)
  - [Additional Dataflow Modules](#additional-dataflow-modules)
- [Arithmetic Modules](#arithmetic-modules)
  - [Adders](#adders)
    - [Full Adder](#full-adder)
    - [Four-Bit Adders](#four-bit-adders)
  - [8-bit Adder/Subtractor](#8-bit-addersubtractor)
    - [Unsigned Adder/Subtractor](#unsigned-addersubtractor)
    - [Signed Adder/Subtractor](#signed-addersubtractor)
  - [Comparator](#comparator)
  - [Additional Dataflow Arithmetic Modules](#additional-dataflow-arithmetic-modules)
- [Sequential Elements](#sequential-elements)
  - [D Latch](#d-latch)
  - [D Flip-Flops](#d-flip-flops)
  - [Scan Flip-Flop](#scan-flip-flop)
  - [D Flip-Flop with Reset and Enable](#d-flip-flop-with-reset-and-enable)
  - [4-bit Shift Register](#4-bit-shift-register)
  - [Universal Shift Register](#universal-shift-register)
  - [Synchronous Counter](#synchronous-counter)
  - [Tick Generator](#tick-generator)
- [Traffic Light Controller](#traffic-light-controller)
- [Voting](#voting)
- [Medium](#medium)
- [Bingo's Template](#bingos-template)

---

# Combinational Elements

## 2 to 1 Multiplexer
Combinational logic that selects one of two inputs (`a`, `b`) using selector `sel` and drives output `c`.
#### Location: `Combinational_Elements/mux_2to1/`
#### Files:
- `behavior level/mux_2to1.v` - Behavioral-style implementation
- `dataflow level/mux_2to1.v` - Dataflow implementation using `assign`
- `gate level/mux_2to1.v` - Gate-level implementation with primitive gates
- `tb.v` - Testbench covering all 8 input combinations
#### Characteristics:
- 1-bit data path with 1-bit selector
- Demonstrates three modeling styles for the same function

---

## 4 to 1 Multiplexer
Combinational logic that selects one bit from a 4-bit input bus (`Din[3:0]`) using `sel[1:0]`.
#### Location: `Combinational_Elements/mux_4to1/`
#### Files:
- `mux_4to1.v` - 4-to-1 mux module built from 2-to-1 mux stages
- `tb.v` - Testbench that verifies all select values with multiple input patterns
#### Characteristics:
- 4-to-1 single-bit output multiplexer
- Hierarchical design composed of three 2-to-1 mux blocks

---

## 8 to 1 Multiplexer

`Combinational_Elements/mux_8to1/mux_8to1.v` selects one of eight input bits with a 3-bit `sel`. Like the existing 4-to-1 mux, `sel=0` selects the highest numbered bit of `Din`.

---

## Additional Dataflow Modules

These modules use continuous `assign` statements and can be compiled independently:

| Module | Location | Behavior |
| --- | --- | --- |
| `demux_1to4` | `Combinational_Elements/demux_1to4/demux_1to4.v` | Routes `din` to one bit of `dout[3:0]` selected by `sel[1:0]` |
| `decoder_2to4` | `Combinational_Elements/decoder_2to4/decoder_2to4.v` | Active-high, enabled 2-to-4 one-hot decoder |
| `priority_encoder_4to2` | `Combinational_Elements/priority_encoder_4to2/priority_encoder_4to2.v` | Encodes the highest asserted input bit; `valid=0` when no bit is set |
| `even_parity_8bit` | `Combinational_Elements/even_parity_8bit/even_parity_8bit.v` | Generates an even parity bit and checks received data and parity |
| `leading_zero_count_5bit` | `Combinational_Elements/leading_zero_count_5bit/leading_zero_count_5bit.v` | Counts leading zeros from 0 to 5; also reports zero input |
| `population_count_5bit` | `Combinational_Elements/population_count_5bit/population_count_5bit.v` | Counts asserted bits from 0 to 5 |
| `one_hot_detector_5bit` | `Combinational_Elements/one_hot_detector_5bit/one_hot_detector_5bit.v` | Reports exactly one bit set or at most one bit set |
| `binary_to_gray_5bit` | `Combinational_Elements/gray_code_5bit/binary_to_gray_5bit.v` | Converts 5-bit binary to Gray code |
| `gray_to_binary_5bit` | `Combinational_Elements/gray_code_5bit/gray_to_binary_5bit.v` | Converts 5-bit Gray code to binary |

`leading_zero_count`, `population_count`, `one_hot_detector`, `binary_to_gray`, and `gray_to_binary` also have `_4bit` and `_8bit` modules in matching width-specific folders. Their existing `_5bit` versions remain available. Leading-zero and population counts use 3 output bits for 4- and 5-bit input and 4 output bits for 8-bit input.

The other combinational families have these 4/8 variants:

| Family | 4-bit form | 8-bit form |
| --- | --- | --- |
| Demultiplexer | `demux_1to4` (four output channels) | `demux_1to8` (eight output channels), both in `demux_1to4/` |
| Decoder | `decoder_2to4` (four outputs) | `decoder_3to8` (eight outputs), both in `decoder_2to4/` |
| Priority encoder | `priority_encoder_4to2` | `priority_encoder_8to3`, both in `priority_encoder_4to2/` |
| Even parity | `even_parity_4bit` | `even_parity_8bit`, both in `even_parity_8bit/` |

---

# Arithmetic Modules

This section covers modules designed for arithmetic operations, ranging from basic building blocks to more complex multi-bit systems.

## 1-bit Full Adder

Complete implementation of a 1-bit full adder with multiple design approaches.

#### Location: `Adders/full_adder/`
#### Files:
- `tb.v` - Testbench for full adder
- `Data Flow Level/full_adder.v` - Behavioral/dataflow implementation
- `Data Flow Level/full_adder_4bit.v` and `full_adder_8bit.v` - Dataflow word adders with carry-in
- `Gate Level/full_adder.v` - Gate-level implementation

The full adder adds three input bits (A, B, Carry In) and produces a Sum and Carry Out.

---

## Four-Bit Adders

Multi-bit adder implementations demonstrating different design techniques.

#### Location: `Adders/four_bit_adders/`

### Ripple Carry Adder
A simple cascaded 4-bit adder where carry bits ripple from one stage to the next.
#### Files:
- `ripple_carry_adder/four_bit_ripple_carry_adder.v` - Core module
- `ripple_carry_adder/ripple_carry_adder_8bit.v` - 8-bit dataflow ripple-carry variant
- `tb.v` - Testbench for ripple carry adder
**Characteristics:**
- Simple design
- Lower cost but slower (carry propagation delay)

### Carry Lookahead Adder
An optimized 4-bit adder that generates carry signals in parallel, reducing propagation delay.
#### Files:
- `carry_lookahead_adder/four_bit_carry_lookahead_adder.v` - Core module
- `carry_lookahead_adder/carry_lookahead_adder_8bit.v` - 8-bit dataflow lookahead variant
- `tb.v` - Testbench for carry lookahead adder
#### Characteristics:
- More complex logic
- Faster operation (parallel carry generation)
- Better for high-performance designs

---

## 8-bit Adder/Subtractor

These modules are designed to perform both addition and subtraction on 8-bit inputs. The operation is controlled by a `mode` signal: when `mode` is `0`, the module performs addition (`A + B`); when `mode` is `1`, it performs subtraction (`A - B`). Subtraction is implemented efficiently using two's complement arithmetic (`A + ~B + 1`), where the `mode` signal simultaneously inverts the `B` input and serves as the initial carry-in.

### Unsigned Adder/Subtractor

These modules perform 8-bit unsigned addition and subtraction.
#### Location: `Adder_Subtractor/unsigned_without_overflow_detection/`
**Testbench (`tb.v`):** A powerful testbench that exhaustively checks all 131,072 possible input combinations to guarantee correctness. It is used to test both the `ripple_carry` and `carry_lookahead` implementations.

#### Architectures:
-   **Ripple Carry:** A simple, sequential adder. (`ripple_carry/adder_subtractor.v`)
-   **Carry Lookahead:** A faster, parallel adder using a hierarchical design. (`carry_lookahead/adder_subtractor.v`)

### Signed Adder/Subtractor

These modules perform 8-bit signed (two's complement) addition and subtraction with overflow detection.
#### Location: `Adder_Subtractor/signed_with_overflow_detection/`
**Testbench (`tb.v`):** A dedicated testbench focused on verifying signed arithmetic edge cases and overflow conditions. It is used to test both the `ripple_carry` and `carry_lookahead` implementations.

#### Architectures:
-   **Ripple Carry:** A sequential adder with signed overflow detection. (`ripple_carry/adder_subtractor.v`)
-   **Carry Lookahead:** A high-speed parallel adder with signed overflow detection. (`carry_lookahead/adder_subtractor.v`)

---

### Comparator

Single-bit comparator that reports greater-than, equal, and less-than results.
#### Location: `Arithmetic_Modules/comparator/`
#### Files:
- `comparator.v` - Core module
- `comparator_4bit.v`, `comparator_5bit.v`, `comparator_8bit.v` - Unsigned word comparators with separate `greater`, `equal`, and `less` outputs
#### Characteristics:
- 3-bit output encoding:
- `Out[0]` for `In1 > In2`
- `Out[1]` for `In1 == In2`
- `Out[2]` for `In1 < In2`

---

## Additional Dataflow Arithmetic Modules

| Module | Location | Behavior |
| --- | --- | --- |
| `half_adder` | `Arithmetic_Modules/Adders/half_adder/half_adder.v` | 1-bit sum and carry |
| `incrementer_8bit` | `Arithmetic_Modules/incrementer_8bit/incrementer_8bit.v` | Adds one to an 8-bit input; exposes carry-out |
| `multiplier_8bit` | `Arithmetic_Modules/multiplier_8bit/multiplier_8bit.v` | Unsigned 8-by-8 multiplication with a 16-bit product |
| `comparator_8bit` | `Arithmetic_Modules/comparator/comparator_8bit.v` | Unsigned 8-bit greater/equal/less outputs |
| `comparator_5bit` | `Arithmetic_Modules/comparator/comparator_5bit.v` | Unsigned 5-bit greater/equal/less outputs |
| `saturating_adder_5bit` | `Arithmetic_Modules/Adders/saturating_adder_5bit/saturating_adder_5bit.v` | Unsigned addition clamped to 31 with saturation flag |
| `carry_save_adder_5bit` | `Arithmetic_Modules/Adders/carry_save_adder_5bit/carry_save_adder_5bit.v` | Compresses three operands into sum and shifted carry rows |

The `half_adder`, `incrementer`, and `multiplier` families have `_4bit` and `_8bit` modules alongside their original files. The 5-bit `saturating_adder` and `carry_save_adder` families also have `_4bit` and `_8bit` versions in matching width-specific folders. For a carry-save adder, add `sum_bits` and `carry_bits` to get the sum of all three inputs.

The shared self-checking testbench `tests/dataflow_modules_tb.v` covers the first eight dataflow modules added to this collection. The width variants are supplied without additional testbench files.

---

## Sequential Elements

This section contains various sequential logic elements, which are fundamental building blocks for memory and state machines in digital circuits.

### D Latch

Level-sensitive D latch implementation.
**Location:** `Sequential_Elements/d_latch/`
#### Files:
- `d_latch.v` - Core module
#### Characteristics:
- Transparent when `clk=1`
- Holds previous value when `clk=0`

---

### D Flip-Flops

Edge-triggered 1-bit D flip-flop implementations.
#### Location: `Sequential_Elements/d_flip_flop/`
#### Files:
- `Postitive Edge d flip-flop/d_flip_flop.v` - Positive-edge triggered DFF
- `Postitive Edge d flip-flop/d_flip_flop_tb.v` - Testbench for positive-edge DFF
- `Negative Edge d flip-flop/d_flip_flop.v` - Negative-edge triggered DFF
#### Characteristics:
- Captures `Din` on selected clock edge
- Simple single-bit storage element

---

### Scan Flip-Flop

A 1-bit positive-edge flip-flop with a mux that selects normal data or scan data.
#### Location: `Sequential_Elements/scan_flip_flop/`
#### Files:
- `scan_flip_flop.v` - Scan flip-flop and its `mux_2to1` and `d_flip_flop` modules
- `tb.v` - Testbench covering all eight input combinations and output hold between clock edges
#### Characteristics:
- Captures `Din` when `Scan_en=0` and `Scan_in` when `Scan_en=1`
- Updates `Dout` on the rising edge of `clk`; holds its value between edges
- All required design modules are in `scan_flip_flop.v`

---

### D Flip-Flop with Reset and Enable

8-bit D flip-flop with write-enable and reset control.
#### Location: `Sequential_Elements/d_flip_flop_with_reset_and_enable/`
#### Files:
- `d_flip_flop.v` - Core module
#### Characteristics:
- 8-bit data input/output
- Write-enable controlled update (`w_en`)
- Includes reset logic

---

### 4-bit Shift Register

A 4-bit serial-in, parallel-out (SIPO) shift register with an asynchronous reset. Data is shifted in on the rising edge of the clock.
#### Location: `Sequential_Elements/four_bit_shift_register/`
#### Files:
- `four_bit_shift_register.v` - Core module
#### Characteristics:
- Synchronous operation with active-high asynchronous reset
- Serial input (`Sin`), parallel output (`Pout`), and serial output (`Sout`)

---

### Universal Shift Register

A 4-bit universal shift register built from four 4-to-1 multiplexers and four enabled D flip-flops. Supports hold, bidirectional shifting, and parallel load on the rising edge of `clk`.

#### Location: `Sequential_Elements/uni_sft_reg/`

#### Files:

- `uni_sft_reg.v` - Top-level `universal_shift_register` and its `mux_4x1` and `flip_flop` modules
- `tb.v` - Self-checking testbench covering 8,192 transitions across all starting states, modes, serial inputs, parallel inputs, enable values, and reset values

#### Characteristics:

- 4-bit parallel input (`Din[3:0]`) and output (`Q[3:0]`)
- Active-high synchronous reset (`rst`) clears `Q` to zero and takes priority over enable
- Holds its value when `en=0` and `rst=0`
- Shared serial input (`Cin`) enters bit 3 during right shift or bit 0 during left shift
- Combinational serial output (`Cout`) exposes `Q[3]` when `Sel=10`, otherwise `Q[0]`; sample before the rising edge to capture the bit being shifted out
- Testbench checks `Q`, `Cout`, reset priority, and output hold between clock edges

#### Operation:

When `rst=0` and `en=1`, `Sel[1:0]` selects the next value of `Q`:

| `Sel` | Function | Next `Q` |
| --- | --- | --- |
| `00` | Hold | `Q` |
| `01` | Shift right | `{Cin, Q[3:1]}` |
| `10` | Shift left | `{Q[2:0], Cin}` |
| `11` | Parallel load | `Din` |

---

### Synchronous Counter

Parameterized synchronous up-counter with enable and clear controls.
#### Location: `Sequential_Elements/syncronous_counter/`
#### Files:
- `syncronous_counter.v` - Core counter module
- `syncronous_counter_tb.v` - Testbench
#### Characteristics:
- Configurable width via `parameter WIDTH`
- Counts up when `en=1`
- Clears on `reset` or `clr`

---

### Tick Generator

A module that generates a single-cycle tick pulse at a programmable frequency.
#### Location: `Sequential_Elements/tick_generator/`
#### Files:
- `tick_generator.v` - Core module
- `tb.v` - Testbench
#### Characteristics:
- Generates a tick when an internal counter reaches a `MAX_COUNT` value.
- The `MAX_COUNT` parameter determines the frequency of the tick.

---

## Traffic Light Controller

Finite-state-machine (FSM) traffic light controller for two roads with timed state transitions.
#### Location: `traffic light/`
#### Files:
- `traffic_light.v` - Top-level traffic light controller and internal 4-bit counter
#### State Sequence and Duration:
- `S0`: Road A Red, Road B Red (`1` cycle)
- `S1`: Road A Green, Road B Red (`7` cycles)
- `S2`: Road A Yellow, Road B Red (`2` cycles)
- `S3`: Road A Red, Road B Red (`1` cycle)
- `S4`: Road A Red, Road B Green (`7` cycles)
- `S5`: Road A Red, Road B Yellow (`2` cycles)
#### Characteristics:
- 6-state synchronous FSM
- Dedicated counter-based timing per state
- Safe default output maps to all-red

---

## Voting

#### Location: `voting/`
#### Files:
- `voting.v`  
- `tb.v`
#### Operation
- accepts five five-bit one-hot (i.e., only one bit will have the logic-1)
- one-hot inputs: `a0` `a1` `a2` `a3` `a4`
- produce two outputs : 
  -`out`: five-bit one-hot number that occurred most
  -`count`: 3-bit binary count indicating how many times that number appeared

---

## Medium

#### Location: `Medium/`
#### Files:
- `voting.v`  
- `tb.v`
#### Operation
- accepts five six-bit one-hot (i.e., only one bit will have the logic-1)
- one-hot inputs: `a0` `a1` `a2` `a3` `a4`
- produce one outputs : 
  -`out`: the input with the middle of the five values

---

## Bingo's Template

A template project structure for Verilog module development.
**Location:** `Bingo's Template/`
**Files:**
- `bingo.v` - Template module
- `testbench.v` - Template testbench

Use this as a starting point for new Verilog projects.
