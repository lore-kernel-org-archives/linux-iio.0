Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47893 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226AbaFLFAk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 12 Jun 2014 01:00:40 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2 05/12] iio:adc:ad7298: Use BIT() and GENMASK() macros
Date: Thu, 12 Jun 2014 07:00:22 +0200
Message-Id: <1402549229-4449-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402549229-4449-1-git-send-email-pmeerw@pmeerw.net>
References: <1402549229-4449-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad7298.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index 2a3b65c..4a8c0a2 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/bitops.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -25,23 +26,19 @@
 
 #include <linux/platform_data/ad7298.h>
 
-#define AD7298_WRITE	(1 << 15) /* write to the control register */
-#define AD7298_REPEAT	(1 << 14) /* repeated conversion enable */
-#define AD7298_CH(x)	(1 << (13 - (x))) /* channel select */
-#define AD7298_TSENSE	(1 << 5) /* temperature conversion enable */
-#define AD7298_EXTREF	(1 << 2) /* external reference enable */
-#define AD7298_TAVG	(1 << 1) /* temperature sensor averaging enable */
-#define AD7298_PDD	(1 << 0) /* partial power down enable */
+#define AD7298_WRITE	BIT(15) /* write to the control register */
+#define AD7298_REPEAT	BIT(14) /* repeated conversion enable */
+#define AD7298_CH(x)	BIT(13 - (x)) /* channel select */
+#define AD7298_TSENSE	BIT(5) /* temperature conversion enable */
+#define AD7298_EXTREF	BIT(2) /* external reference enable */
+#define AD7298_TAVG	BIT(1) /* temperature sensor averaging enable */
+#define AD7298_PDD	BIT(0) /* partial power down enable */
 
 #define AD7298_MAX_CHAN		8
-#define AD7298_BITS		12
-#define AD7298_STORAGE_BITS	16
 #define AD7298_INTREF_mV	2500
 
 #define AD7298_CH_TEMP		9
 
-#define RES_MASK(bits)	((1 << (bits)) - 1)
-
 struct ad7298_state {
 	struct spi_device		*spi;
 	struct regulator		*reg;
@@ -257,7 +254,7 @@ static int ad7298_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		if (chan->address != AD7298_CH_TEMP)
-			*val = ret & RES_MASK(AD7298_BITS);
+			*val = ret & GENMASK(chan->scan_type.realbits - 1, 0);
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-- 
1.9.1

