Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35546 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbdCMLMQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 07:12:16 -0400
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmitry.torokhov@gmail.com, michael.hennerich@analog.com,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        florian.vaussard@heig-vd.ch, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH 4/4] iio: accel: adxl345: Add support for triggered buffer
Date: Mon, 13 Mar 2017 19:11:37 +0800
Message-Id: <1489403497-27849-5-git-send-email-eraretuya@gmail.com>
In-Reply-To: <1489403497-27849-1-git-send-email-eraretuya@gmail.com>
References: <1489403497-27849-1-git-send-email-eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Provide an all-axes read for triggered buffering.

Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
 drivers/iio/accel/Kconfig        |   2 +
 drivers/iio/accel/adxl345_core.c | 124 +++++++++++++++++++++++++++++++++++----
 drivers/iio/accel/adxl345_i2c.c  |   4 ++
 3 files changed, 119 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 15de262..45092da 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -7,6 +7,8 @@ menu "Accelerometers"
 
 config ADXL345
 	tristate
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 
 config ADXL345_I2C
 	tristate "Analog Devices ADXL345 3-Axis Digital Accelerometer I2C Driver"
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 4b7055c..5df1e73 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -13,8 +13,11 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #include "adxl345.h"
 
@@ -54,11 +57,20 @@
  */
 static const int adxl345_uscale = 38300;
 
+enum adxl345_scan_index {
+	ADXL345_IDX_X,
+	ADXL345_IDX_Y,
+	ADXL345_IDX_Z,
+	ADXL345_IDX_TSTAMP,
+};
+
 struct adxl345_data {
 	struct iio_trigger *drdy_trig;
 	struct regmap *regmap;
+	struct mutex lock; /* protect this data structure */
 	bool drdy_trig_on;
 	u8 data_range;
+	s16 buffer[8]; /* 3 x 16-bit channels + padding + 64-bit timestamp */
 };
 
 static int adxl345_set_mode(struct adxl345_data *data, u8 mode)
@@ -75,12 +87,12 @@ static int adxl345_set_mode(struct adxl345_data *data, u8 mode)
 	return 0;
 }
 
