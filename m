Return-Path: <Haibo.Chen@freescale.com>
From: Haibo Chen <haibo.chen@freescale.com>
To: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<shawnguo@kernel.org>, <kernel@pengutronix.de>, <linux@arm.linux.org.uk>,
	<jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>
CC: <haibo.chen@freescale.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>
Subject: [PATCH v2 0/4] Add i.mx7d adc driver support
Date: Mon, 9 Nov 2015 21:28:20 +0800
Message-ID: <1447075704-4605-1-git-send-email-haibo.chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This patch add imx7d adc driver support.

Changes in V2:
-prefix defines with IMX7D_ for all the register
-use BIT macro to define a single bit
-remove the dma_en from struct adc_feature which is not support currently
-use static const array to replace the switch case code

Haibo Chen (4):
  iio: adc: add IMX7D ADC driver support
  Documentation: add the binding file for Freescale imx7d ADC driver
  ARM: dts: imx7d.dtsi: add ADC support
  ARM: dts: imx7d-sdb: add ADC support

 .../devicetree/bindings/iio/adc/imx7d-adc.txt      |  26 +
 arch/arm/boot/dts/imx7d-sdb.dts                    |  10 +
 arch/arm/boot/dts/imx7d.dtsi                       |  20 +
 drivers/iio/adc/Kconfig                            |   9 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/imx7d_adc.c                        | 571 +++++++++++++++++++++
 6 files changed, 637 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
 create mode 100644 drivers/iio/adc/imx7d_adc.c

-- 
1.9.1
