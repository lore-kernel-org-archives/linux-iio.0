Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout1.freenet.de ([195.4.92.91]:40532 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754634AbbDOT16 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 15 Apr 2015 15:27:58 -0400
From: Thomas Betker <thomas.betker@freenet.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
	Thomas Betker <thomas.betker@rohde-schwarz.com>
Subject: [PATCH 1/5] iio: adc: xilinx: Fix register addresses
Date: Wed, 15 Apr 2015 21:11:47 +0200
Message-Id: <1429125111-2926-2-git-send-email-thomas.betker@freenet.de>
In-Reply-To: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de>
References: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Thomas Betker <thomas.betker@rohde-schwarz.com>

Define the register addresses for MIN_VCCPINT, MIN_VCCPAUX, MIN_VCCO_DDR
correctly.

Signed-off-by: Thomas Betker <thomas.betker@rohde-schwarz.com>
---
 drivers/iio/adc/xilinx-xadc.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index c7487e8..54adc50 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -145,9 +145,9 @@ static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg,
 #define XADC_REG_MAX_VCCPINT	0x28
 #define XADC_REG_MAX_VCCPAUX	0x29
 #define XADC_REG_MAX_VCCO_DDR	0x2a
-#define XADC_REG_MIN_VCCPINT	0x2b
-#define XADC_REG_MIN_VCCPAUX	0x2c
-#define XADC_REG_MIN_VCCO_DDR	0x2d
+#define XADC_REG_MIN_VCCPINT	0x2c
+#define XADC_REG_MIN_VCCPAUX	0x2d
+#define XADC_REG_MIN_VCCO_DDR	0x2e
 
 #define XADC_REG_CONF0		0x40
 #define XADC_REG_CONF1		0x41
-- 
1.7.9.5

