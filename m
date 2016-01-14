Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:44837 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568AbcANPh6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Jan 2016 10:37:58 -0500
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: <jic23@kernel.org>, <nicolas.ferre@atmel.com>,
	<alexandre.belloni@free-electrons.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <plagnioj@jcrosoft.com>,
	<linux-arm-kernel@lists.infradead.org>, <pmeerw@pmeerw.net>,
	<robh@kernel.org>, Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v3 0/5] Introduce at91_adc8xx driver
Date: Thu, 14 Jan 2016 16:38:12 +0100
Message-ID: <1452785897-16270-1-git-send-email-ludovic.desroches@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

This is the very basic support for the adc introduced with the SAMA5D2 SoC
family.

The goal is to provide something to the user as soon as possible instead of
waiting for a full featured driver.

Only unsigned conversions on a software tigger are supported. Next steps are
signed conversions, differential channels, hardware triggers, dma support,
touchscreen support, and others.

Changes:
- v3:
  - Driver file renaming.
  - Syntax cleanup.
  - Sampling frequency accessed through read/write_raw.
  - Cleanup in the IRQ handler.
- v2:
  - Cleanup thanks to Peter Meerwald-Stadler comments (add prefix for macros,
    remove useless stuff, etc).
  - Move parameters relative to the SoC to the device tree (min/max sampling
    rate and startup time).
  - Use sysfs to configure the sampling frequency.
  - vddana supply is no more optionnal.
  - No change for irq since I am not sure it will simplify the code (interrupt
    is cleared when reading channel conversion result). Jonathan, tell me if
    I need to rework this part.


Ludovic Desroches (5):
  iio:adc:at91_adc8xx: introduce new atmel adc driver
  MAINTAINERS: add entry for Atmel ADC 8xx driver
  ARM: at91/dt: sama5d2: add adc device
  ARM: at91/dt: sama5d2 Xplained: enable the adc device
  ARM: at91/defconfig: add sama5d2 adc support in sama5_defconfig

 .../bindings/iio/adc/at91-sama5d2_adc.txt          |  28 ++
 MAINTAINERS                                        |   6 +
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  22 +
 arch/arm/boot/dts/sama5d2.dtsi                     |  18 +-
 arch/arm/configs/sama5_defconfig                   |   1 +
 drivers/iio/adc/Kconfig                            |  11 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/at91-sama5d2_adc.c                 | 509 +++++++++++++++++++++
 8 files changed, 590 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
 create mode 100644 drivers/iio/adc/at91-sama5d2_adc.c

-- 
2.5.0

