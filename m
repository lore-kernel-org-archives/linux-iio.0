Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47797 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283AbaFLEy3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 12 Jun 2014 00:54:29 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v3 05/12] iio:adc:ad799x: Use BIT() and GENMASK()
Date: Thu, 12 Jun 2014 06:54:09 +0200
Message-Id: <1402548856-3564-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net>
References: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad799x.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 878400c..b3799a8 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -32,6 +32,7 @@
 #include <linux/types.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/bitops.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -41,7 +42,7 @@
 #include <linux/iio/triggered_buffer.h>
 
 #define AD799X_CHANNEL_SHIFT			4
-#define AD799X_STORAGEBITS			16
+
 /*
  * AD7991, AD7995 and AD7999 defines
  */
@@ -55,10 +56,10 @@
  * AD7992, AD7993, AD7994, AD7997 and AD7998 defines
  */
 
-#define AD7998_FLTR				0x08
-#define AD7998_ALERT_EN				0x04
-#define AD7998_BUSY_ALERT			0x02
-#define AD7998_BUSY_ALERT_POL			0x01
+#define AD7998_FLTR				BIT(3)
+#define AD7998_ALERT_EN				BIT(2)
+#define AD7998_BUSY_ALERT			BIT(1)
+#define AD7998_BUSY_ALERT_POL			BIT(0)
 
 #define AD7998_CONV_RES_REG			0x0
 #define AD7998_ALERT_STAT_REG			0x1
@@ -69,7 +70,7 @@
 #define AD7998_DATAHIGH_REG(x)			((x) * 3 + 0x5)
 #define AD7998_HYST_REG(x)			((x) * 3 + 0x6)
 
-#define AD7998_CYC_MASK				0x7
+#define AD7998_CYC_MASK				GENMASK(2, 0)
 #define AD7998_CYC_DIS				0x0
 #define AD7998_CYC_TCONF_32			0x1
 #define AD7998_CYC_TCONF_64			0x2
@@ -85,10 +86,8 @@
  * AD7997 and AD7997 defines
  */
 
-#define AD7997_8_READ_SINGLE			0x80
-#define AD7997_8_READ_SEQUENCE			0x70
-/* TODO: move this into a common header */
-#define RES_MASK(bits)	((1 << (bits)) - 1)
+#define AD7997_8_READ_SINGLE			BIT(7)
+#define AD7997_8_READ_SEQUENCE			(BIT(6) | BIT(5) | BIT(4))
 
 enum {
 	ad7991,
@@ -205,12 +204,12 @@ static int ad799x_scan_direct(struct ad799x_state *st, unsigned ch)
 	case ad7991:
 	case ad7995:
 	case ad7999:
-		cmd = st->config | ((1 << ch) << AD799X_CHANNEL_SHIFT);
+		cmd = st->config | (BIT(ch) << AD799X_CHANNEL_SHIFT);
 		break;
 	case ad7992:
 	case ad7993:
 	case ad7994:
-		cmd = (1 << ch) << AD799X_CHANNEL_SHIFT;
+		cmd = BIT(ch) << AD799X_CHANNEL_SHIFT;
 		break;
 	case ad7997:
 	case ad7998:
@@ -244,7 +243,7 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 		*val = (ret >> chan->scan_type.shift) &
-			RES_MASK(chan->scan_type.realbits);
+			GENMASK(chan->scan_type.realbits - 1, 0);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		ret = regulator_get_voltage(st->vref);
@@ -359,7 +358,7 @@ static int ad799x_write_event_value(struct iio_dev *indio_dev,
 	int ret;
 	struct ad799x_state *st = iio_priv(indio_dev);
 
-	if (val < 0 || val > RES_MASK(chan->scan_type.realbits))
+	if (val < 0 || val > GENMASK(chan->scan_type.realbits - 1, 0))
 		return -EINVAL;
 
 	mutex_lock(&indio_dev->mlock);
@@ -388,7 +387,7 @@ static int ad799x_read_event_value(struct iio_dev *indio_dev,
 	if (ret < 0)
 		return ret;
 	*val = (ret >> chan->scan_type.shift) &
-		RES_MASK(chan->scan_type.realbits);
+		GENMASK(chan->scan_type.realbits - 1 , 0);
 
 	return IIO_VAL_INT;
 }
@@ -408,7 +407,7 @@ static irqreturn_t ad799x_event_handler(int irq, void *private)
 		goto done;
 
 	for (i = 0; i < 8; i++) {
-		if (ret & (1 << i))
+		if (ret & BIT(i))
 			iio_push_event(indio_dev,
 				       i & 0x1 ?
 				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
-- 
1.9.1

