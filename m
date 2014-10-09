Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:63307 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbaJISjm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Oct 2014 14:39:42 -0400
From: Karol Wrona <k.wrona@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Karol Wrona <k.wrona@samsung.com>
Subject: [PATCH 0/1] misc: st32boot: Add stm32 upgrade protocol handling
Date: Thu, 09 Oct 2014 20:35:42 +0200
Message-id: <1412879743-19928-1-git-send-email-k.wrona@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

This patch is needed by the sensorhub driver which uses STM32F4xx and Jonathan
suggested to factor out these sources (mentioned in: 
[RFC/PATCH 2/6] misc: sensorhub: Add sensorhub).

I feel a bit ashamed because I know a bit STM32F4 controllers but I do not
realized that it is generic ST protocol. It helped us a lot because this 
code really needed some refactoring.

So this patch contains SPI protocol used in the STM32 bootloader and is based
on AN4286. Generally it can be used to implement handling of other interfaces
like UART or I2C because the flow is quite similar and maybe adding proper
hw access callbacks will do all work.

It supports:
  - get info frame
  - get version
  - firmware write


Karol

Karol Wrona (1):
  misc: st32boot: Add stm32 upgrade protocol handling

 drivers/misc/Kconfig                |    1 +
 drivers/misc/Makefile               |    1 +
 drivers/misc/stm32boot/Kconfig      |    6 +
 drivers/misc/stm32boot/Makefile     |    3 +
 drivers/misc/stm32boot/stm32_core.c |  412 +++++++++++++++++++++++++++++++++++
 drivers/misc/stm32boot/stm32_core.h |   81 +++++++
 drivers/misc/stm32boot/stm32_spi.c  |  108 +++++++++
 include/linux/stm32fwu.h            |   47 ++++
 8 files changed, 659 insertions(+)
 create mode 100644 drivers/misc/stm32boot/Kconfig
 create mode 100644 drivers/misc/stm32boot/Makefile
 create mode 100644 drivers/misc/stm32boot/stm32_core.c
 create mode 100644 drivers/misc/stm32boot/stm32_core.h
 create mode 100644 drivers/misc/stm32boot/stm32_spi.c
 create mode 100644 include/linux/stm32fwu.h

-- 
1.7.9.5

