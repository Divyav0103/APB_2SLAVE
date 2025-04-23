# **APB**

## 1. Introduction


The Advanced Peripheral Bus (APB) is part of the Advanced Microcontroller Bus Architecture (AMBA) protocol family. It defines a low-cost interface that is optimised for minimal power consumption and reduced interface complexity. The APB protocol is not pipelined, use it to connect to low-bandwidth peripherals that do not require the high performance of the AXI protocol.APB is a non pipelined structure.


### 1.1 Key Features

1. It supports addresses up to 32 bit wide.
2. APB4 support for write strobe signal to enable sparse data transfer on the write data
bus.
3. Single Master - Multiple Slaves.
4. Programmable Wait state insertion.
5. Slave supports fine grain control of response per address or per transfer.
6. Simple Interface.
7. Suitable for many Peripherals.
8. In APB every transfer takes at least two cycles(Setup Phase and Access Phase).

## 2. APB ARCHITECTURE




![APB_2slave drawio](https://github.com/user-attachments/assets/b5c14962-306a-48b8-a867-853963dbdf8e)




## 2.1 DUT


![dut drawio](https://github.com/user-attachments/assets/09887148-2bc6-42a6-815a-0c250197eec4)

## 2.2 Block Diagram
![image](https://github.com/user-attachments/assets/3b673148-974e-419c-b52c-e1d77d97f5a7)



## Operation of APB
![Untitled Diagram drawio](https://github.com/user-attachments/assets/d0acc3ea-d422-4044-9025-be983ed24185)

Idle State:

* PSELx = 0, PENABLE = 0
* This is the default or inactive state. No transfer is initiated here
* The system will remain in the IDLE state if PREADY = 1 and no transfer is required
* Transition occurs to the SETUP state if a transfer request is initiated (trigger not explicitly shown but implied by the transition arrow)

Setup State:
* PSELx = 1, PENABLE = 0
* In this state, the peripheral select signal (PSELx) is asserted, indicating the target peripheral is selected for communication.
* The system is preparing for the actual data transfer
* Transition to the ACCESS state occurs when PREADY = 0, meaning the bus is not yet ready to complete the transfer

Access State:

* PSELx = 1, PENABLE = 1
* This state represents the active transfer phase, where both PSELx and PENABLE are asserted.
* The data transfer occurs during this state
* If PREADY = 1, indicating the bus is ready, and the transfer completes, the system transitions back to the IDLE state
* If PREADY = 0, the system stays in the ACCESS state, waiting for the bus to be ready

## Testcases

https://in.docworkspace.com/d/sIOTAxqWUAqPNl8AG



