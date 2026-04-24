# Basys3-Stopwatch-FPGA-Verilog

Programmable stopwatch/timer implemented in Verilog for the Basys3 FPGA featuring FSM-based control, datapath architecture, BCD counting logic, clock division, and multiplexed seven-segment display output.

## Features

- Count up / count down modes
- Preset timer mode
- Start / stop / reset controls
- Four-digit seven-segment display
- FSM + datapath architecture
- Real-time 10 ms timing resolution

## Modes

| Mode |        Function        |
|------|------------------------|
|  00  | Count Up from 00.00    |
|  01  | Count Down from 99.99  |
|  10  | Preset Count Up        |
|  11  | Preset Count Down      |

## Architecture

- Controller FSM (IDLE / LOAD / RUN)
- BCD datapath counters
- Clock divider
- One-pulse button logic
- Display multiplexing

## Files

- `timer.v`
- `clkdiv.v`
- `pulse.v`
- `hexto7segment.v`
- `constraints.xdc`

## Tools

- Verilog
- Vivado
- Basys3 FPGA

## Media

- https://youtu.be/XSBvUrG0hxc
