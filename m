Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2on0124.outbound.protection.outlook.com ([207.46.100.124]:29920
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755549AbbLHKWc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 8 Dec 2015 05:22:32 -0500
From: Haibo Chen <haibo.chen@freescale.com>
To: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
	<pmeerw@pmeerw.net>, <shawnguo@kernel.org>, <kernel@pengutronix.de>
CC: <haibo.chen@freescale.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/4] Add i.mx7d adc driver support
Date: Tue, 8 Dec 2015 18:26:19 +0800
Message-ID: <1449570383-25716-1-git-send-email-haibo.chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch set add imx7d adc driver support.

Changes in v5:
-call imx7d_adc_power_down() in driver probe when iio_device_register() failed
-handle with adc channel conversion timeout in imx7d_adc_isr()

Changes in v4:
-sort the include head file alphabetically
-really just clear the bit 31 of register REG_ADC_CH_A\B\C\D_CFG1 
 in function imx7d_adc_sample_rate_set()
-add document in imx7d_adc_isr() to clarify the clear operation
-add function imx7d_adc_power_down()
-adjust the format of the code and add some small changes

Changes in v3:
-move down the irq request in probe()
-remove the property 'num-channels' in dts
-remove some unused head file
-add clear register operation in imx7d_adc_isr()

Changes in v2:
-prefix defines with IMX7D_ for all the register
-use BIT macro to define a single bit
-remove the dma_en from struct adc_feature which is not support currently
-use static const array to replace the switch case code

Haibo Chen (4):
  iio: adc: add IMX7D ADC driver support
  Documentation: add the binding file for Freescale imx7d ADC driver
  ARM: dts: imx7d.dtsi: add ADC support
  ARM: dts: imx7d-sdb: add ADC support

 .../devicetree/bindings/iio/adc/imx7d-adc.txt      |  22 +
 arch/arm/boot/dts/imx7d-sdb.dts                    |  10 +
 arch/arm/boot/dts/imx7d.dtsi                       |  18 +
 drivers/iio/adc/Kconfig                            |   9 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/imx7d_adc.c                        | 589 +++++++++++++++++++++
 6 files changed, 649 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
 create mode 100644 drivers/iio/adc/imx7d_adc.c

-- 
1.9.1

