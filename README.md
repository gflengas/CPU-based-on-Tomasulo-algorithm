# CPU-based-on-Tomasulo-algorithm
Project developed for Advanced Computer Architecture course. We were tasked to create a implement a processor with dynamic pipeline based on the Tomasulo algorithm using VHDL. On the following section a fast description is presented. For more detailed describtion of the proces 
## Baseline interface
- **Reservation Station(RS):** It consists of registers, which store data when they are not busy when sending an order to them or via the CDB. An RS is considered busy when it contains a command and has not yet received the signal executed by
the corresponding Functional Unit. It is also considered Ready to be executed when it is busy and the values of Qj, Qk are zero.

- **Functional Unit(FU):** It consists of the unit that performs the requested mathematical/logical operation and registers used for synchronizing the systemic. An FU is considered busy when each register has a tag other than zero (NOP), an executed command with data to be written to next or the CDB. The Request is made as soon as a Tag different than zeros in the penultimate register of the functional unit.

- **Local Control for RS+FU:** A control unit receives appropriate fields from the issue unit Vj, Vk, Qj, Qk, Op and in turn puts them in an internal Reservation Station. The control will control both the registration in the RS and the execution of the operation.

![explanation image](https://github.com/gflengas/CPU-based-on-Tomasulo-algorithm/blob/master/pictures/1.png)

The above diagram is the implementation of a unit of logic operations. The blue lines represent the control signals from the control. The arithmetic unit is implemented similarly by adding one more Reservation Station and replacing the LFU with an AFU.

- **Register File:** It consists of 32, 32 bit registers for the data and 32 registers for tags. It has two reading inputs from where they are received and the data but also the tag of the data requested by the given ones addresses. The Register File writes the tags through the Issue unit and the same time, saves the CDB.V data when a tag is found inside it is equal to the input CDB.Q.

- **Common Data Bus:** The CDB accepts the Requests and decides who will write in its entries according to the round robin technique by sending to the corresponding module the suitable Grant.

- **Reorder Buffer:** Essentially the Reorder Buffer (ROB) is a (data structure) circular queue (FIFO - First In First Out). Each time a new command is issued to the system it first registers with the ROB. Then the system works exactly as it did before, with the only difference being that the dependencies between the orders no longer exist based on the Reservation Stations but between individual ROB registrations.Creating the Reorder Buffer required ReorderBufferMem. They check the CDB for the appropriate data, and when they are found, are registered as CDBVout and Ready becomes ‘1’. The Clear signal resets Ready, when executed(Commit), or when the ROB detects an exception. The field Newest is also remarkable. When a RoB port searches for data intended for a specific Addr, you should always find the latest. The latest variable is used for this. When it gets the value ‘1’, means that the data has just been issued in ROB. Instead, it becomes '0' when it detects the same Addr to its input with what is existed in its memory, but without its WE being enabled. This means that a newer command with this Addr enters the RoB. The Reorder Buffer consists of 16 ReorderBufferMem in a queue distribution. To accomplished this distribution, two counters were used, which define the pointers "Head" and "Tail". Head and Tail are the beginning and end of the queue. Both grow towards the same direction. Tail always indicates the position where the next command to be issued will be entered in system. When a new command is entered into the system it enters the position indicated by Tail, and it is increased by 1. Respectively when a command becomes Commited in the system it's exit position indicated by the Head, and this increases by 1. For the proper operation of the system there are 2 ROBRead which in case of request, are inside ROBs come out as outputs. Available1 and Available2 signals are used for this. The search is based on the Tag and Latest. Finally during the design of ROB it was taken into account the case where the ReorderBufferMem to be committed is an exception. In this case RoB empties its list without committing anything and assign signals ExceptionOut = '1', and Output (is the PC of the command for which an exception was made) which signal the existence of an exception.

In its entirety, the Reorder Buffer is as follows:

![explanation image2](https://github.com/gflengas/CPU-based-on-Tomasulo-algorithm/blob/master/pictures/2.png)

## Top module
![explanation image3](https://github.com/gflengas/CPU-based-on-Tomasulo-algorithm/blob/master/pictures/3.png)
