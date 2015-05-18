Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:46463 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752540AbbERJTX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2015 05:19:23 -0400
From: Antoine Tenart <antoine.tenart@free-electrons.com>
To: sebastian.hesselbarth@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>,
	zmxu@marvell.com, jszhang@marvell.com, yrliao@marvell.com,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] ARM: berlin: ADC support
Date: Mon, 18 May 2015 11:19:17 +0200
Message-Id: <1431940760-23896-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

The Berlin ADC provides 8 channels, with one connected to a temperature
sensor. The temperature sensor has its own registers and both the ADC
and the temperature sensor need to be configured when using it.

This series is based on the two Berlin controllers rework series:
- https://lkml.org/lkml/2015/3/6/511
- https://lkml.org/lkml/2015/3/6/535

Antoine

Changes sinve v4:
	- fixed MODULE_DEVICE_TABLE which was using an unknown
	  of_device_id table

Changes since v3:
        - removed irq members from the berlin2_adc_priv struct
        - stopped setting the data member to -1
        - converted the temperature returned to milli Celsius

Changes since v2:
        - took care of double free issues
        - always enable the ADC in the device tree as there is no gated
          clock
        - moved the interrupt enable code before the channel reading
          function
        - cosmetic changes

Changes since v1:
        - updated to use regmap_update_bits()
        - fixed mixed berlin/berlin2 and some prefixes
        - reworked channel definitions
        - moved to IIO_CHAN_INFO_PROCESSED for the tsen
        - fixed some typos
        - cosmetic changes

Antoine Tenart (3):
  iio: adc: add support for Berlin
  Documentation: bindings: document the Berlin ADC driver
  ARM: berlin: add an ADC node for the BG2Q

 .../devicetree/bindings/iio/adc/berlin2_adc.txt    |  19 ++
 arch/arm/boot/dts/berlin2q.dtsi                    |   7 +
 drivers/iio/adc/Kconfig                            |   7 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/berlin2-adc.c                      | 378 +++++++++++++++++++++
 5 files changed, 412 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt
 create mode 100644 drivers/iio/adc/berlin2-adc.c

-- 
2.4.0

