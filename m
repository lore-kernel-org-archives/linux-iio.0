Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43400 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940AbaFGPnB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 7 Jun 2014 11:43:01 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 02/12] iio:adc:ad5504: Use BIT() and GENMASK() macros
Date: Sat,  7 Jun 2014 17:42:42 +0200
Message-Id: <1402155772-1373-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402155772-1373-1-git-send-email-pmeerw@pmeerw.net>
References: <1402155772-1373-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/dac/ad5504.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 1e64493..c917dd2 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -15,17 +15,16 @@
 #include <linux/sysfs.h>
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
+#include <linux/bitops.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
 #include <linux/iio/dac/ad5504.h>
 
-#define AD5505_BITS			12
-#define AD5504_RES_MASK			((1 << (AD5505_BITS)) - 1)
-
-#define AD5504_CMD_READ			(1 << 15)
-#define AD5504_CMD_WRITE		(0 << 15)
+#define AD5504_RES_MASK			GENMASK(11, 0)
+#define AD5504_CMD_READ			BIT(15)
+#define AD5504_CMD_WRITE		0
 #define AD5504_ADDR(addr)		((addr) << 12)
 
 /* Registers */
@@ -42,7 +41,7 @@
 
 /**
  * struct ad5446_state - driver instance specific data
- * @us:			spi_device
+ * @spi:			spi_device
  * @reg:		supply regulator
  * @vref_mv:		actual reference voltage used
  * @pwr_down_mask	power down mask
-- 
1.9.1

