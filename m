Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:33385 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759214Ab3ICBFd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Sep 2013 21:05:33 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 10/18] staging:iio:hmc5843: Always read all channels values otherwise no updates
Date: Tue,  3 Sep 2013 03:05:12 +0200
Message-Id: <1378170320-27538-11-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net>
References: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Split out data ready/wait for read measurement

fix bug in case reading status register fails

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c |   53 +++++++++++++++++-----------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index faaaafc..8a152c7 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -28,12 +28,7 @@
 #define HMC5843_CONFIG_REG_A			0x00
 #define HMC5843_CONFIG_REG_B			0x01
 #define HMC5843_MODE_REG			0x02
-#define HMC5843_DATA_OUT_X_MSB_REG		0x03
-#define HMC5843_DATA_OUT_Y_MSB_REG		0x05
-#define HMC5843_DATA_OUT_Z_MSB_REG		0x07
-/* Beware: Y and Z are exchanged on HMC5883 */
-#define HMC5883_DATA_OUT_Z_MSB_REG		0x05
-#define HMC5883_DATA_OUT_Y_MSB_REG		0x07
+#define HMC5843_DATA_OUT_MSB_REGS		0x03
 #define HMC5843_STATUS_REG			0x09
 
 enum hmc5843_ids {
@@ -190,17 +185,16 @@ static s32 hmc5843_configure(struct i2c_client *client,
 					operating_mode & HMC5843_MODE_MASK);
 }
 
-/* Return the measurement value from the specified channel */
-static int hmc5843_read_measurement(struct hmc5843_data *data,
-				    int address, int *val)
+static int hmc5843_wait_measurement(struct hmc5843_data *data)
 {
 	s32 result;
 	int tries = 150;
 
-	mutex_lock(&data->lock);
 	while (tries-- > 0) {
 		result = i2c_smbus_read_byte_data(data->client,
 			HMC5843_STATUS_REG);
+		if (result < 0)
+			return result;
 		if (result & HMC5843_DATA_READY)
 			break;
 		msleep(20);
@@ -208,16 +202,32 @@ static int hmc5843_read_measurement(struct hmc5843_data *data,
 
 	if (tries < 0) {
 		dev_err(&data->client->dev, "data not ready\n");
-		mutex_unlock(&data->lock);
 		return -EIO;
 	}
 
-	result = i2c_smbus_read_word_swapped(data->client, address);
+	return 0;
+}
+
+/* Return the measurement value from the specified channel */
+static int hmc5843_read_measurement(struct hmc5843_data *data,
+				    int idx, int *val)
+{
+	s32 result;
+	s16 values[3];
+
+	mutex_lock(&data->lock);
+	result = hmc5843_wait_measurement(data);
+	if (result < 0) {
+		mutex_unlock(&data->lock);
+		return result;
+	}
+	result = i2c_smbus_read_i2c_block_data(data->client,
+		HMC5843_DATA_OUT_MSB_REGS, sizeof(values), (u8 *) values);
 	mutex_unlock(&data->lock);
 	if (result < 0)
 		return -EINVAL;
 
-	*val = sign_extend32(result, 15);
+	*val = sign_extend32(be16_to_cpu(values[idx]), 15);
 	return IIO_VAL_INT;
 }
 
@@ -499,7 +509,7 @@ static int hmc5843_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
-#define HMC5843_CHANNEL(axis, addr)					\
+#define HMC5843_CHANNEL(axis, idx)					\
 	{								\
 		.type = IIO_MAGN,					\
 		.modified = 1,						\
@@ -508,19 +518,20 @@ static int hmc5843_write_raw(struct iio_dev *indio_dev,
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
 			BIT(IIO_CHAN_INFO_SAMP_FREQ) |			\
 			BIT(IIO_CHAN_INFO_CALIBSCALE),			\
-		.address = addr						\
+		.address = idx						\
 	}
 
 static const struct iio_chan_spec hmc5843_channels[] = {
-	HMC5843_CHANNEL(X, HMC5843_DATA_OUT_X_MSB_REG),
-	HMC5843_CHANNEL(Y, HMC5843_DATA_OUT_Y_MSB_REG),
-	HMC5843_CHANNEL(Z, HMC5843_DATA_OUT_Z_MSB_REG),
+	HMC5843_CHANNEL(X, 0),
+	HMC5843_CHANNEL(Y, 1),
+	HMC5843_CHANNEL(Z, 2),
 };
 
+/* Beware: Y and Z are exchanged on HMC5883 */
 static const struct iio_chan_spec hmc5883_channels[] = {
-	HMC5843_CHANNEL(X, HMC5843_DATA_OUT_X_MSB_REG),
-	HMC5843_CHANNEL(Y, HMC5883_DATA_OUT_Y_MSB_REG),
-	HMC5843_CHANNEL(Z, HMC5883_DATA_OUT_Z_MSB_REG),
+	HMC5843_CHANNEL(X, 0),
+	HMC5843_CHANNEL(Z, 1),
+	HMC5843_CHANNEL(Y, 2),
 };
 
 static struct attribute *hmc5843_attributes[] = {
-- 
1.7.9.5

