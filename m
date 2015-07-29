Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:59676 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753090AbbG2Vjz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 29 Jul 2015 17:39:55 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: [PATCH v2 3/7] iio:accel:stk8312: improve error handling
Date: Wed, 29 Jul 2015 23:39:36 +0200
Message-Id: <ba37bdc28af46b4bd38e4a923d87a5d8e78ce2ee.1438204273.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438204273.git.knaack.h@gmx.de>
References: <cover.1438204273.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438204273.git.knaack.h@gmx.de>
References: <cover.1438204273.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Improve error handling in the following ways:
  - set return value on error condition to an appropriate error code
  - return error code immediately in case of an error (slightly changes
    code structure)
  - pass up real error code
  - add missing error handling
  - return 0 when error have been caught already
  - put device back in active mode after error occurs

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/stk8312.c | 60 ++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 6592be8e6377..4e1dda7e896d 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -146,8 +146,10 @@ static int stk8312_otp_init(struct stk8312_data *data)
 		count--;
 	} while (!(ret & 0x80) && count > 0);
 
-	if (count == 0)
+	if (count == 0) {
+		ret = -ETIMEDOUT;
 		goto exit_err;
+	}
 
 	ret = i2c_smbus_read_byte_data(client, STK8312_REG_OTPDATA);
 	if (ret == 0)
@@ -161,7 +163,7 @@ static int stk8312_otp_init(struct stk8312_data *data)
 		goto exit_err;
 	msleep(150);
 
-	return ret;
+	return 0;
 
 exit_err:
 	dev_err(&client->dev, "failed to initialize sensor\n");
@@ -205,8 +207,11 @@ static int stk8312_set_interrupts(struct stk8312_data *data, u8 int_mask)
 		return ret;
 
 	ret = i2c_smbus_write_byte_data(client, STK8312_REG_INTSU, int_mask);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&client->dev, "failed to set interrupts\n");
+		stk8312_set_mode(data, mode);
+		return ret;
+	}
 
 	return stk8312_set_mode(data, mode);
 }
@@ -230,7 +235,7 @@ static int stk8312_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 	data->dready_trigger_on = state;
 
-	return ret;
+	return 0;
 }
 
 static const struct iio_trigger_ops stk8312_trigger_ops = {
@@ -255,20 +260,24 @@ static int stk8312_set_sample_rate(struct stk8312_data *data, int rate)
 		return ret;
 
 	ret = i2c_smbus_read_byte_data(client, STK8312_REG_SR);
-	if (ret < 0) {
-		dev_err(&client->dev, "failed to set sampling rate\n");
-		return ret;
-	}
+	if (ret < 0)
+		goto err_activate;
 
 	masked_reg = (ret & (~STK8312_SR_MASK)) | rate;
 
 	ret = i2c_smbus_write_byte_data(client, STK8312_REG_SR, masked_reg);
 	if (ret < 0)
-		dev_err(&client->dev, "failed to set sampling rate\n");
-	else
-		data->sample_rate_idx = rate;
+		goto err_activate;
+
+	data->sample_rate_idx = rate;
 
 	return stk8312_set_mode(data, mode);
+
+err_activate:
+	dev_err(&client->dev, "failed to set sampling rate\n");
+	stk8312_set_mode(data, mode);
+
+	return ret;
 }
 
 static int stk8312_set_range(struct stk8312_data *data, u8 range)
@@ -290,21 +299,25 @@ static int stk8312_set_range(struct stk8312_data *data, u8 range)
 		return ret;
 
 	ret = i2c_smbus_read_byte_data(client, STK8312_REG_STH);
-	if (ret < 0) {
-		dev_err(&client->dev, "failed to change sensor range\n");
-		return ret;
-	}
+	if (ret < 0)
+		goto err_activate;
 
 	masked_reg = ret & (~STK8312_RNG_MASK);
 	masked_reg |= range << STK8312_RNG_SHIFT;
 
 	ret = i2c_smbus_write_byte_data(client, STK8312_REG_STH, masked_reg);
 	if (ret < 0)
-		dev_err(&client->dev, "failed to change sensor range\n");
-	else
-		data->range = range;
+		goto err_activate;
+
+	data->range = range;
 
 	return stk8312_set_mode(data, mode);
+
+err_activate:
+	dev_err(&client->dev, "failed to change sensor range\n");
+	stk8312_set_mode(data, mode);
+
+	return ret;
 }
 
 static int stk8312_read_accel(struct stk8312_data *data, u8 address)
@@ -337,18 +350,21 @@ static int stk8312_read_raw(struct iio_dev *indio_dev,
 		ret = stk8312_set_mode(data, data->mode | STK8312_MODE_ACTIVE);
 		if (ret < 0) {
 			mutex_unlock(&data->lock);
-			return -EINVAL;
+			return ret;
 		}
 		ret = stk8312_read_accel(data, chan->address);
 		if (ret < 0) {
 			stk8312_set_mode(data,
 					 data->mode & (~STK8312_MODE_ACTIVE));
 			mutex_unlock(&data->lock);
-			return -EINVAL;
+			return ret;
 		}
 		*val = sign_extend32(ret, 7);
-		stk8312_set_mode(data, data->mode & (~STK8312_MODE_ACTIVE));
+		ret = stk8312_set_mode(data,
+				       data->mode & (~STK8312_MODE_ACTIVE));
 		mutex_unlock(&data->lock);
+		if (ret < 0)
+			return ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = stk8312_scale_table[data->range - 1][0];
@@ -608,7 +624,7 @@ static int stk8312_probe(struct i2c_client *client,
 		goto err_buffer_cleanup;
 	}
 
-	return ret;
+	return 0;
 
 err_buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
-- 
2.4.6

