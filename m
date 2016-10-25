Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:49290 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756547AbcJYQ0j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2016 12:26:39 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <fabrice.gasnier@st.com>
Subject: [PATCH 00/10] Add support for STM32 ADC
Date: Tue, 25 Oct 2016 18:25:12 +0200
Message-ID: <1477412722-24061-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series adds support for STM32F4 ADC into IIO framework.
STM32F4 ADC is a 12-bit successive approximation analog-to-digital
converter. It has up to 19 multiplexed input channels. Conversions can
be performed in single, continuous, scan or discontinuous mode.
Conversions can be launched in software or using hardware triggers.

This driver has been developed and tested on STM32F429 eval board.
It consist of a core driver, to ease support for other STM32 family
ADCs, and a specific driver for STM32F4 ADC.
It allows to use direct or triggered buffer modes with triggers.
Optional support for DMA and few extended attributes is included.

Fabrice Gasnier (10):
  Documentation: dt-bindings: Document STM32 ADC DT bindings
  iio: adc: Add stm32 support
  iio: adc: stm32: add optional dma support
  iio: adc: stm32: add optional support for exti gpios
  iio: adc: stm32: add trigger polarity ext attr
  iio: adc: stm32: add ext attrs to configure sampling time
  ARM: configs: stm32: enable IIO ADC driver
  ARM: dts: stm32f429: Add adc support
  ARM: dts: stm32f429: enable adc on eval board
  ARM: dts: stm32f429: Add dma support to adc

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |   78 ++
 arch/arm/boot/dts/stm32429i-eval.dts               |   30 +
 arch/arm/boot/dts/stm32f429.dtsi                   |   68 +
 arch/arm/configs/stm32_defconfig                   |    2 +
 drivers/iio/adc/Kconfig                            |    2 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/stm32/Kconfig                      |   36 +
 drivers/iio/adc/stm32/Makefile                     |    4 +
 drivers/iio/adc/stm32/stm32-adc.c                  | 1334 ++++++++++++++++++++
 drivers/iio/adc/stm32/stm32-adc.h                  |  489 +++++++
 drivers/iio/adc/stm32/stm32f4-adc.c                |  652 ++++++++++
 11 files changed, 2696 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
 create mode 100644 drivers/iio/adc/stm32/Kconfig
 create mode 100644 drivers/iio/adc/stm32/Makefile
 create mode 100644 drivers/iio/adc/stm32/stm32-adc.c
 create mode 100644 drivers/iio/adc/stm32/stm32-adc.h
 create mode 100644 drivers/iio/adc/stm32/stm32f4-adc.c

-- 
1.9.1

