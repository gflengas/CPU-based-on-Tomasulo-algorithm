# CPU-based-on-Tomasulo-algorithm
Project developed for Advanced Computer Architecture course. We were tasked to create a implement a processor with dynamic pipeline based on the Tomasulo algorithm using VHDL.
## Baseline interface
- **Reservation Station(RS):** It consists of registers, which store data when they are not busy when sending an order to them or via the CDB. An RS is considered busy when it contains a command and has not yet received the signal executed by
the corresponding Functional Unit. It is also considered Ready to be executed when it is busy and the values of Qj, Qk are zero.

- **Functional Unit(FU):* *It consists of the unit that performs the requested mathematical/logical operation and registers used for synchronizing the systemic. An FU is considered busy when each register has a tag other than zero (NOP), an executed command with data to be written to next or the CDB. The Request is made as soon as a Tag different than zeros in the penultimate register of the functional unit.

- **Local Control for RS+FU:** A control unit receives appropriate fields from the issue unit Vj, Vk, Qj, Qk, Op and in turn puts them in an internal Reservation Station. The control will control both the registration in the RS and the execution of the operation.

![explanation image](https://github.com/gflengas/Genetic-Algorithm-for-WHPP/blob/master/pictures/1.png)

The above diagram is the implementation of a unit of logic operations. The blue lines represent the control signals from the control. The arithmetic unit is implemented similarly by adding one more Reservation Station and replacing the LFU with an AFU.

- Register File

- Common Data Bus

- 
