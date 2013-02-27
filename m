Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59306 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759680Ab3B0Uk1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:27 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 67/67] iio:core drop info_mask from struct iio_info
Date: Wed, 27 Feb 2013 20:39:13 +0000
Message-Id: <1361997553-31058-68-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This has been replaced by the pair of masks info_mask_separate
and info_mask_shared_by_type.  Other variants may follow.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/industrialio-core.c | 17 ----------
 include/linux/iio/iio.h         | 73 +----------------------------------------
 2 files changed, 1 insertion(+), 89 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index bfb9ccb..feb29ff 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -691,23 +691,6 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 
 	if (chan->channel < 0)
 		return 0;
-	for_each_set_bit(i, &chan->info_mask, sizeof(long)*8) {
-		ret = __iio_add_chan_devattr(iio_chan_info_postfix[i/2],
-					     chan,
-					     &iio_read_channel_info,
-					     &iio_write_channel_info,
-					     i/2,
-					     !(i%2),
-					     &indio_dev->dev,
-					     &indio_dev->channel_attr_list);
-		if (ret == -EBUSY && (i%2 == 0)) {
-			ret = 0;
-			continue;
-		}
-		if (ret < 0)
-			goto error_ret;
-		attrcount++;
-	}
 	for_each_set_bit(i, &chan->info_mask_separate, sizeof(long)*8) {
 		ret = __iio_add_chan_devattr(iio_chan_info_postfix[i],
 					     chan,
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 7697650..8d171f4 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -38,76 +38,6 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_HYSTERESIS,
 };
 
-#define IIO_CHAN_INFO_SHARED_BIT(type) BIT(type*2)
-#define IIO_CHAN_INFO_SEPARATE_BIT(type) BIT(type*2 + 1)
-#define IIO_CHAN_INFO_BITS(type) (IIO_CHAN_INFO_SHARED_BIT(type) | \
-				    IIO_CHAN_INFO_SEPARATE_BIT(type))
-
-#define IIO_CHAN_INFO_RAW_SEPARATE_BIT			\
-	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_RAW)
-#define IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT			\
-	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_PROCESSED)
-#define IIO_CHAN_INFO_SCALE_SEPARATE_BIT		\
-	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_SCALE)
-#define IIO_CHAN_INFO_SCALE_SHARED_BIT			\
-	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_SCALE)
-#define IIO_CHAN_INFO_OFFSET_SEPARATE_BIT			\
-	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_OFFSET)
-#define IIO_CHAN_INFO_OFFSET_SHARED_BIT			\
-	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_OFFSET)
-#define IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT			\
-	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_CALIBSCALE)
-#define IIO_CHAN_INFO_CALIBSCALE_SHARED_BIT			\
-	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_CALIBSCALE)
-#define IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT			\
-	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_CALIBBIAS)
-#define IIO_CHAN_INFO_CALIBBIAS_SHARED_BIT			\
-	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_CALIBBIAS)
-#define IIO_CHAN_INFO_PEAK_SEPARATE_BIT			\
-	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_PEAK)
-#define IIO_CHAN_INFO_PEAK_SHARED_BIT			\
-	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_PEAK)
-#define IIO_CHAN_INFO_PEAKSCALE_SEPARATE_BIT			\
-	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_PEAKSCALE)
-#define IIO_CHAN_INFO_PEAKSCALE_SHARED_BIT			\
-	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_PEAKSCALE)
-#define IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE_BIT	\
-	IIO_CHAN_INFO_SEPARATE_BIT(				\
-		IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW)
-#define IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SHARED_BIT	\
-	IIO_CHAN_INFO_SHARED_BIT(				\
-		IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW)
-#define IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE_BIT			\
-	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_AVERAGE_RAW)
-#define IIO_CHAN_INFO_AVERAGE_RAW_SHARED_BIT			\
-	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_AVERAGE_RAW)
-#define IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT \
-	IIO_CHAN_INFO_SHARED_BIT(			       \
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY)
-#define IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SEPARATE_BIT \
-	IIO_CHAN_INFO_SEPARATE_BIT(			       \
-		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY)
-#define IIO_CHAN_INFO_SAMP_FREQ_SEPARATE_BIT		\
-	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_SAMP_FREQ)
-#define IIO_CHAN_INFO_SAMP_FREQ_SHARED_BIT			\
-	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_SAMP_FREQ)
-#define IIO_CHAN_INFO_FREQUENCY_SEPARATE_BIT			\
-	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_FREQUENCY)
-#define IIO_CHAN_INFO_FREQUENCY_SHARED_BIT			\
-	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_FREQUENCY)
-#define IIO_CHAN_INFO_PHASE_SEPARATE_BIT			\
-	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_PHASE)
-#define IIO_CHAN_INFO_PHASE_SHARED_BIT			\
-	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_PHASE)
-#define IIO_CHAN_INFO_HARDWAREGAIN_SEPARATE_BIT			\
-	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_HARDWAREGAIN)
-#define IIO_CHAN_INFO_HARDWAREGAIN_SHARED_BIT			\
-	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_HARDWAREGAIN)
-#define IIO_CHAN_INFO_HYSTERESIS_SEPARATE_BIT			\
-	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_HYSTERESIS)
-#define IIO_CHAN_INFO_HYSTERESIS_SHARED_BIT			\
-	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_HYSTERESIS)
-
 enum iio_endian {
 	IIO_CPU,
 	IIO_BE,
@@ -281,8 +211,7 @@ struct iio_chan_spec {
 static inline bool iio_channel_has_info(const struct iio_chan_spec *chan,
 	enum iio_chan_info_enum type)
 {
-	return (chan->info_mask & IIO_CHAN_INFO_BITS(type)) |
-	       (chan->info_mask_separate & type) |
+	return (chan->info_mask_separate & type) |
 	       (chan->info_mask_shared_by_type & type);
 }
 
-- 
1.8.1.1

