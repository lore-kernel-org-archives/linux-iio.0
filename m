Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:26567 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbbLUJXz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Dec 2015 04:23:55 -0500
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: <jic23@kernel.org>, <nicolas.ferre@atmel.com>,
	<alexandre.belloni@free-electrons.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <plagnioj@jcrosoft.com>,
	<linux-arm-kernel@lists.infradead.org>,
	Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH 0/5] Introduce at91_adc8xx driver
Date: Mon, 21 Dec 2015 10:24:07 +0100
Message-ID: <1450689852-22763-1-git-send-email-ludovic.desroches@atmel.com>
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

Ludovic Desroches (5):
  iio:adc:at91_adc8xx: introduce new atmel adc driver
  MAINTAINERS: add entry for Atmel ADC 8xx driver
  ARM: at91/dt: sama5d2: add adc device
  ARM: at91/dt: sama5d2 Xplained: enable the adc device
  ARM: at91/defconfig: add sama5d2 adc support in sama5_defconfig

 .../devicetree/bindings/iio/adc/at91_adc8xx.txt    |  27 ++
 MAINTAINERS                                        |   6 +
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  22 ++
 arch/arm/boot/dts/sama5d2.dtsi                     |  11 +-
 arch/arm/configs/sama5_defconfig                   |   1 +
 drivers/iio/adc/Kconfig                            |  11 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/at91_adc8xx.c                      | 417 +++++++++++++++++++++
 8 files changed, 495 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/at91_adc8xx.txt
 create mode 100644 drivers/iio/adc/at91_adc8xx.c

-- 
2.5.0

