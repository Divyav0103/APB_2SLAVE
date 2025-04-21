**#APB**

Introduction


The Advanced Peripheral Bus (APB) is part of the Advanced Microcontroller Bus Architecture (AMBA) protocol family. It defines a low-cost interface that is optimised for minimal power consumption and reduced interface complexity. The APB protocol is not pipelined, use it to connect to low-bandwidth peripherals that do not require the high performance of the AXI protocol.APB is a non pipelined structure.


Key Features

1. It supports addresses up to 32 bit wide.
2. APB4 support for write strobe signal to enable sparse data transfer on the write data
bus.
3. Single Master - Multiple Slaves.
4. Programmable Wait state insertion.
5. Slave supports fine grain control of response per address or per transfer.
6. Programmable character length(multiple of 8 bits).
7. Simple Interface.
8. Suitable for many Peripherals.
9. APB4 supports protected access.
10. Random PSLVERR insertion.
11. Flexibility to send completely configured data.
12. In APB every transfer takes at least two cycles(Setup Phase and Access Phase).

APB ARCHITECTURE




![apb_2slave drawio](https://github.com/user-attachments/assets/1578d1bc-fc7c-4167-b5e9-9f1db68a1748)



DUT







![dut drawio](https://github.com/user-attachments/assets/09887148-2bc6-42a6-815a-0c250197eec4)

