
import serial
import time
import numpy as np
from matplotlib import pyplot as plt
f       = 10
fator   = 10000
n = np.arange(0,1/f,1/(fator*f))
data = np.cos(2*np.pi*f*n)*32+32
data = [int(data[i]) for i in range(len(data))]
samplerate = fator*f
tam  = len(data)
#n = np.arange(0,(1/samplerate)*len(data),1/samplerate)

plt.plot(n,data)

plt.show()
s=serial.Serial()
s.bytesize=8
s.baudrate=115200
s.port="COM5"
s.open()
s.writetimeout=0
a=[0]
print(min(data),max(data))

print(np.log2(max(data)))
ttam =len(data)
j = 0
t0 = time.time()
while(True):
        for i in range(len(data)):
                a[0] = data[i]
                s.write(bytearray(a))
                time.sleep(1/(samplerate))
                print(a[0],i)

print(min(data))

t1 = time.time()
print(t1-t0)