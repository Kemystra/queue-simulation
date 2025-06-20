# Queue Simulator

## Parts

- Input system (Jimin)
    - Allow user to choose number generator
    - Bonus:
        - Allow user to input seed

- Random Number Generator (Jax, Jolene, Hui Yee)
    - Follow common implementation
    - 3 different PRNGs

- Main program

- Table printing (MiMi)
    - Accept data from main program
    - Display beautifully


## PRNG

### About

Most PRNGs can be divided into these parts:
1. Format of the seed value and how to input it into the PRNG
2. A bunch of variables that stores the current state
3. The actual calculation that generates the random number
    - Most of them are simple calculations with some magic numbers.

Each time a PRNG generate a random number, the current state is changed.

### Requirements

- 64-bit period (if not available, 32-bit is okay)
- Accepts an integer as seed, an another integer as the size M of the result array
- Output an array of random numbers of size M in the interval [0, 100]

### Suggested PRNG
1. `LCG` (Linear Congruential Generator)
    - The algorithm already in the lecture notes, just need the constants

2. `PCG` (Permuted Congruential Generator)

3. `xorshiftr+` (XOR, shift, reduced)
    - Note that there is a lot of variation of this one, make sure to carefully read the name (there is no typo there)
