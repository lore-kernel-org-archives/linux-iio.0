Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:46054 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbaBNKEW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Feb 2014 05:04:22 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0Z001TTDB8Y070@mailout2.samsung.com> for
 linux-iio@vger.kernel.org; Fri, 14 Feb 2014 19:04:20 +0900 (KST)
Message-id: <52FDEA23.1010807@samsung.com>
Date: Fri, 14 Feb 2014 19:04:19 +0900
From: Beomho Seo <beomho.seo@samsung.com>
MIME-version: 1.0
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Myungjoo Ham <myungjoo.ham@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 2/2] iio: cm32181:  Change cm32181 ambient light sensor
 driver
Content-type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Integration time of cm32181 is guessed about milliseconds.
But cm32181_read_als_it function return IIO_VAL_INT.
So fixed to return IIO_VAL_INT_PLUS_MICRO.
Next, add .write_raw_get_fmt callback function for call iio_str_to_fixpoint.

v2: cm32181_write_als_id function fixed as it was.

Cc: Kevin Tsai <ktsai@capellamicro.com>
Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 drivers/iio/light/cm32181.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index f17b4e6..27c293c 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -103,13 +103,13 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
 /**
  *  cm32181_read_als_it() - Get sensor integration time (ms)
  *  @cm32181:	pointer of struct cm32181
- *  @val:	pointer of int to load the als_it value.
+ *  @val2:	pointer of int to load the als_it value.
  *
  *  Report the current integartion time by millisecond.
  *
- *  Return: IIO_VAL_INT for success, otherwise -EINVAL.
+ *  Return: IIO_VAL_INT_PLUS_MICRO for success, otherwise -EINVAL.
  */
-static int cm32181_read_als_it(struct cm32181_chip *cm32181, int *val)
+static int cm32181_read_als_it(struct cm32181_chip *cm32181, int *val2)
 {
 	u16 als_it;
 	int i;
@@ -119,8 +119,8 @@ static int cm32181_read_als_it(struct cm32181_chip *cm32181, int *val)
 	als_it >>= CM32181_CMD_ALS_IT_SHIFT;
 	for (i = 0; i < ARRAY_SIZE(als_it_bits); i++) {
 		if (als_it == als_it_bits[i]) {
-			*val = als_it_value[i];
-			return IIO_VAL_INT;
+			*val2 = als_it_value[i];
+			return IIO_VAL_INT_PLUS_MICRO;
 		}
 	}

@@ -221,7 +221,7 @@ static int cm32181_read_raw(struct iio_dev *indio_dev,
 		*val = cm32181->calibscale;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_INT_TIME:
-		ret = cm32181_read_als_it(cm32181, val);
+		ret = cm32181_read_als_it(cm32181, val2);
 		return ret;
 	}

@@ -240,13 +240,20 @@ static int cm32181_write_raw(struct iio_dev *indio_dev,
 		cm32181->calibscale = val;
 		return val;
 	case IIO_CHAN_INFO_INT_TIME:
-		ret = cm32181_write_als_it(cm32181, val);
+		ret = cm32181_write_als_it(cm32181, val2);
 		return ret;
 	}

 	return -EINVAL;
 }

+static int cm32181_write_raw_get_fmt(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				long mask)
+{
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
 /**
  * cm32181_get_it_available() - Get available ALS IT value
  * @dev:	pointer of struct device.
@@ -264,7 +271,7 @@ static ssize_t cm32181_get_it_available(struct device *dev,

 	n = ARRAY_SIZE(als_it_value);
 	for (i = 0, len = 0; i < n; i++)
-		len += sprintf(buf + len, "%d ", als_it_value[i]);
+		len += sprintf(buf + len, "0.%06u ", als_it_value[i]);
 	return len + sprintf(buf + len, "\n");
 }

@@ -294,6 +301,7 @@ static const struct iio_info cm32181_info = {
 	.driver_module		= THIS_MODULE,
 	.read_raw		= &cm32181_read_raw,
 	.write_raw		= &cm32181_write_raw,
+	.write_raw_get_fmt	= &cm32181_write_raw_get_fmt,
 	.attrs			= &cm32181_attribute_group,
 };

-- 
1.7.9.5

-- 
Best Regards,
