Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:38339 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750983AbbCTNgR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2015 09:36:17 -0400
From: Antoine Tenart <antoine.tenart@free-electrons.com>
To: sebastian.hesselbarth@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>,
	zmxu@marvell.com, jszhang@marvell.com, yrliao@marvell.com,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] ARM: berlin: ADC support
Date: Fri, 20 Mar 2015 14:36:01 +0100
Message-Id: <1426858565-31053-1-git-send-email-antoine.tenart@free-electrons.com>
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

Antoine Tenart (4):
  iio: adc: add support for Berlin
  Documentation: bindings: document the Berlin ADC driver
  ARM: berlin: add an ADC node for the BG2Q
  ARM: berlin: enable the ADC on the BG2Q DMP

 .../devicetree/bindings/iio/adc/berlin2_adc.txt    |  19 +
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts         |   4 +
 arch/arm/boot/dts/berlin2q.dtsi                    |   8 +
 drivers/iio/adc/Kconfig                            |   7 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/berlin-adc.c                       | 397 +++++++++++++++++++++
 6 files changed, 436 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt
 create mode 100644 drivers/iio/adc/berlin-adc.c

-- 
2.3.3

