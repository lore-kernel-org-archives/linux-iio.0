Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout3.freenet.de ([195.4.92.93]:55724 "EHLO mout3.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121AbbKKU3K (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 11 Nov 2015 15:29:10 -0500
From: Thomas Betker <thomas.betker@freenet.de>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
	Xander Huff <xander.huff@ni.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Thomas Betker <thomas.betker@rohde-schwarz.com>
Subject: [PATCH] iio: adc: xilinx: Fix VREFN scale
Date: Wed, 11 Nov 2015 21:24:38 +0100
Message-Id: <1447273478-2530-1-git-send-email-thomas.betker@freenet.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Thomas Betker <thomas.betker@rohde-schwarz.com>

The scaling factor for VREFN is 3.0/4096 (not 1.0/4096), just as for
VREFP. This is not immediately obvious from the specification (Xilinx
UG480), but has been confirmed by Xilinx support.

Suggested-by: Hartmut Knaack <knaack.h@gmx.de>
Signed-off-by: Thomas Betker <thomas.betker@rohde-schwarz.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 0370624..02e636a 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -841,6 +841,7 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
 			case XADC_REG_VCCINT:
 			case XADC_REG_VCCAUX:
 			case XADC_REG_VREFP:
+			case XADC_REG_VREFN:
 			case XADC_REG_VCCBRAM:
 			case XADC_REG_VCCPINT:
 			case XADC_REG_VCCPAUX:
-- 
2.6.3

