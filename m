Return-Path: <leonard.crestez@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH] iio: ak8975: Support adapters limited to BYTE_DATA
Date: Fri, 29 Apr 2016 22:05:32 +0300
Message-Id: <f5ae14d77b19c4a10e9a94cf182cfdb96dd1b0cb.1461956645.git.leonard.crestez@intel.com>
List-ID: <linux-iio@vger.kernel.org>

The device has simple 8-bit registers but the driver incorrectly uses
block or word reads without checking functionality bits.

Fix by using i2c_smbus_read_i2c_block_data_or_emulated instead of
i2c_smbus_read_i2c_block_data or i2c_smbus_read_word_data. This will
check functionality bits and use the fastest available transfer method.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index dbf0661..c24b8a5 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -430,8 +430,8 @@ static int ak8975_who_i_am(struct i2c_client *client,
 	 * AK8975   |  DEVICE_ID |  NA
 	 * AK8963   |  DEVICE_ID |  NA
 	 */
-	ret = i2c_smbus_read_i2c_block_data(client, AK09912_REG_WIA1,
-					    2, wia_val);
+	ret = i2c_smbus_read_i2c_block_data_or_emulated(
+			client, AK09912_REG_WIA1, 2, wia_val);
 	if (ret < 0) {
 		dev_err(&client->dev, "Error reading WIA\n");
 		return ret;
@@ -543,9 +543,9 @@ static int ak8975_setup(struct i2c_client *client)
 	}
 
 	/* Get asa data and store in the device data. */
-	ret = i2c_smbus_read_i2c_block_data(client,
-					    data->def->ctrl_regs[ASA_BASE],
-					    3, data->asa);
+	ret = i2c_smbus_read_i2c_block_data_or_emulated(
+			client, data->def->ctrl_regs[ASA_BASE],
+			3, data->asa);
 	if (ret < 0) {
 		dev_err(&client->dev, "Not able to read asa data\n");
 		return ret;
@@ -686,6 +686,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	struct ak8975_data *data = iio_priv(indio_dev);
 	const struct i2c_client *client = data->client;
 	const struct ak_def *def = data->def;
+	u16 buff;
 	int ret;
 
 	mutex_lock(&data->lock);
@@ -694,14 +695,17 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	if (ret)
 		goto exit;
 
-	ret = i2c_smbus_read_word_data(client, def->data_regs[index]);
+	ret = i2c_smbus_read_i2c_block_data_or_emulated(
+			client, def->data_regs[index],
+			sizeof(buff), (u8*)&buff);
 	if (ret < 0)
 		goto exit;
 
 	mutex_unlock(&data->lock);
 
-	/* Clamp to valid range. */
-	*val = clamp_t(s16, ret, -def->range, def->range);
+	/* Swap bytes and convert to valid range. */
+	buff = le16_to_cpu(buff);
+	*val = clamp_t(s16, buff, -def->range, def->range);
 	return IIO_VAL_INT;
 
 exit:
-- 
2.5.5
