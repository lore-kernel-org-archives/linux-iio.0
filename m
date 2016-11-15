Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39513 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S941012AbcKOPdR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Nov 2016 10:33:17 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <fabrice.gasnier@st.com>
Subject: [PATCH v3 0/6] Add support for STM32 ADC
Date: Tue, 15 Nov 2016 16:30:55 +0100
Message-ID: <1479223861-21747-1-git-send-email-fabrice.gasnier@st.com>
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
It consist of a core driver, to manage common resources shared
between up to 3 ADC instances and an ADC driver to manage each adc
instance.

Changes in v3:
- Core driver moved to iio/adc.
- Build fix.
- Updates following Jonathan's and Lars's remarks.
- Binding: adc child clock is mandatory.

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
  iio: adc: Add support for STM32 ADC core
  iio: adc: Add support for STM32 ADC
  ARM: configs: stm32: enable ADC driver
  ARM: dts: stm32f429: Add adc support
  ARM: dts: stm32f429: enable adc on eval board

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |  83 ++++
 arch/arm/boot/dts/stm32429i-eval.dts               |  25 +
 arch/arm/boot/dts/stm32f429.dtsi                   |  49 ++
 arch/arm/configs/stm32_defconfig                   |   3 +
 drivers/iio/adc/Kconfig                            |  23 +
 drivers/iio/adc/Makefile                           |   2 +
 drivers/iio/adc/stm32-adc-core.c                   | 303 ++++++++++++
 drivers/iio/adc/stm32-adc-core.h                   |  52 +++
 drivers/iio/adc/stm32-adc.c                        | 518 +++++++++++++++++++++
 9 files changed, 1058 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
 create mode 100644 drivers/iio/adc/stm32-adc-core.c
 create mode 100644 drivers/iio/adc/stm32-adc-core.h
 create mode 100644 drivers/iio/adc/stm32-adc.c

-- 
1.9.1

