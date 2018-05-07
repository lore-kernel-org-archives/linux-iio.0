Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:34099 "EHLO
        anchovy3.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeEGENj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 May 2018 00:13:39 -0400
Subject: [PATCH v2] iio: accell: mma8452: Reduce sleep time when data not
 ready
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, harinath922@gmail.com,
        martink@posteo.de
References: <4a845aca-600d-2473-9b66-51dea9d1651b@electromag.com.au>
From: Richard Tresidder <rtresidd@electromag.com.au>
Message-ID: <5aad5eff-b0f4-4795-7c19-e177d415ed8b@electromag.com.au>
Date: Mon, 7 May 2018 12:13:42 +0800
MIME-Version: 1.0
In-Reply-To: <4a845aca-600d-2473-9b66-51dea9d1651b@electromag.com.au>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Modified the sleep method when data is not ready to allow for sampling > 50sps to work.
Fix Fallthru warning in case statement

Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
--
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 7a2da7f..948740d 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -106,6 +106,7 @@ struct mma8452_data {
 	u8 ctrl_reg1;
 	u8 data_cfg;
 	const struct mma_chip_info *chip_info;
+	int sleep_val;
 };
 
  /**
@@ -193,7 +194,10 @@ static int mma8452_drdy(struct mma8452_data *data)
 		if ((ret & MMA8452_STATUS_DRDY) == MMA8452_STATUS_DRDY)
 			return 0;
 
-		msleep(20);
+		if (data->sleep_val <= 20)
+			usleep_range(data->sleep_val * 250, data->sleep_val * 500);
+		else
+			msleep(20);
 	}
 
 	dev_err(&data->client->dev, "data not ready\n");
@@ -544,6 +548,18 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int mma8452_calculate_sleep(struct mma8452_data *data)
+{
+	int ret, i = mma8452_get_odr_index(data);
+	
+	if (mma8452_samp_freq[i][0] > 0)
+		ret = 1000 / mma8452_samp_freq[i][0];
+	else 
+		ret = 1000;
+
+	return ret == 0 ? 1 : ret;
+}
+
 static int mma8452_standby(struct mma8452_data *data)
 {
 	return i2c_smbus_write_byte_data(data->client, MMA8452_CTRL_REG1,
@@ -700,6 +716,8 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 		data->ctrl_reg1 &= ~MMA8452_CTRL_DR_MASK;
 		data->ctrl_reg1 |= i << MMA8452_CTRL_DR_SHIFT;
 
+		data->sleep_val = mma8452_calculate_sleep(data);
+
 		ret = mma8452_change_config(data, MMA8452_CTRL_REG1,
 					    data->ctrl_reg1);
 		break;
@@ -1528,6 +1546,7 @@ static int mma8452_probe(struct i2c_client *client,
 	case FXLS8471_DEVICE_ID:
 		if (ret == data->chip_info->chip_id)
 			break;
+		/* FALLTHRU */
 	default:
 		return -ENODEV;
 	}
@@ -1593,6 +1612,9 @@ static int mma8452_probe(struct i2c_client *client,
 
 	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
 			  (MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
+				
+	data->sleep_val = mma8452_calculate_sleep(data);
+
 	ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG1,
 					data->ctrl_reg1);
 	if (ret < 0)

