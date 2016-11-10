Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35275 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934564AbcKJQUd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Nov 2016 11:20:33 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lee.jones@linaro.org>,
        <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <fabrice.gasnier@st.com>
Subject: [PATCH v2 0/6] Add support for STM32 ADC
Date: Thu, 10 Nov 2016 17:18:52 +0100
Message-ID: <1478794738-28933-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series adds support for STM32F4 ADC into IIO framework.
STM32F4 ADC is a 12-bit successive approximation analog-to-digital
converter with multiplexed input channels. Conversions can
be performed in single, continuous, scan or discontinuous mode.
Conversions can be launched in software or using hardware triggers.

This driver has been developed and tested on STM32F429 eval board.
It consist of a MFD core driver, to manage common resources shared
between up to 3 ADC instances.

Changes in v2:
- Replace single driver model by MFD approach, to handle up to 3 ADCs
  as separate devices. Each ADC device then registers a unique IIO
  device.
- Make driver as simple as possible for the first instance, to ease
  review. For now, I dropped complexity by removing injected support,
  triggered buffer mode, dmas.
- Removed abstraction layer (indirection routines, ops) as only stm32f4
  is supported.

Fabrice Gasnier (6):
  Documentation: dt-bindings: Document STM32 ADC DT bindings
  mfd: stm32-adc: Add support for stm32 ADC
  iio: adc: Add support for STM32 ADC
  ARM: configs: stm32: enable ADC driver
  ARM: dts: stm32f429: Add adc support
  ARM: dts: stm32f429: enable adc on eval board

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |  85 ++++
 arch/arm/boot/dts/stm32429i-eval.dts               |  25 +
 arch/arm/boot/dts/stm32f429.dtsi                   |  49 ++
 arch/arm/configs/stm32_defconfig                   |   3 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/stm32-adc.c                        | 525 +++++++++++++++++++++
 drivers/mfd/Kconfig                                |  14 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/stm32-adc-core.c                       | 301 ++++++++++++
 include/linux/mfd/stm32-adc-core.h                 |  52 ++
 11 files changed, 1066 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
 create mode 100644 drivers/iio/adc/stm32-adc.c
 create mode 100644 drivers/mfd/stm32-adc-core.c
 create mode 100644 include/linux/mfd/stm32-adc-core.h

-- 
1.9.1

