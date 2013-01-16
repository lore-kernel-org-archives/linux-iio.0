Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-069.synserver.de ([212.40.185.69]:1081 "EHLO
	smtp-out-069.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077Ab3APMs1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jan 2013 07:48:27 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/15] iio:adis16400: Increase samplerate precession
Date: Wed, 16 Jan 2013 13:48:48 +0100
Message-Id: <1358340531-31350-12-git-send-email-lars@metafoo.de>
In-Reply-To: <1358340531-31350-1-git-send-email-lars@metafoo.de>
References: <1358340531-31350-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The devices supported by this drivers support sample rates with less than one
sample per second. To support this increase the samplerate precession to allow
setting (and reading) the samplerate with a milli-HZ precession.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/imu/adis16400_core.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
index 1bbe5ee..8551fde 100644
--- a/drivers/iio/imu/adis16400_core.c
+++ b/drivers/iio/imu/adis16400_core.c
@@ -53,16 +53,15 @@ static int adis16334_get_freq(struct adis16400_state *st)
 
 	t >>= ADIS16334_RATE_DIV_SHIFT;
 
-	return (8192 >> t) / 10;
+	return 819200 >> t;
 }
 
 static int adis16334_set_freq(struct adis16400_state *st, unsigned int freq)
 {
 	unsigned int t;
 
-	freq *= 10;
-	if (freq < 8192)
-		t = ilog2(8192 / freq);
+	if (freq < 819200)
+		t = ilog2(819200 / freq);
 	else
 		t = 0;
 
@@ -84,7 +83,7 @@ static int adis16400_get_freq(struct adis16400_state *st)
 	if (ret < 0)
 		return ret;
 
-	sps = (t & ADIS16400_SMPL_PRD_TIME_BASE) ? 53 : 1638;
+	sps = (t & ADIS16400_SMPL_PRD_TIME_BASE) ? 52851 : 1638404;
 	sps /= (t & ADIS16400_SMPL_PRD_DIV_MASK) + 1;
 
 	return sps;
@@ -94,7 +93,7 @@ static int adis16400_set_freq(struct adis16400_state *st, unsigned int freq)
 {
 	unsigned int t;
 
-	t = 1638 / freq;
+	t = 1638404 / freq;
 	if (t > 0)
 		t--;
 	t &= ADIS16400_SMPL_PRD_DIV_MASK;
@@ -119,7 +118,7 @@ static ssize_t adis16400_read_frequency(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%d\n", ret);
+	return sprintf(buf, "%d.%.3d\n", ret / 1000, ret % 1000);
 }
 
 static const unsigned adis16400_3db_divisors[] = {
@@ -158,14 +157,16 @@ static ssize_t adis16400_write_frequency(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct adis16400_state *st = iio_priv(indio_dev);
-	long val;
+	int i, f, val;
 	int ret;
 
-	ret = kstrtol(buf, 10, &val);
+	ret = iio_str_to_fixpoint(buf, 100, &i, &f);
 	if (ret)
 		return ret;
 
-	if (val == 0)
+	val = i * 1000 + f;
+
+	if (val <= 0)
 		return -EINVAL;
 
 	mutex_lock(&indio_dev->mlock);
@@ -281,7 +282,8 @@ static int adis16400_write_raw(struct iio_dev *indio_dev,
 			return sps;
 		}
 
-		ret = adis16400_set_filter(indio_dev, sps, val);
+		ret = adis16400_set_filter(indio_dev, sps,
+			val * 1000 + val2 / 1000);
 		mutex_unlock(&indio_dev->mlock);
 		return ret;
 	default:
@@ -355,9 +357,11 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		}
 		ret = st->variant->get_freq(st);
-		if (ret >= 0)
-			*val = ret / adis16400_3db_divisors[val16 & 0x07];
-		*val2 = 0;
+		if (ret >= 0) {
+			ret /= adis16400_3db_divisors[val16 & 0x07];
+			*val = ret / 1000;
+			*val2 = (ret % 1000) * 1000;
+		}
 		mutex_unlock(&indio_dev->mlock);
 		if (ret < 0)
 			return ret;
-- 
1.8.0

