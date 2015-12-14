Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:56191 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932140AbbLNMZ0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 14 Dec 2015 07:25:26 -0500
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH v2 3/3] iio: light: us5182d: Refactor read_raw function
Date: Mon, 14 Dec 2015 14:24:47 +0200
Message-Id: <1450095887-13122-4-git-send-email-adriana.reus@intel.com>
In-Reply-To: <1450095887-13122-1-git-send-email-adriana.reus@intel.com>
References: <1450095887-13122-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

A bit of refactoring for better readability.
Moved and slightly reorganized all the activity necessary for reading als
and proximity into a different function. This way the switch in read raw
becomes clearer and more compact.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
---
 No change since initial patch

 drivers/iio/light/us5182d.c | 155 ++++++++++++++++++++++----------------------
 1 file changed, 78 insertions(+), 77 deletions(-)

diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index 213f778..45bc2f7 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -203,23 +203,6 @@ static const struct iio_chan_spec us5182d_channels[] = {
 	}
 };
 
-static int us5182d_get_als(struct us5182d_data *data)
-{
-	int ret;
-	unsigned long result;
-
-	ret = i2c_smbus_read_word_data(data->client,
-				       US5182D_REG_ADL);
-	if (ret < 0)
-		return ret;
-
-	result = ret * data->ga / US5182D_GA_RESOLUTION;
-	if (result > 0xffff)
-		result = 0xffff;
-
-	return result;
-}
-
 static int us5182d_oneshot_en(struct us5182d_data *data)
 {
 	int ret;
@@ -324,6 +307,39 @@ static int us5182d_px_enable(struct us5182d_data *data)
 	return 0;
 }
 
+static int us5182d_get_als(struct us5182d_data *data)
+{
+	int ret;
+	unsigned long result;
+
+	ret = us5182d_als_enable(data);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_word_data(data->client,
+				       US5182D_REG_ADL);
+	if (ret < 0)
+		return ret;
+
+	result = ret * data->ga / US5182D_GA_RESOLUTION;
+	if (result > 0xffff)
+		result = 0xffff;
+
+	return result;
+}
+
+static int us5182d_get_px(struct us5182d_data *data)
+{
+	int ret;
+
+	ret = us5182d_px_enable(data);
+	if (ret < 0)
+		return ret;
+
+	return i2c_smbus_read_word_data(data->client,
+					US5182D_REG_PDL);
+}
+
 static int us5182d_shutdown_en(struct us5182d_data *data, u8 state)
 {
 	int ret;
@@ -370,6 +386,46 @@ static int us5182d_set_power_state(struct us5182d_data *data, bool on)
 	return ret;
 }
 
+static int us5182d_read_value(struct us5182d_data *data,
+			      struct iio_chan_spec const *chan)
+{
+	int ret, value;
+
+	mutex_lock(&data->lock);
+
+	if (data->power_mode == US5182D_ONESHOT) {
+		ret = us5182d_oneshot_en(data);
+		if (ret < 0)
+			goto out_err;
+	}
+
+	ret = us5182d_set_power_state(data, true);
+	if (ret < 0)
+		goto out_err;
+
+	if (chan->type == IIO_LIGHT)
+		ret = us5182d_get_als(data);
+	else
+		ret = us5182d_get_px(data);
+	if (ret < 0)
+		goto out_poweroff;
+
+	value = ret;
+
+	ret = us5182d_set_power_state(data, false);
+	if (ret < 0)
+		goto out_err;
+
+	mutex_unlock(&data->lock);
+	return value;
+
+out_poweroff:
+	us5182d_set_power_state(data, false);
+out_err:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
 static int us5182d_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int *val,
 			    int *val2, long mask)
@@ -379,76 +435,21 @@ static int us5182d_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		switch (chan->type) {
-		case IIO_LIGHT:
-			mutex_lock(&data->lock);
-			if (data->power_mode == US5182D_ONESHOT) {
-				ret = us5182d_oneshot_en(data);
-				if (ret < 0)
-					goto out_err;
-			}
-			ret = us5182d_set_power_state(data, true);
-			if (ret < 0)
-				goto out_err;
-			ret = us5182d_als_enable(data);
-			if (ret < 0)
-				goto out_poweroff;
-			ret = us5182d_get_als(data);
-			if (ret < 0)
-				goto out_poweroff;
-			*val = ret;
-			ret = us5182d_set_power_state(data, false);
-			if (ret < 0)
-				goto out_err;
-			mutex_unlock(&data->lock);
-			return IIO_VAL_INT;
-		case IIO_PROXIMITY:
-			mutex_lock(&data->lock);
-			if (data->power_mode == US5182D_ONESHOT) {
-				ret = us5182d_oneshot_en(data);
-				if (ret < 0)
-					goto out_err;
-			}
-			ret = us5182d_set_power_state(data, true);
-			if (ret < 0)
-				goto out_err;
-			ret = us5182d_px_enable(data);
-			if (ret < 0)
-				goto out_poweroff;
-			ret = i2c_smbus_read_word_data(data->client,
-						       US5182D_REG_PDL);
-			if (ret < 0)
-				goto out_poweroff;
-			*val = ret;
-			ret = us5182d_set_power_state(data, false);
-			if (ret < 0)
-				goto out_err;
-			mutex_unlock(&data->lock);
-			return IIO_VAL_INT;
-		default:
-			return -EINVAL;
-		}
-
+		ret = us5182d_read_value(data, chan);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		ret = i2c_smbus_read_byte_data(data->client, US5182D_REG_CFG1);
 		if (ret < 0)
 			return ret;
-
 		*val = 0;
 		*val2 = us5182d_scales[ret & US5182D_AGAIN_MASK];
-
 		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
-
-	return -EINVAL;
-
-out_poweroff:
-	us5182d_set_power_state(data, false);
-out_err:
-	mutex_unlock(&data->lock);
-	return ret;
 }
 
 /**
-- 
1.9.1

