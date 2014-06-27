Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45326 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbaF0Agb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 26 Jun 2014 20:36:31 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH 2/2] iio: magnetometer: ak8975: Improve performance of raw reads
Date: Thu, 26 Jun 2014 17:40:26 -0700
Message-Id: <1403829626-17660-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1403829626-17660-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1403829626-17660-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Define a channel to read x,y and z together. This raw read takes
50% less time reading all axes together than individual reads.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 58 ++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 24fc917..b6041ca 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -1,3 +1,4 @@
+
 /*
  * A sensor driver for the magnetometer AK8975.
  *
@@ -373,12 +374,14 @@ static int wait_conversion_complete_interrupt(struct ak8975_data *data)
 }
 
 /*
- * Emits the raw flux value for the x, y, or z axis.
+ * Emits the raw flux value for the x, y, or z individual or multiple axes
  */
-static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
+static int ak8975_read_axis(struct iio_dev *indio_dev, int axes_size,
+			    int *indexes, int *vals)
 {
 	struct ak8975_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
+	int i;
 	int ret;
 
 	mutex_lock(&data->lock);
@@ -421,36 +424,50 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 
 	/* Read the flux value from the appropriate register
 	   (the register is specified in the iio device attributes). */
-	ret = i2c_smbus_read_word_data(client, ak8975_index_to_reg[index]);
-	if (ret < 0) {
-		dev_err(&client->dev, "Read axis data fails\n");
-		goto exit;
+	for (i = 0; i < axes_size; ++i) {
+		ret = i2c_smbus_read_word_data(client,
+					ak8975_index_to_reg[*indexes++]);
+		if (ret < 0) {
+			dev_err(&client->dev, "Read axis data fails\n");
+			goto exit;
+		}
+		/* Clamp to valid range. */
+		vals[i] = clamp_t(s16, ret, -4096, 4095);
 	}
 
 	mutex_unlock(&data->lock);
 
-	/* Clamp to valid range. */
-	*val = clamp_t(s16, ret, -4096, 4095);
-	return IIO_VAL_INT;
-
+	if (axes_size > 1)
+		return IIO_VAL_INT_MULTIPLE;
+	else
+		return IIO_VAL_INT;
 exit:
 	mutex_unlock(&data->lock);
 	return ret;
 }
 
-static int ak8975_read_raw(struct iio_dev *indio_dev,
-			   struct iio_chan_spec const *chan,
-			   int *val, int *val2,
-			   long mask)
+static int ak8975_read_raw_multi(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int size, int *vals, int *val_len,
+				 long mask)
 {
 	struct ak8975_data *data = iio_priv(indio_dev);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		return ak8975_read_axis(indio_dev, chan->address, val);
+		if (size >= 3 && chan->address == 3) {
+			int indexes[3] = {0, 1, 2};
+
+			ret = ak8975_read_axis(indio_dev, 3, indexes, vals);
+			*val_len = 3;
+		} else
+			ret = ak8975_read_axis(indio_dev, 1,
+					       (int *)&chan->address, vals);
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		*val2 = data->raw_to_gauss[chan->address];
+		vals[0] = 0;
+		vals[1] = data->raw_to_gauss[chan->address];
 		return IIO_VAL_INT_PLUS_MICRO;
 	}
 	return -EINVAL;
@@ -467,11 +484,14 @@ static int ak8975_read_raw(struct iio_dev *indio_dev,
 	}
 
 static const struct iio_chan_spec ak8975_channels[] = {
-	AK8975_CHANNEL(X, 0), AK8975_CHANNEL(Y, 1), AK8975_CHANNEL(Z, 2),
+	AK8975_CHANNEL(X, 0),
+	AK8975_CHANNEL(Y, 1),
+	AK8975_CHANNEL(Z, 2),
+	AK8975_CHANNEL(X_AND_Y_AND_Z, 3)
 };
 
 static const struct iio_info ak8975_info = {
-	.read_raw = &ak8975_read_raw,
+	.read_raw_multi = &ak8975_read_raw_multi,
 	.driver_module = THIS_MODULE,
 };
 
-- 
1.8.3.2

