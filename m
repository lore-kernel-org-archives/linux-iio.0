Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn1on0146.outbound.protection.outlook.com ([157.56.110.146]:13568
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760087AbbKTP67 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 20 Nov 2015 10:58:59 -0500
From: Haibo Chen <haibo.chen@freescale.com>
To: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
	<pmeerw@pmeerw.net>, <shawnguo@kernel.org>,
	<kernel@pengutronix.de>, <robh+dt@kernel.org>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linux@arm.linux.org.uk>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 0/4] Add i.mx7d adc driver support
Date: Fri, 20 Nov 2015 23:48:11 +0800
Message-ID: <1448034495-1759-1-git-send-email-haibo.chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch add imx7d adc driver support.

Changes in v3:
-move down the irq request in probe()
-remove the property 'num-channels' in dts
-remove some unused head file
-add clear register operation in imx7d_adc_isr()

Changes in V2:
-prefix defines with IMX7D_ for all the register
-use BIT macro to define a single bit
-remove the dma_en from struct adc_feature which is not support currently
-use static const array to replace the switch case code


*** BLURB HERE ***

Haibo Chen (4):
  iio: adc: add IMX7D ADC driver support
  Documentation: add the binding file for Freescale imx7d ADC driver
  ARM: dts: imx7d.dtsi: add ADC support
  ARM: dts: imx7d-sdb: add ADC support

 .../devicetree/bindings/iio/adc/imx7d-adc.txt      |  25 +
 arch/arm/boot/dts/imx7d-sdb.dts                    |  10 +
 arch/arm/boot/dts/imx7d.dtsi                       |  18 +
 drivers/iio/adc/Kconfig                            |   9 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/imx7d_adc.c                        | 570 +++++++++++++++++++++
 6 files changed, 633 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
 create mode 100644 drivers/iio/adc/imx7d_adc.c

-- 
1.9.1

