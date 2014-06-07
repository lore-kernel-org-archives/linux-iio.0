Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43402 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752935AbaFGPnB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 7 Jun 2014 11:43:01 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 03/12] iio:adc:ad7887: Use BIT() and GENMASK() macros
Date: Sat,  7 Jun 2014 17:42:43 +0200
Message-Id: <1402155772-1373-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402155772-1373-1-git-send-email-pmeerw@pmeerw.net>
References: <1402155772-1373-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/adc/ad7887.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 749a6ca..2fd012e 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/bitops.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -25,14 +26,14 @@
 
 #include <linux/platform_data/ad7887.h>
 
-#define AD7887_REF_DIS		(1 << 5) /* on-chip reference disable */
-#define AD7887_DUAL		(1 << 4) /* dual-channel mode */
-#define AD7887_CH_AIN1		(1 << 3) /* convert on channel 1, DUAL=1 */
-#define AD7887_CH_AIN0		(0 << 3) /* convert on channel 0, DUAL=0,1 */
-#define AD7887_PM_MODE1		(0)	 /* CS based shutdown */
-#define AD7887_PM_MODE2		(1)	 /* full on */
-#define AD7887_PM_MODE3		(2)	 /* auto shutdown after conversion */
-#define AD7887_PM_MODE4		(3)	 /* standby mode */
+#define AD7887_REF_DIS		BIT(5)	/* on-chip reference disable */
+#define AD7887_DUAL		BIT(4)	/* dual-channel mode */
+#define AD7887_CH_AIN1		BIT(3)	/* convert on channel 1, DUAL=1 */
+#define AD7887_CH_AIN0		0	/* convert on channel 0, DUAL=0,1 */
+#define AD7887_PM_MODE1		0	/* CS based shutdown */
+#define AD7887_PM_MODE2		1	/* full on */
+#define AD7887_PM_MODE3		2	/* auto shutdown after conversion */
+#define AD7887_PM_MODE4		3	/* standby mode */
 
 enum ad7887_channels {
 	AD7887_CH0,
@@ -40,8 +41,6 @@ enum ad7887_channels {
 	AD7887_CH1,
 };
 
-#define RES_MASK(bits)	((1 << (bits)) - 1)
-
 /**
  * struct ad7887_chip_info - chip specifc information
  * @int_vref_mv:	the internal reference voltage
@@ -167,7 +166,7 @@ static int ad7887_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 		*val = ret >> chan->scan_type.shift;
-		*val &= RES_MASK(chan->scan_type.realbits);
+		*val &= GENMASK(chan->scan_type.realbits - 1, 0);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		if (st->reg) {
-- 
1.9.1