-static int adxl345_get_triple(struct adxl345_data *data, void *buf)
+static int adxl345_get_triple(struct adxl345_data *data)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, ADXL345_REG_DATAX0, buf,
+	ret = regmap_bulk_read(data->regmap, ADXL345_REG_DATAX0, data->buffer,
 			       sizeof(__le16) * 3);
 	if (ret < 0) {
 		dev_err(dev, "Failed to read the data registers, %d\n", ret);
@@ -120,12 +132,25 @@ static int adxl345_drdy(struct adxl345_data *data)
 	.address = reg,							\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = ADXL345_IDX_##axis,				\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 13,						\
+		.storagebits = 16,					\
+		.endianness = IIO_LE,					\
+	},								\
 }
 
 static const struct iio_chan_spec adxl345_channels[] = {
 	ADXL345_CHANNEL(ADXL345_REG_DATAX0, X),
 	ADXL345_CHANNEL(ADXL345_REG_DATAY0, Y),
 	ADXL345_CHANNEL(ADXL345_REG_DATAZ0, Z),
+	IIO_CHAN_SOFT_TIMESTAMP(ADXL345_IDX_TSTAMP),
+};
+
+static const unsigned long adxl345_scan_masks[] = {
+	BIT(ADXL345_IDX_X) | BIT(ADXL345_IDX_Y) | BIT(ADXL345_IDX_Z),
+	0
 };
 
 static int adxl345_read_raw(struct iio_dev *indio_dev,
@@ -133,31 +158,44 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct adxl345_data *data = iio_priv(indio_dev);
-	s16 regval[3];
 	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		mutex_lock(&data->lock);
 		ret = adxl345_set_mode(data, ADXL345_POWER_CTL_MEASURE);
-		if (ret < 0)
+		if (ret < 0) {
+			mutex_unlock(&data->lock);
 			return ret;
+		}
 		ret = adxl345_drdy(data);
-		if (ret < 0)
+		if (ret < 0) {
+			adxl345_set_mode(data, ADXL345_POWER_CTL_STANDBY);
+			mutex_unlock(&data->lock);
 			return ret;
+		}
 
-		ret = adxl345_get_triple(data, &regval);
-		if (ret < 0)
+		ret = adxl345_get_triple(data);
+		mutex_unlock(&data->lock);
+		iio_device_release_direct_mode(indio_dev);
+		if (ret < 0) {
+			adxl345_set_mode(data, ADXL345_POWER_CTL_STANDBY);
 			return ret;
+		}
 
 		switch (chan->address) {
 		case ADXL345_REG_DATAX0:
-			*val = regval[0];
+			*val = data->buffer[ADXL345_IDX_X];
 			break;
 		case ADXL345_REG_DATAY0:
-			*val = regval[1];
+			*val = data->buffer[ADXL345_IDX_Y];
 			break;
 		case ADXL345_REG_DATAZ0:
-			*val = regval[2];
+			*val = data->buffer[ADXL345_IDX_Z];
 			break;
 		default:
 			return -EINVAL;
@@ -194,6 +232,56 @@ static irqreturn_t adxl345_irq(int irq, void *p)
 	return ret;
 }
 
+static irqreturn_t adxl345_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adxl345_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = adxl345_get_triple(data);
+	mutex_unlock(&data->lock);
+	if (ret < 0)
+		goto error;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+					   pf->timestamp);
+error:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int adxl345_triggered_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct adxl345_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = iio_triggered_buffer_postenable(indio_dev);
+	if (ret)
+		return ret;
+
+	return adxl345_set_mode(data, ADXL345_POWER_CTL_MEASURE);
+}
+
+static int adxl345_triggered_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct adxl345_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = adxl345_set_mode(data, ADXL345_POWER_CTL_STANDBY);
+	if (ret)
+		return ret;
+
+	return iio_triggered_buffer_predisable(indio_dev);
+}
+
+static const struct iio_buffer_setup_ops adxl345_buffer_setup_ops = {
+	.postenable = adxl345_triggered_buffer_postenable,
+	.predisable = adxl345_triggered_buffer_predisable,
+};
+
 static int adxl345_drdy_trigger_set_state(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
@@ -278,12 +366,15 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap, int irq,
 		return ret;
 	}
 
+	mutex_init(&data->lock);
+
 	indio_dev->dev.parent = dev;
 	indio_dev->name = name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl345_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
+	indio_dev->available_scan_masks = adxl345_scan_masks;
 
 	if (irq > 0) {
 		ret =
@@ -312,14 +403,24 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap, int irq,
 		}
 	}
 
+	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
+					 adxl345_trigger_handler,
+					 &adxl345_buffer_setup_ops);
+	if (ret < 0) {
+		dev_err(dev, "iio_triggered_buffer_setup failed: %d\n", ret);
+		goto err_trigger_unregister;
+	}
+
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(dev, "iio_device_register failed: %d\n", ret);
-		goto err_trigger_unregister;
+		goto err_buffer_cleanup;
 	}
 
 	return ret;
 
+err_buffer_cleanup:
+	iio_triggered_buffer_cleanup(indio_dev);
 err_trigger_unregister:
 	if (data->drdy_trig)
 		iio_trigger_unregister(data->drdy_trig);
@@ -334,6 +435,7 @@ int adxl345_core_remove(struct device *dev)
 	struct adxl345_data *data = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
 	if (data->drdy_trig)
 		iio_trigger_unregister(data->drdy_trig);
 
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index 8c791b8..1e0f071 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -30,6 +30,10 @@ static int adxl345_i2c_probe(struct i2c_client *client,
 	bool use_int2 = false;
 	int irq;
 
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_I2C_BLOCK))
+		return -EOPNOTSUPP;
+
 	regmap = devm_regmap_init_i2c(client, &adxl345_i2c_regmap_config);
 	if (IS_ERR(regmap)) {
 		dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
-- 
2.7.4

