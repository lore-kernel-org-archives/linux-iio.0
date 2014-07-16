Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:41238 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934874AbaGPSdI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 Jul 2014 14:33:08 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: [PATCH 13/13] iio:bma180: Add BMA250 chip support
Date: Wed, 16 Jul 2014 20:32:56 +0200
Message-Id: <1405535576-26482-14-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1405535576-26482-1-git-send-email-pmeerw@pmeerw.net>
References: <1405535576-26482-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

the BMA250 has only 10-bit resolution; while the data readout registers
have identical layout, the configuration is completely different compared
to the BMA180

datasheet: http://ae-bst.resource.bosch.com/media/products/dokumente/bma250/BST-BMA250-DS002-05.pdf

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
---
 drivers/iio/accel/bma180.c | 161 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 127 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 9fbc81f..c8e0a0a 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -3,9 +3,15 @@
  *
  * Copyright 2013 Oleksandr Kravchenko <x0199363@ti.com>
  *
+ * Support for BMA250 (c) Peter Meerwald <pmeerw@pmeerw.net>
+ *
  * This file is subject to the terms and conditions of version 2 of
  * the GNU General Public License.  See the file COPYING in the main
  * directory of this archive for more details.
+ *
+ * SPI is not supported by driver
+ * BMA180: 7-bit I2C slave address 0x40 or 0x41
+ * BMA250: 7-bit I2C slave address 0x18 or 0x19
  */
 
 #include <linux/module.h>
@@ -23,13 +29,13 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#define BMA180_DRV_NAME "bma180"
-#define BMA180_IRQ_NAME "bma180_event"
-
 enum {
 	BMA180,
+	BMA250,
 };
 
