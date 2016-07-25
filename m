Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36213 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbcGYK6L (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2016 06:58:11 -0400
From: Pratik Prajapati <pratik.prajapati12@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pratik Prajapati <pratik.prajapati12@gmail.com>
Subject: [PATCH v2 2/2] staging: iio: vcnl4000: Replace i2c api's with regmap
Date: Mon, 25 Jul 2016 16:27:29 +0530
Message-Id: <1469444249-2124-2-git-send-email-pratik.prajapati12@gmail.com>
In-Reply-To: <1469444249-2124-1-git-send-email-pratik.prajapati12@gmail.com>
References: <1469444249-2124-1-git-send-email-pratik.prajapati12@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Pratik Prajapati <pratik.prajapati12@gmail.com>
---
Changes v1 -> v2
  - added error msgs for led current's read and write functions

 drivers/iio/light/vcnl4000.c | 99 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 86 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index dcf7a6f..9a79022 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -21,6 +21,7 @@
 #include <linux/i2c.h>
 #include <linux/err.h>
 #include <linux/delay.h>
+#include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -53,6 +54,7 @@
 struct vcnl4000_data {
 	struct i2c_client *client;
 	struct mutex lock;
+	struct regmap *regmap;
 };
 
 static const struct i2c_device_id vcnl4000_id[] = {
@@ -67,20 +69,20 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 	int tries = 20;
 	__be16 buf;
 	int ret;
+	unsigned int regval;
 
 	mutex_lock(&data->lock);
 
-	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND,
-					req_mask);
+	ret = regmap_write(data->regmap, VCNL4000_COMMAND, req_mask);
 	if (ret < 0)
 		goto fail;
 
 	/* wait for data to become ready */
 	while (tries--) {
-		ret = i2c_smbus_read_byte_data(data->client, VCNL4000_COMMAND);
+		ret = regmap_read(data->regmap, VCNL4000_COMMAND, &regval);
 		if (ret < 0)
 			goto fail;
-		if (ret & rdy_mask)
+		if (regval & rdy_mask)
 			break;
 		msleep(20); /* measurement takes up to 100 ms */
 	}
@@ -92,8 +94,8 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 		goto fail;
 	}
 
-	ret = i2c_smbus_read_i2c_block_data(data->client,
-		data_reg, sizeof(buf), (u8 *) &buf);
+	ret = regmap_bulk_read(data->regmap, data_reg, (u8 *) &buf,
+			sizeof(buf));
 	if (ret < 0)
 		goto fail;
 
@@ -127,29 +129,38 @@ static const struct iio_chan_spec vcnl4000_channels[] = {
 
 static int vcnl4000_write_led_current_raw(struct vcnl4000_data *data, int val)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
 	if (val < 0 || val > VCNL4000_LED_CURRENT_MAX)
 		return -ERANGE;
+
 	mutex_lock(&data->lock);
-	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_LED_CURRENT,
-			VCNL4000_LED_CURRENT_MASK & val);
+	ret = regmap_write_bits(data->regmap, VCNL4000_LED_CURRENT,
+		VCNL4000_LED_CURRENT_MASK, val);
 	mutex_unlock(&data->lock);
+	if (ret < 0)
+		dev_err(dev, "Failed to write to LED current register: %d",
+				ret);
 
 	return ret;
 }
 
 static int vcnl4000_read_led_current_raw(struct vcnl4000_data *data)
 {
+	struct device *dev = regmap_get_device(data->regmap);
+	unsigned int regval;
 	int ret;
 
 	mutex_lock(&data->lock);
-	ret = i2c_smbus_read_byte_data(data->client, VCNL4000_LED_CURRENT);
+	ret = regmap_read(data->regmap, VCNL4000_LED_CURRENT, &regval);
 	mutex_unlock(&data->lock);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(dev, "Failed to read LED current register: %d", ret);
 		return ret;
+	}
 
-	return ret &= VCNL4000_LED_CURRENT_MASK;
+	return regval &= VCNL4000_LED_CURRENT_MASK;
 }
 
 static int vcnl4000_read_raw(struct iio_dev *indio_dev,
@@ -223,27 +234,89 @@ static const struct iio_info vcnl4000_info = {
 	.driver_module = THIS_MODULE,
 };
 
+static bool vcnl4000_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case VCNL4000_COMMAND:
+	case VCNL4000_PROD_REV:
+	case VCNL4000_LED_CURRENT:
+	case VCNL4000_AL_PARAM:
+	case VCNL4000_AL_RESULT_HI:
+	case VCNL4000_AL_RESULT_LO:
+	case VCNL4000_PS_RESULT_HI:
+	case VCNL4000_PS_RESULT_LO:
+	case VCNL4000_PS_MEAS_FREQ:
+	case VCNL4000_PS_MOD_ADJ:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool vcnl4000_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case VCNL4000_COMMAND:
+	case VCNL4000_LED_CURRENT:
+	case VCNL4000_AL_PARAM:
+	case VCNL4000_PS_MEAS_FREQ:
+	case VCNL4000_PS_MOD_ADJ:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool vcnl4000_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case VCNL4000_COMMAND:
+	case VCNL4000_AL_RESULT_HI:
+	case VCNL4000_AL_RESULT_LO:
+	case VCNL4000_PS_RESULT_HI:
+	case VCNL4000_PS_RESULT_LO:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config vcnl4000_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.max_register	= VCNL4000_PS_MOD_ADJ,
+	.readable_reg	= vcnl4000_readable_reg,
+	.writeable_reg	= vcnl4000_writeable_reg,
+	.volatile_reg	= vcnl4000_volatile_reg,
+};
+
 static int vcnl4000_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
 	struct vcnl4000_data *data;
 	struct iio_dev *indio_dev;
 	int ret, prod_id;
+	unsigned int regval;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
+	data->regmap = devm_regmap_init_i2c(client, &vcnl4000_regmap_config);
+	if (IS_ERR(data->regmap)) {
+		dev_err(&client->dev, "regmap_init failed!\n");
+		return PTR_ERR(data->regmap);
+	}
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 	mutex_init(&data->lock);
 
-	ret = i2c_smbus_read_byte_data(data->client, VCNL4000_PROD_REV);
+	ret = regmap_read(data->regmap, VCNL4000_PROD_REV, &regval);
 	if (ret < 0)
 		return ret;
 
-	prod_id = ret >> 4;
+	prod_id = regval >> 4;
 	if (prod_id != VCNL4010_ID && prod_id != VCNL4000_ID)
 		return -ENODEV;
 
-- 
2.6.2

