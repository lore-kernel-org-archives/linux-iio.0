Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:33411 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756379Ab3ICBIP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Sep 2013 21:08:15 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2 2/2] iio: adjd_s311: Use INT_TIME channel info
Date: Tue,  3 Sep 2013 03:08:06 +0200
Message-Id: <1378170486-27702-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1378170486-27702-1-git-send-email-pmeerw@pmeerw.net>
References: <1378170486-27702-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/light/adjd_s311.c |   72 ++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 51 deletions(-)

diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index 23cff79..8853251 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -114,43 +114,6 @@ static int adjd_s311_read_data(struct iio_dev *indio_dev, u8 reg, int *val)
 	return 0;
 }
 
-static ssize_t adjd_s311_read_int_time(struct iio_dev *indio_dev,
-	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
-{
-	struct adjd_s311_data *data = iio_priv(indio_dev);
-	s32 ret;
-
-	ret = i2c_smbus_read_word_data(data->client,
-		ADJD_S311_INT_REG(chan->address));
-	if (ret < 0)
-		return ret;
-
-	return sprintf(buf, "%d\n", ret & ADJD_S311_INT_MASK);
-}
-
-static ssize_t adjd_s311_write_int_time(struct iio_dev *indio_dev,
-	 uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
-	 size_t len)
-{
-	struct adjd_s311_data *data = iio_priv(indio_dev);
-	unsigned long int_time;
-	int ret;
-
-	ret = kstrtoul(buf, 10, &int_time);
-	if (ret)
-		return ret;
-
-	if (int_time > ADJD_S311_INT_MASK)
-		return -EINVAL;
-
-	ret = i2c_smbus_write_word_data(data->client,
-		ADJD_S311_INT_REG(chan->address), int_time);
-	if (ret < 0)
-		return ret;
-
-	return len;
-}
-
 static irqreturn_t adjd_s311_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -186,25 +149,16 @@ done:
 	return IRQ_HANDLED;
 }
 
-static const struct iio_chan_spec_ext_info adjd_s311_ext_info[] = {
-	{
-		.name = "integration_time",
-		.read = adjd_s311_read_int_time,
-		.write = adjd_s311_write_int_time,
-	},
-	{ }
-};
-
 #define ADJD_S311_CHANNEL(_color, _scan_idx) { \
 	.type = IIO_INTENSITY, \
 	.modified = 1, \
 	.address = (IDX_##_color), \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
-		BIT(IIO_CHAN_INFO_HARDWAREGAIN), \
+		BIT(IIO_CHAN_INFO_HARDWAREGAIN) | \
+		BIT(IIO_CHAN_INFO_INT_TIME), \
 	.channel2 = (IIO_MOD_LIGHT_##_color), \
 	.scan_index = (_scan_idx), \
 	.scan_type = IIO_ST('u', 10, 16, 0), \
-	.ext_info = adjd_s311_ext_info, \
 }
 
 static const struct iio_chan_spec adjd_s311_channels[] = {
@@ -236,6 +190,18 @@ static int adjd_s311_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		*val = ret & ADJD_S311_CAP_MASK;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_INT_TIME:
+		ret = i2c_smbus_read_word_data(data->client,
+			ADJD_S311_INT_REG(chan->address));
+		if (ret < 0)
+			return ret;
+		*val = 0;
+		/*
+		 * not documented, based on measurement:
+		 * 4095 LSBs correspond to roughly 4 ms
+		 */
+		*val2 = ret & ADJD_S311_INT_MASK;
+		return IIO_VAL_INT_PLUS_MICRO;
 	}
 	return -EINVAL;
 }
@@ -245,16 +211,20 @@ static int adjd_s311_write_raw(struct iio_dev *indio_dev,
 			       int val, int val2, long mask)
 {
 	struct adjd_s311_data *data = iio_priv(indio_dev);
-	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
 		if (val < 0 || val > ADJD_S311_CAP_MASK)
 			return -EINVAL;
 
-		ret = i2c_smbus_write_byte_data(data->client,
+		return i2c_smbus_write_byte_data(data->client,
 			ADJD_S311_CAP_REG(chan->address), val);
-		return ret;
+	case IIO_CHAN_INFO_INT_TIME:
+		if (val != 0 || val2 < 0 || val2 > ADJD_S311_INT_MASK)
+			return -EINVAL;
+
+		return i2c_smbus_write_word_data(data->client,
+			ADJD_S311_INT_REG(chan->address), val2);
 	}
 	return -EINVAL;
 }
-- 
1.7.9.5

