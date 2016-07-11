Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:63762 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757302AbcGKDKG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Jul 2016 23:10:06 -0400
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
Subject: [PATCH v3 0/2] AUXADC: Mediatek auxadc driver 
Date: Mon, 11 Jul 2016 11:09:54 +0800
Message-ID: <1468206596-13792-1-git-send-email-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series includes three patches:
1.Change the device tree binding documentation.
2.Add auxadc driver based on linux iio.
3.Add auxadc nodes in the mediatek MT2701 dtsi file.

changes in patch v3:
1).Add '#' before 'io-channel-cells' and change 'auxadc@' to 'adc@' in auxadc binding document.
2).Fix CONFIG_MEDIATEK_MT65XX_AUXADC sequence as alphabetical order.
3).Change the prefix 'MT65XX' to 'MT6577' to match auxadc driver name.
4).Remove the delays stored in 'mt6577_auxadc_device' and use the defined delay directly.
5).Use '-ETIMEDOUT' instead of '-EINVAL'.
6).Return value directly in 'mt6577_auxadc_read_raw'.
7).Add power off and unprepare clock if 'iio_device_register' failed.
8).Change 'Registers' to 'Register'.

changes in patch v2:
1).Change the file name mt65xx_auxadc.c to mt6577_auxadc.c.
2).Add 'depends on ARCH_MEDIATEK || COMPILE_TEST and HAS_IOMEM' for MEDIATEK_MT65XX_AUXADC config.
3).Add check case for return value of 'readl_poll_timeout'.
4).Remove returning 1 and 0 for SCALE and OFFSET. use channel type 'IIO_CHAN_INFO_PROCESSED' instead of 'IIO_CHAN_INFO_RAW'.
5).Remove 'IIO_CHAN_INFO_OFFSET' and 'IIO_CHAN_INFO_SCALE' in 'MT65XX_AUXADC_CHANNEL' channel type.
6).Add check case when auxadc power on failure. if auxadc power on failure, clk_disable_unprepare should be executed.
7).Put 'platform_set_drvdata' before 'iio_device_register'.
8).Fix coding style and spelling error.

Zhiyong Tao (2):
  dt-bindings: auxadc: Add binding document for Mediatek auxadc.
  iio: adc: mt2701: Add Mediatek auxadc driver for mt2701.

 .../devicetree/bindings/iio/adc/mt65xx_auxadc.txt  |    4 +-
 drivers/iio/adc/Kconfig                            |   26 +--
 drivers/iio/adc/Makefile                           |    2 +-
 drivers/iio/adc/mt6577_auxadc.c                    |  186 ++++++++++----------
 4 files changed, 106 insertions(+), 112 deletions(-)

