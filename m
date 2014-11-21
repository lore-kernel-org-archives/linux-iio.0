Return-Path: <k.wrona@samsung.com>
From: Karol Wrona <k.wrona@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 linux-iio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Antonio Borneo <borneo.antonio@gmail.com>, Karol Wrona <k.wrona@samsung.com>
Subject: [PATCH v5 0/1] misc: st32fwu: Add stm32 upgrade protocol handling
Date: Fri, 21 Nov 2014 19:17:27 +0100
Message-id: <1416593848-19676-1-git-send-email-k.wrona@samsung.com>
List-ID: <linux-iio@vger.kernel.org>


Hello,

This patch is needed by the sensorhub driver which uses STM32F4xx and Jonathan
suggested to factor out these sources (mentioned in: 
[RFC/PATCH 2/6] misc: sensorhub: Add sensorhub).

I feel a bit ashamed because I know a bit STM32F4 controllers but I did not
realize that it is generic ST protocol. It helped us a lot because this
code really needed some refactoring.

So this patch contains SPI protocol used in the STM32 bootloader and is based
on AN4286. Generally it can be used to implement handling of other interfaces
like UART or I2C because the flow is quite similar and maybe adding proper
hw access callbacks will do all work.

It supports:
  - get info frame
  - get version
  - firmware write (write, read, write address, erase)

>From v4:
  After some Antonio Borneo comments:
    - ack is specific for Samsung (or ST bootcode v1.0)
    - fixed read method
    - spi sync function was renamed as it is SPI specific
    - removed ACK2 define
    - add iface fiels to stm32fwu_fw struct to maintain different protocol
    versions

TODO:
  - erase command with sector mode
  - command checking and disabling unimplemented ones
  - spi wait for ack compatible with ST bootcode v1.1

Karol Wrona (1):
  misc: st32fwu: Add stm32 upgrade protocol handling

 drivers/misc/Kconfig               |    1 +
 drivers/misc/Makefile              |    1 +
 drivers/misc/stm32fwu/Kconfig      |    6 +
 drivers/misc/stm32fwu/Makefile     |    1 +
 drivers/misc/stm32fwu/stm32_core.c |  408 ++++++++++++++++++++++++++++++++++++
 drivers/misc/stm32fwu/stm32_core.h |   81 +++++++
 drivers/misc/stm32fwu/stm32_spi.c  |  117 +++++++++++
 include/linux/stm32fwu.h           |   53 +++++
 8 files changed, 668 insertions(+)
 create mode 100644 drivers/misc/stm32fwu/Kconfig
 create mode 100644 drivers/misc/stm32fwu/Makefile
 create mode 100644 drivers/misc/stm32fwu/stm32_core.c
 create mode 100644 drivers/misc/stm32fwu/stm32_core.h
 create mode 100644 drivers/misc/stm32fwu/stm32_spi.c
 create mode 100644 include/linux/stm32fwu.h

-- 
1.7.9.5
