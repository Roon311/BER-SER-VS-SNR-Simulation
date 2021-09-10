# BER-SER-VS-SNR-Simulation
BER-SER-VS-SNR-Simulation (Using MATLAB)

Having a deep look at the stage where all the world is satisfied with the ease of communication, no need
to wait 15 days till the message arrives, no need to travel to see friends, all of that is accomplished by
improvement of the digital communication field.
Digital communication represented in sending digital signals in the form of electromagnetic waves was a huge
challenge for communication engineers; it was due to the noise added to the signal transmitted.
In this project, a simulation for the whole process of sending and receiving binary waves is simulated by
SIMULINK, another version is made by code in MATLAB; We present here a very detailed process, including
all challenges. The report will have mainly 3 parts; transmission, channel, and receiving.


Brief:
While transmitting any signal, the signal content would be affected and attenuated by the channel noise. So if, the transmitted 
signal was 1 1 0 1, the received signal may be 1 0 1 1. there are two bits are wrong; therefore, the Bit Error Rate(BER)
equal to (Number of incorrect received bits / Number of all bits) = 2 / 4  = 0.5 and this is in case of Number of levels (M) are 2.
If the number of levels are more than 2, we count Symbol Error Rate (SER). For example, if number of levels are 4 and the transmitted 
signal is 11 01 11, and the received signal is 10 01 11, SER = (Number of incorrect symbols / Number of total symbols) = 1 / 3 = 0.3.
Both BER and SER are determined with respect to Signal to Noise Ratio (SNR).
The transmitted and received signal would be like (with SNR of 5 and number of levels ( M = 64 ) ):

![Transmitted signal](https://user-images.githubusercontent.com/68303138/132756391-da180361-958c-45fd-abc9-b22163143ff6.jpg)

SER VS SNR

![image](https://user-images.githubusercontent.com/68303138/132756822-eb6fd5d2-bb37-4f0d-b8dc-04a2034a44e4.png)



For further information, Read the attached Report

