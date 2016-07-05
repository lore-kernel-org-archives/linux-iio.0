Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:51140 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752566AbcGEDul (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2016 23:50:41 -0400
From: Zhiyong Tao <zhiyong.tao@mediatek.com>
To: <robh+dt@kernel.org>, <jic23@kernel.org>, <knaack.h@gmx.de>,
	<lars@metafoo.de>, <pmeerw@pmeerw.net>
CC: <srv_heupstream@mediatek.com>, <liguo.zhang@mediatek.com>,
	<yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
	<erin.lo@mediatek.com>, <dawei.chien@mediatek.com>,
	<matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 0/3] AUXADC: Mediatek auxadc driver 
Date: Tue, 5 Jul 2016 11:50:07 +0800
Message-ID: <1467690610-20550-1-git-send-email-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series includes three patches:
1.Change the device tree binding documentation.
2.Add auxadc driver based on linux iio.
3.Add auxadc nodes in the mediatek MT2701 dtsi file.

changes in patch 2:
1).Change the file name mt65xx_auxadc.c to mt6577_auxadc.c.
2).Add 'depends on ARCH_MEDIATEK || COMPILE_TEST and HAS_IOMEM' for MEDIATEK_MT65XX_AUXADC config.
3).Add check case for return value of 'readl_poll_timeout'.
4).Remove returning 1 and 0 for SCALE and OFFSET. use channel type 'IIO_CHAN_INFO_PROCESSED' instead of 'IIO_CHAN_INFO_RAW'.
5).Remove 'IIO_CHAN_INFO_OFFSET' and 'IIO_CHAN_INFO_SCALE' in 'MT65XX_AUXADC_CHANNEL' channel type.
6).Add check case when auxadc power on failure. if auxadc power on failure, clk_disable_unprepare should be executed.
7).Put 'platform_set_drvdata' before 'iio_device_register'.
8).Fix coding style and spelling error.

Zhiyong Tao (3):
  dt-bindings: auxadc: Add binding document for Mediatek auxadc.
  auxadc: Add Mediatek auxadc driver for mt2701.
  arm: dts: auxadc: Add auxadc node.

 .../devicetree/bindings/iio/adc/mt65xx_auxadc.txt  |   27 ++
 .../devicetree/bindings/soc/mediatek/auxadc.txt    |   21 --
 arch/arm/boot/dts/mt2701.dtsi                      |    9 +
 drivers/iio/adc/Kconfig                            |   13 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/mt6577_auxadc.c                    |  301 ++++++++++++++++++++
 6 files changed, 351 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mt65xx_auxadc.txt
 delete mode 100644 Documentation/devicetree/bindings/soc/mediatek/auxadc.txt
 create mode 100644 drivers/iio/adc/mt6577_auxadc.c

