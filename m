Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:14150 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbaA2FFN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jan 2014 00:05:13 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0500C3VCSPR8A0@mailout1.samsung.com> for
 linux-iio@vger.kernel.org; Wed, 29 Jan 2014 14:05:13 +0900 (KST)
Message-id: <52E88C09.7000507@samsung.com>
Date: Wed, 29 Jan 2014 14:05:13 +0900
From: Beomho Seo <beomho.seo@samsung.com>
MIME-version: 1.0
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Myungjoo Ham <myungjoo.ham@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>, ldewangan@nvidia.com
Subject: [PATCH 1/2] iio: ak8975: Fix calculation formula for convert micro
 tesla to gauss unit
Content-type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 drivers/iio/magnetometer/ak8975.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index ff284e5..0542354 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -85,6 +85,7 @@
 #define AK8975_MAX_CONVERSION_TIMEOUT	500
 #define AK8975_CONVERSION_DONE_POLL_TIME 10
 #define AK8975_DATA_READY_TIMEOUT	((100*HZ)/1000)
+#define RAW_TO_GAUSS(asa) ((((asa) + 128) * 3000) / 256)

 /*
  * Per-instance context data for the device.
@@ -265,15 +266,15 @@ static int ak8975_setup(struct i2c_client *client)
  *
  * Since 1uT = 0.01 gauss, our final scale factor becomes:
  *
- * Hadj = H * ((ASA + 128) / 256) * 3/10 * 100
- * Hadj = H * ((ASA + 128) * 30 / 256
+ * Hadj = H * ((ASA + 128) / 256) * 3/10 * 1/100
+ * Hadj = H * ((ASA + 128) * 0.003) / 256
  *
  * Since ASA doesn't change, we cache the resultant scale factor into the
  * device context in ak8975_setup().
  */
-	data->raw_to_gauss[0] = ((data->asa[0] + 128) * 30) >> 8;
-	data->raw_to_gauss[1] = ((data->asa[1] + 128) * 30) >> 8;
-	data->raw_to_gauss[2] = ((data->asa[2] + 128) * 30) >> 8;
+	data->raw_to_gauss[0] = RAW_TO_GAUSS(data->asa[0]);
+	data->raw_to_gauss[1] = RAW_TO_GAUSS(data->asa[1]);
+	data->raw_to_gauss[2] = RAW_TO_GAUSS(data->asa[2]);

 	return 0;
 }
@@ -428,8 +429,9 @@ static int ak8975_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		return ak8975_read_axis(indio_dev, chan->address, val);
 	case IIO_CHAN_INFO_SCALE:
-		*val = data->raw_to_gauss[chan->address];
-		return IIO_VAL_INT;
+		*val = 0;
+		*val2 = data->raw_to_gauss[chan->address];
+		return IIO_VAL_INT_PLUS_MICRO;
 	}
 	return -EINVAL;
 }
-- 
1.7.9.5

-- 
Best Regards,
