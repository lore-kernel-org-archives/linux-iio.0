Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:33297 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbcCLMaa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Mar 2016 07:30:30 -0500
From: Joachim Eastwood <manabian@gmail.com>
To: jic23@kernel.org
Cc: Joachim Eastwood <manabian@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 0/4] Support for analog peripherals on LPC18xx familiy
Date: Sat, 12 Mar 2016 13:30:13 +0100
Message-Id: <1457785817-32328-1-git-send-email-manabian@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch set adds support for the analog (ADC and DAC) peripherals
found on NXP LPC18xx/43xx SoCs. The ADC is a SAR converter with 10-bit
resolution and 8 muxed inputs. The DAC is a simple single channel 10-
bit DAC.

Note that these drivers do not support all the features found on the
peripherals. DMA and interrupts are not supported in either drivers.
The ADC driver also lack 'burst-mode' and hardware triggers. So for
now the ADC is limited to single shot samples.

Both drivers tested on Embedded Artists' LPC4357 Developer's Kit.

Based on iio/testing branch.

This version address the comments from Jonathan Cameron and fix the
locking in both the adc and dac driver.

Changes since v2:
 - replace iio dev mlock with a local lock in adc driver
 - add locking to lpc18xx_dac_write_raw() in dac driver
 - rebase on iio/testing

Changes since v1:
 - Fix nits on adc/dac from Peter Meerwald-Stadler
 - Add locking around lpc18xx_adc_read_chan()

Joachim Eastwood (4):
  iio: adc: add NXP LPC18xx ADC driver
  dt: document NXP LPC1850 ADC driver bindings
  iio: dac: add NXP LPC18xx DAC driver
  dt: document NXP LPC1850 DAC driver bindings

 .../devicetree/bindings/iio/adc/lpc1850-adc.txt    |  21 ++
 .../devicetree/bindings/iio/dac/lpc1850-dac.txt    |  20 ++
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/lpc18xx_adc.c                      | 231 +++++++++++++++++++++
 drivers/iio/dac/Kconfig                            |  10 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/lpc18xx_dac.c                      | 210 +++++++++++++++++++
 8 files changed, 504 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/lpc1850-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/lpc1850-dac.txt
 create mode 100644 drivers/iio/adc/lpc18xx_adc.c
 create mode 100644 drivers/iio/dac/lpc18xx_dac.c

-- 
1.8.0

