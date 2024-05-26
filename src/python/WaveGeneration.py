import matplotlib.pyplot as plt
import numpy as np

## IMPORTANT
# Run this script from the root foleder of the repo

# Constants
fs = 16000  # Sampling frequency
f = 50  # Frequency
SNR = 21  # Signal-to-noise ratio in dB

# Time vector
t = np.arange(1600) # around 100 ms (5 periods)

# Sinusoid generator
sin_gen = lambda amplitude, delay, harmonic: amplitude*np.sin(harmonic*2*np.pi*f*(t/fs)+delay)

# Random noise
noise = np.random.normal(0, 10**(-SNR/20), len(t))

# v(t) = 0.3 + 5sin(w0t+2.5) + 1.5sin(3w0t+1.3) + 0.75sin(5w0t+1) 
# + 0.375sin(7w0t+0.6) + 0.1875sin(9w0t+0.3) + rand(SNR21 dB)
vt = 0.3 + sin_gen(5, 2.5, 1) + sin_gen(1.5, 1.3, 3) + sin_gen(0.75, 1, 5) + sin_gen(0.375, 0.6, 7) + sin_gen(0.1875, 0.3, 9) + noise

def normalize_to_n_bits(signal, n):
    max_val = 2**n - 1

    normalized_signal = ((signal / np.max(signal)) * max_val).astype(np.uint16)

    return normalized_signal

# shift it up
vt_shifted = vt - np.min(vt)

vt_8_bit =normalize_to_n_bits(vt_shifted, 8)
vt_10_bit =normalize_to_n_bits(vt_shifted, 10)
vt_12_bit =normalize_to_n_bits(vt_shifted, 12)

plt.plot(t, vt_8_bit)
plt.xlabel('sample')
plt.ylabel('voltage(V)')

plt.plot(t, vt_10_bit)
plt.xlabel('sample')
plt.ylabel('voltage(V)')

plt.plot(t, vt_12_bit)
plt.xlabel('sample')
plt.ylabel('voltage(V)')

def write_to_mif(filename, data, width):
    depth = len(data)

    with open(filename, 'w') as f:
        f.write('DEPTH = {};\n'.format(depth))
        f.write('WIDTH = {};\n'.format(width))
        f.write('ADDRESS_RADIX = DEC;\n')
        f.write('DATA_RADIX = DEC;\n')
        f.write('CONTENT\n')
        f.write('BEGIN\n')

        for i in range(depth):
            f.write('{} : {};\n'.format(i, data[i]))

        f.write('END;\n')

write_to_mif("src/MIFs/8_bit_rom.mif", vt_8_bit, 12)
write_to_mif("src/MIFs/10_bit_rom.mif", vt_10_bit, 12)
write_to_mif("src/MIFs/12_bit_rom.mif", vt_12_bit, 12)

plt.show()