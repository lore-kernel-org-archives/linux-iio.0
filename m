Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50309 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850Ab3KQOOK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Nov 2013 09:14:10 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 04/11] iio:accel:kxsd9 use new read_avail to replace accel_scan_available.
Date: Sun, 17 Nov 2013 15:14:55 +0000
Message-Id: <1384701302-26564-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1384701302-26564-1-git-send-email-jic23@kernel.org>
References: <1384701302-26564-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Note that there is a small abi change in here as we will gain an in_
prefix on the accel_scan_available.  We have tightened the abi in recent
times so that the in_ prefix is no the standard thing to do.

This change is probably in the if no one notices, it doesn't count as
breakage category.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/accel/kxsd9.c | 52 ++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index d72118d1189c..d99601f4219b 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -57,13 +57,28 @@ struct kxsd9_state {
 	u8 tx[KXSD9_STATE_TX_SIZE];
 };
 
-#define KXSD9_SCALE_2G "0.011978"
-#define KXSD9_SCALE_4G "0.023927"
-#define KXSD9_SCALE_6G "0.035934"
-#define KXSD9_SCALE_8G "0.047853"
-
-/* reverse order */
-static const int kxsd9_micro_scales[4] = { 47853, 35934, 23927, 11978 };
+static const int kxsd9_scales[] = { 0, 11978,
+				    0, 23927,
+				    0, 35934,
+				    0, 47853 };
+
+static int kxsd9_read_avail(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    const int **vals,
+			    int *type,
+			    int *length,
+			    long mask_el)
+{
+	switch (mask_el) {
+	case IIO_CHAN_INFO_SCALE:
+		*length = ARRAY_SIZE(kxsd9_scales);
+		*vals = kxsd9_scales;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
 
 static int kxsd9_write_scale(struct iio_dev *indio_dev, int micro)
 {
@@ -72,7 +87,7 @@ static int kxsd9_write_scale(struct iio_dev *indio_dev, int micro)
 	bool foundit = false;
 
 	for (i = 0; i < 4; i++)
-		if (micro == kxsd9_micro_scales[i]) {
+		if (micro == kxsd9_scales[ (3 - i) * 2 + 1]) {
 			foundit = true;
 			break;
 		}
@@ -117,17 +132,6 @@ static int kxsd9_read(struct iio_dev *indio_dev, u8 address)
 	return (((u16)(st->rx[0])) << 8) | (st->rx[1] & 0xF0);
 }
 
-static IIO_CONST_ATTR(accel_scale_available,
-		KXSD9_SCALE_2G " "
-		KXSD9_SCALE_4G " "
-		KXSD9_SCALE_6G " "
-		KXSD9_SCALE_8G);
-
-static struct attribute *kxsd9_attributes[] = {
-	&iio_const_attr_accel_scale_available.dev_attr.attr,
-	NULL,
-};
-
 static int kxsd9_write_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int val,
@@ -164,7 +168,7 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
 		ret = spi_w8r8(st->us, KXSD9_READ(KXSD9_REG_CTRL_C));
 		if (ret)
 			goto error_ret;
-		*val2 = kxsd9_micro_scales[ret & KXSD9_FS_MASK];
+		*val2 = kxsd9_scales[(3 - (ret & KXSD9_FS_MASK))* 2 + 1];
 		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
 	}
@@ -179,6 +183,8 @@ error_ret:
 		.channel2 = IIO_MOD_##axis,				\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+		.info_mask_shared_by_type_available =			\
+			BIT(IIO_CHAN_INFO_SCALE),			\
 		.address = KXSD9_REG_##axis,				\
 	}
 
@@ -192,10 +198,6 @@ static const struct iio_chan_spec kxsd9_channels[] = {
 	}
 };
 
-static const struct attribute_group kxsd9_attribute_group = {
-	.attrs = kxsd9_attributes,
-};
-
 static int kxsd9_power_up(struct kxsd9_state *st)
 {
 	int ret;
@@ -213,8 +215,8 @@ static int kxsd9_power_up(struct kxsd9_state *st)
 
 static const struct iio_info kxsd9_info = {
 	.read_raw = &kxsd9_read_raw,
+	.read_avail = &kxsd9_read_avail,
 	.write_raw = &kxsd9_write_raw,
-	.attrs = &kxsd9_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
-- 
1.8.4.2

