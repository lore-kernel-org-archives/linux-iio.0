Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A423AB267;
	Mon,  4 May 2026 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777893908; cv=none; b=eQV1/oKFlsEC1prDSzhvFGSapZ6PaQxJr4uRAXNc4hrMHa4IshyBjgms8ExotouJXXcV3IQ+ju6PRaC0ER1WtshamVlHBgbmrSLE/+rwzAw3KxsE6yqfkU/uBtMI0yqjKEerioJkervM7owy+mxaQ4O3XNNRcFlpa5kMgaCQYjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777893908; c=relaxed/simple;
	bh=QOM8BGKhXevrwDty2+jL+o+Pd1DXUL53OYVHYmtmCs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nQt+UZ5ydm6ZVhVlANxESBsysICm1I9eYkmCoz8DLQW1rKAfHMU8tEz2v+R9RaVSag2qfcfAka6rwLvo8o/sgWIH9JRnKe+QyZi5z5D2TILlAAdsWwpPIiBuzBYvgE7W0wH9IPWNlW04IqVl+K5a5dLVemnXUlQ2shpLSNPtOM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	(Authenticated sender: rastyoginds)
	by air.basealt.ru (Postfix) with ESMTPSA id 794562333B;
	Mon,  4 May 2026 14:19:46 +0300 (MSK)
From: gerben@altlinux.org
To: dlechner@baylibre.com,
	jagathjog1996@gmail.com
Cc: jic23@kernel.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] iio: imu: bmi323: Fix potential out-of-bounds access of bmi323_hw[]
Date: Mon,  4 May 2026 14:19:46 +0300
Message-ID: <20260504111946.28315-1-gerben@altlinux.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis Rastyogin <gerben@altlinux.org>

The bmi323_channels[] array defines a channel with chan->type =
IIO_TEMP and enables the IIO_CHAN_INFO_SCALE mask. As a result,
bmi323_write_raw() may be called for this channel. However,
bmi323_iio_to_sensor() returns -EINVAL for IIO_TEMP, and if this
value is not validated, it can lead to an out-of-bounds access
when used as an array index.

A similar case is properly handled in bmi323_read_raw() and does
not result in an error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 8a636db3aa57 ("iio: imu: Add driver for BMI323 IMU")
Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 drivers/iio/imu/bmi323/bmi323_core.c | 42 ++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index f3d499423399..c7398593301f 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -1673,6 +1673,7 @@ static int bmi323_read_avail(struct iio_dev *indio_dev,
 			     long mask)
 {
 	enum bmi323_sensor_type sensor;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -1681,7 +1682,10 @@ static int bmi323_read_avail(struct iio_dev *indio_dev,
 		*length = ARRAY_SIZE(bmi323_acc_gyro_odr) * 2;
 		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_SCALE:
-		sensor = bmi323_iio_to_sensor(chan->type);
+		ret = bmi323_iio_to_sensor(chan->type);
+		if (ret < 0)
+			return ret;
+		sensor = ret;
 		*type = IIO_VAL_INT_PLUS_MICRO;
 		*vals = (const int *)bmi323_hw[sensor].scale_table;
 		*length = bmi323_hw[sensor].scale_table_len * 2;
@@ -1705,24 +1709,33 @@ static int bmi323_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = bmi323_iio_to_sensor(chan->type);
+		if (ret < 0)
+			return ret;
+
 		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
-		ret = bmi323_set_odr(data, bmi323_iio_to_sensor(chan->type),
-				     val, val2);
+		ret = bmi323_set_odr(data, ret, val, val2);
 		iio_device_release_direct(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_SCALE:
+		ret = bmi323_iio_to_sensor(chan->type);
+		if (ret < 0)
+			return ret;
+
 		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
-		ret = bmi323_set_scale(data, bmi323_iio_to_sensor(chan->type),
-				       val, val2);
+		ret = bmi323_set_scale(data, ret, val, val2);
 		iio_device_release_direct(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		ret = bmi323_iio_to_sensor(chan->type);
+		if (ret < 0)
+			return ret;
+
 		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
-		ret = bmi323_set_average(data, bmi323_iio_to_sensor(chan->type),
-					 val);
+		ret = bmi323_set_average(data, ret, val);
 		iio_device_release_direct(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_ENABLE:
@@ -1770,8 +1783,11 @@ static int bmi323_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return bmi323_get_odr(data, bmi323_iio_to_sensor(chan->type),
-				      val, val2);
+		ret = bmi323_iio_to_sensor(chan->type);
+		if (ret < 0)
+			return ret;
+
+		return bmi323_get_odr(data, ret, val, val2);
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_ACCEL:
@@ -1788,9 +1804,11 @@ static int bmi323_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		return bmi323_get_average(data,
-					  bmi323_iio_to_sensor(chan->type),
-					  val);
+		ret = bmi323_iio_to_sensor(chan->type);
+		if (ret < 0)
+			return ret;
+
+		return bmi323_get_average(data, ret, val);
 	case IIO_CHAN_INFO_OFFSET:
 		switch (chan->type) {
 		case IIO_TEMP:
-- 
2.50.1