+struct bma180_data;
+
 struct bma180_part_info {
 	const struct iio_chan_spec *channels;
 	unsigned num_channels;
@@ -37,6 +43,15 @@ struct bma180_part_info {
 	unsigned num_scales;
 	const int *bw_table;
 	unsigned num_bw;
+
+	u8 int_reset_reg, int_reset_mask;
+	u8 sleep_reg, sleep_mask;
+	u8 bw_reg, bw_mask;
+	u8 scale_reg, scale_mask;
+	u8 power_reg, power_mask, lowpower_val;
+	u8 int_enable_reg, int_enable_mask;
+	u8 softreset_reg;
+
 	int (*chip_config)(struct bma180_data *data);
 	void (*chip_disable)(struct bma180_data *data);
 };
@@ -75,13 +90,23 @@ struct bma180_part_info {
 #define BMA180_ID_REG_VAL	0x03
 
 /* Chip power modes */
-#define BMA180_LOW_NOISE	0x00
 #define BMA180_LOW_POWER	0x03
 
-/* Defaults values */
-#define BMA180_DEF_PMODE	false
-#define BMA180_DEF_BW		20
-#define BMA180_DEF_SCALE	2452
+#define BMA250_RANGE_REG	0x0f
+#define BMA250_BW_REG		0x10
+#define BMA250_POWER_REG	0x11
+#define BMA250_RESET_REG	0x14
+#define BMA250_INT_ENABLE_REG	0x17
+#define BMA250_INT_MAP_REG	0x1a
+#define BMA250_INT_RESET_REG	0x21
+
+#define BMA250_RANGE_MASK	GENMASK(3, 0) /* Range of accel values */
+#define BMA250_BW_MASK		GENMASK(4, 0) /* Accel bandwidth */
+#define BMA250_SUSPEND_MASK	BIT(7) /* chip will sleep */
+#define BMA250_LOWPOWER_MASK	BIT(6)
+#define BMA250_DATA_INTEN_MASK	BIT(4)
+#define BMA250_INT1_DATA_MASK	BIT(0)
+#define BMA250_INT_RESET_MASK	BIT(7) /* Reset pending interrupts */
 
 struct bma180_data {
 	struct i2c_client *client;
@@ -105,6 +130,10 @@ enum bma180_chan {
 static int bma180_bw_table[] = { 10, 20, 40, 75, 150, 300 }; /* Hz */
 static int bma180_scale_table[] = { 1275, 1863, 2452, 3727, 4903, 9709, 19417 };
 
+static int bma250_bw_table[] = { 8, 16, 31, 63, 125, 250 }; /* Hz */
+static int bma250_scale_table[] = { 0, 0, 0, 38344, 0, 76590, 0, 0, 153180, 0,
+	0, 0, 306458 };
+
 static int bma180_get_data_reg(struct bma180_data *data, enum bma180_chan chan)
 {
 	int ret;
@@ -143,7 +172,8 @@ static int bma180_set_bits(struct bma180_data *data, u8 reg, u8 mask, u8 val)
 
 static int bma180_reset_intr(struct bma180_data *data)
 {
-	int ret = bma180_set_bits(data, BMA180_CTRL_REG0, BMA180_RESET_INT, 1);
+	int ret = bma180_set_bits(data, data->part_info->int_reset_reg,
+		data->part_info->int_reset_mask, 1);
 
 	if (ret)
 		dev_err(&data->client->dev, "failed to reset interrupt\n");
@@ -153,10 +183,8 @@ static int bma180_reset_intr(struct bma180_data *data)
 
 static int bma180_set_new_data_intr_state(struct bma180_data *data, bool state)
 {
-	u8 reg_val = state ? BMA180_NEW_DATA_INT : 0x00;
-	int ret = i2c_smbus_write_byte_data(data->client, BMA180_CTRL_REG3,
-			reg_val);
-
+	int ret = bma180_set_bits(data, data->part_info->int_enable_reg,
+			data->part_info->int_enable_mask, state);
 	if (ret)
 		goto err;
 	ret = bma180_reset_intr(data);
@@ -173,7 +201,8 @@ err:
 
 static int bma180_set_sleep_state(struct bma180_data *data, bool state)
 {
-	int ret = bma180_set_bits(data, BMA180_CTRL_REG0, BMA180_SLEEP, state);
+	int ret = bma180_set_bits(data, data->part_info->sleep_reg,
+		data->part_info->sleep_mask, state);
 
 	if (ret) {
 		dev_err(&data->client->dev,
@@ -205,8 +234,8 @@ static int bma180_set_bw(struct bma180_data *data, int val)
 
 	for (i = 0; i < data->part_info->num_bw; ++i) {
 		if (data->part_info->bw_table[i] == val) {
-			ret = bma180_set_bits(data,
-					BMA180_BW_TCS, BMA180_BW, i);
+			ret = bma180_set_bits(data, data->part_info->bw_reg,
+				data->part_info->bw_mask, i);
 			if (ret) {
 				dev_err(&data->client->dev,
 					"failed to set bandwidth\n");
@@ -229,8 +258,8 @@ static int bma180_set_scale(struct bma180_data *data, int val)
 
 	for (i = 0; i < data->part_info->num_scales; ++i)
 		if (data->part_info->scale_table[i] == val) {
-			ret = bma180_set_bits(data,
-					BMA180_OFFSET_LSB1, BMA180_RANGE, i);
+			ret = bma180_set_bits(data, data->part_info->scale_reg,
+				data->part_info->scale_mask, i);
 			if (ret) {
 				dev_err(&data->client->dev,
 					"failed to set scale\n");
@@ -245,9 +274,9 @@ static int bma180_set_scale(struct bma180_data *data, int val)
 
 static int bma180_set_pmode(struct bma180_data *data, bool mode)
 {
-	u8 reg_val = mode ? BMA180_LOW_POWER : BMA180_LOW_NOISE;
-	int ret = bma180_set_bits(data, BMA180_TCO_Z, BMA180_MODE_CONFIG,
-			reg_val);
+	u8 reg_val = mode ? data->part_info->lowpower_val : 0;
+	int ret = bma180_set_bits(data, data->part_info->power_reg,
+		data->part_info->power_mask, reg_val);
 
 	if (ret) {
 		dev_err(&data->client->dev, "failed to set power mode\n");
@@ -261,7 +290,7 @@ static int bma180_set_pmode(struct bma180_data *data, bool mode)
 static int bma180_soft_reset(struct bma180_data *data)
 {
 	int ret = i2c_smbus_write_byte_data(data->client,
-			BMA180_RESET, BMA180_RESET_VAL);
+		data->part_info->softreset_reg, BMA180_RESET_VAL);
 
 	if (ret)
 		dev_err(&data->client->dev, "failed to reset the chip\n");
@@ -288,7 +317,11 @@ static int bma180_chip_init(struct bma180_data *data)
 	 */
 	msleep(20);
 
-	return 0;
+	ret = bma180_set_new_data_intr_state(data, false);
+	if (ret)
+		return ret;
+
+	return bma180_set_pmode(data, false);
 }
 
 static int bma180_chip_config(struct bma180_data *data)
@@ -303,19 +336,37 @@ static int bma180_chip_config(struct bma180_data *data)
 	ret = bma180_set_ee_writing_state(data, true);
 	if (ret)
 		goto err;
-	ret = bma180_set_new_data_intr_state(data, false);
+	ret = bma180_set_bits(data, BMA180_OFFSET_LSB1, BMA180_SMP_SKIP, 1);
 	if (ret)
 		goto err;
-	ret = bma180_set_bits(data, BMA180_OFFSET_LSB1, BMA180_SMP_SKIP, 1);
+	ret = bma180_set_bw(data, 20); /* 20 Hz */
 	if (ret)
 		goto err;
-	ret = bma180_set_pmode(data, BMA180_DEF_PMODE);
+	ret = bma180_set_scale(data, 2452); /* 2 G */
 	if (ret)
 		goto err;
-	ret = bma180_set_bw(data, BMA180_DEF_BW);
+
+	return 0;
+
+err:
+	dev_err(&data->client->dev, "failed to config the chip\n");
+	return ret;
+}
+
+static int bma250_chip_config(struct bma180_data *data)
+{
+	int ret = bma180_chip_init(data);
+
+	if (ret)
+		goto err;
+	ret = bma180_set_bw(data, 16); /* 16 Hz */
+	if (ret)
+		goto err;
+	ret = bma180_set_scale(data, 38344); /* 2 G */
 	if (ret)
 		goto err;
-	ret = bma180_set_scale(data, BMA180_DEF_SCALE);
+	ret = bma180_set_bits(data, BMA250_INT_MAP_REG,
+		BMA250_INT1_DATA_MASK, 1);
 	if (ret)
 		goto err;
 
@@ -341,6 +392,19 @@ err:
 	dev_err(&data->client->dev, "failed to disable the chip\n");
 }
 
+static void bma250_chip_disable(struct bma180_data *data)
+{
+	if (bma180_set_new_data_intr_state(data, false))
+		goto err;
+	if (bma180_set_sleep_state(data, true))
+		goto err;
+
+	return;
+
+err:
+	dev_err(&data->client->dev, "failed to disable the chip\n");
+}
+
 static ssize_t bma180_show_avail(char *buf, const int *vals, unsigned n,
 				 bool micros)
 {
@@ -543,14 +607,43 @@ static const struct iio_chan_spec bma180_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
+static const struct iio_chan_spec bma250_channels[] = {
+	BMA180_ACC_CHANNEL(X, 10),
+	BMA180_ACC_CHANNEL(Y, 10),
+	BMA180_ACC_CHANNEL(Z, 10),
+	BMA180_TEMP_CHANNEL,
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+};
+
 static const struct bma180_part_info bma180_part_info[] = {
 	[BMA180] = {
 		bma180_channels, ARRAY_SIZE(bma180_channels),
 		bma180_scale_table, ARRAY_SIZE(bma180_scale_table),
 		bma180_bw_table, ARRAY_SIZE(bma180_bw_table),
+		BMA180_CTRL_REG0, BMA180_RESET_INT,
+		BMA180_CTRL_REG0, BMA180_SLEEP,
+		BMA180_BW_TCS, BMA180_BW,
+		BMA180_OFFSET_LSB1, BMA180_RANGE,
+		BMA180_TCO_Z, BMA180_MODE_CONFIG, BMA180_LOW_POWER,
+		BMA180_CTRL_REG3, BMA180_NEW_DATA_INT,
+		BMA180_RESET,
 		bma180_chip_config,
 		bma180_chip_disable,
 	},
+	[BMA250] = {
+		bma250_channels, ARRAY_SIZE(bma250_channels),
+		bma250_scale_table, ARRAY_SIZE(bma250_scale_table),
+		bma250_bw_table, ARRAY_SIZE(bma250_bw_table),
+		BMA250_INT_RESET_REG, BMA250_INT_RESET_MASK,
+		BMA250_POWER_REG, BMA250_SUSPEND_MASK,
+		BMA250_BW_REG, BMA250_BW_MASK,
+		BMA250_RANGE_REG, BMA250_RANGE_MASK,
+		BMA250_POWER_REG, BMA250_LOWPOWER_MASK, 1,
+		BMA250_INT_ENABLE_REG, BMA250_DATA_INTEN_MASK,
+		BMA250_RESET_REG,
+		bma250_chip_config,
+		bma250_chip_disable,
+	},
 };
 
 static irqreturn_t bma180_trigger_handler(int irq, void *p)
@@ -626,11 +719,10 @@ static int bma180_probe(struct i2c_client *client,
 		goto err_chip_disable;
 
 	mutex_init(&data->mutex);
-
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->channels = data->part_info->channels;
 	indio_dev->num_channels = data->part_info->num_channels;
-	indio_dev->name = BMA180_DRV_NAME;
+	indio_dev->name = id->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bma180_info;
 
@@ -644,7 +736,7 @@ static int bma180_probe(struct i2c_client *client,
 
 		ret = devm_request_irq(&client->dev, client->irq,
 			iio_trigger_generic_data_rdy_poll, IRQF_TRIGGER_RISING,
-			BMA180_IRQ_NAME, data->trig);
+			"bma180_event", data->trig);
 		if (ret) {
 			dev_err(&client->dev, "unable to request IRQ\n");
 			goto err_trigger_free;
@@ -741,7 +833,8 @@ static SIMPLE_DEV_PM_OPS(bma180_pm_ops, bma180_suspend, bma180_resume);
 #endif
 
 static struct i2c_device_id bma180_ids[] = {
-	{ BMA180_DRV_NAME, BMA180 },
+	{ "bma180", BMA180 },
+	{ "bma250", BMA250 },
 	{ }
 };
 
@@ -749,7 +842,7 @@ MODULE_DEVICE_TABLE(i2c, bma180_id);
 
 static struct i2c_driver bma180_driver = {
 	.driver = {
-		.name	= BMA180_DRV_NAME,
+		.name	= "bma180",
 		.owner	= THIS_MODULE,
 		.pm	= BMA180_PM_OPS,
 	},
@@ -762,5 +855,5 @@ module_i2c_driver(bma180_driver);
 
 MODULE_AUTHOR("Kravchenko Oleksandr <x0199363@ti.com>");
 MODULE_AUTHOR("Texas Instruments, Inc.");
-MODULE_DESCRIPTION("Bosch BMA180 triaxial acceleration sensor");
+MODULE_DESCRIPTION("Bosch BMA180/BMA250 triaxial acceleration sensor");
 MODULE_LICENSE("GPL");
-- 
1.9.1

