Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-085.synserver.de ([212.40.185.85]:1064 "EHLO
	smtp-out-085.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbaIYO1P (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 25 Sep 2014 10:27:15 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 3/4] staging:iio:ad5933: Report temperature as raw value
Date: Thu, 25 Sep 2014 16:27:14 +0200
Message-Id: <1411655235-7635-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1411655235-7635-1-git-send-email-lars@metafoo.de>
References: <1411655235-7635-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We shouldn't be doing the unit conversion in kernel space. Just report the
raw value for the property and the scale. Userspace can do the conversion if
necessary.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Changes from v1:
	* Slightly restructured error path to make it clear that the mutex is
	  only unlocked when it was locked before.
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index b6bd609..95b17c5 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -113,7 +113,8 @@ static const struct iio_chan_spec ad5933_channels[] = {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
 		.address = AD5933_REG_TEMP_DATA,
 		.scan_index = -1,
 		.scan_type = {
@@ -520,12 +521,11 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
 {
 	struct ad5933_state *st = iio_priv(indio_dev);
 	__be16 dat;
-	int ret = -EINVAL;
+	int ret;
 
-	mutex_lock(&indio_dev->mlock);
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-	case IIO_CHAN_INFO_PROCESSED:
+		mutex_lock(&indio_dev->mlock);
 		if (iio_buffer_enabled(indio_dev)) {
 			ret = -EBUSY;
 			goto out;
@@ -543,16 +543,16 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			goto out;
 		mutex_unlock(&indio_dev->mlock);
-		ret = be16_to_cpu(dat);
-		/* Temp in Milli degrees Celsius */
-		if (ret < 8192)
-			*val = ret * 1000 / 32;
-		else
-			*val = (ret - 16384) * 1000 / 32;
+		*val = sign_extend32(be16_to_cpu(dat), 13);
 
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 1000;
+		*val2 = 5;
+		return IIO_VAL_FRACTIONAL_LOG2;
 	}
 
+	return -EINVAL;
 out:
 	mutex_unlock(&indio_dev->mlock);
 	return ret;
-- 
1.8.0

