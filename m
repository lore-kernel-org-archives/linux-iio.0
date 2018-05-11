Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp688out9.mel.oss-core.net ([210.50.217.236]:57442 "EHLO
        smtp688out9.mel.oss-core.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751406AbeEKJFF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 May 2018 05:05:05 -0400
From: Richard Tresidder <rtresidd@electromag.com.au>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, harinath922@gmail.com, martink@posteo.de,
        rtresidd@electromag.com.au, linux-iio@vger.kernel.org
Subject: [PATCH v4 1/1] iio: accell: mma8452: Reduce sleep time when data not ready
Date: Fri, 11 May 2018 16:54:59 +0800
Message-Id: <1526028899-4995-1-git-send-email-rtresidd@electromag.com.au>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Modified the sleep method when data is not ready to allow for sampling > 50sps to work.

Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
---

Notes:
    v4: Changes from v3
      * fix long line
      * fix eol issues with patch
    
    v3: Changes from v2
      * Removed fallthrough fix (will submit separately)
      * Fixed some blank lines, trailing white spaces.
    
    v2: Changes from v1
      * Remove whitespace changes
      * Added fallthrough fix (subsequently removed

 drivers/iio/accel/mma8452.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 7a2da7f..7e3d82c 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -106,6 +106,7 @@ struct mma8452_data {
 	u8 ctrl_reg1;
 	u8 data_cfg;
 	const struct mma_chip_info *chip_info;
+	int sleep_val;
 };
 
  /**
@@ -193,7 +194,11 @@ static int mma8452_drdy(struct mma8452_data *data)
 		if ((ret & MMA8452_STATUS_DRDY) == MMA8452_STATUS_DRDY)
 			return 0;
 
-		msleep(20);
+		if (data->sleep_val <= 20)
+			usleep_range(data->sleep_val * 250,
+				     data->sleep_val * 500);
+		else
+			msleep(20);
 	}
 
 	dev_err(&data->client->dev, "data not ready\n");
@@ -544,6 +549,18 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
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
@@ -700,6 +717,8 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 		data->ctrl_reg1 &= ~MMA8452_CTRL_DR_MASK;
 		data->ctrl_reg1 |= i << MMA8452_CTRL_DR_SHIFT;
 
+		data->sleep_val = mma8452_calculate_sleep(data);
+
 		ret = mma8452_change_config(data, MMA8452_CTRL_REG1,
 					    data->ctrl_reg1);
 		break;
@@ -1593,6 +1612,9 @@ static int mma8452_probe(struct i2c_client *client,
 
 	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
 			  (MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
+
+	data->sleep_val = mma8452_calculate_sleep(data);
+
 	ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG1,
 					data->ctrl_reg1);
 	if (ret < 0)
-- 
1.8.3.1

