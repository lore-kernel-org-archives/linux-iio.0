Return-Path: <tiberiu.a.breana@intel.com>
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v4 1/2] iio: accel: Add buffer mode for Sensortek STK8312
Date: Mon, 22 Jun 2015 12:11:47 +0300
Message-Id: <1434964308-20215-1-git-send-email-tiberiu.a.breana@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Added triggered buffer mode support for the STK8312 accelerometer.

Additional changes:
- set_mode now sets operation mode directly, no longer masking
  the register's previous value
- read_accel now returns raw acceleration data instead of the
  sign_extend32 value
- read_raw will now enable/disable the sensor with each reading

Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
---
v4:
- removed trigger_handler's local buffer, as it was unnecessary
- cleaner approach for mutex_unlock in trigger_handler
v3:
- added a bulk read optimization for reading all channels at once
v2:
- addressed Jonathan's comments
- added the GPIOD_IN flag to devm_gpiod_get_index
---
 drivers/iio/accel/stk8312.c | 293 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 258 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index d211d9f3..b4a6ff7 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -11,16 +11,23 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #define STK8312_REG_XOUT		0x00
 #define STK8312_REG_YOUT		0x01
 #define STK8312_REG_ZOUT		0x02
+#define STK8312_REG_INTSU		0x06
 #define STK8312_REG_MODE		0x07
 #define STK8312_REG_STH			0x13
 #define STK8312_REG_RESET		0x20
@@ -29,14 +36,19 @@
 #define STK8312_REG_OTPDATA		0x3E
 #define STK8312_REG_OTPCTRL		0x3F
 
-#define STK8312_MODE_ACTIVE		1
-#define STK8312_MODE_STANDBY		0
-#define STK8312_MODE_MASK		0x01
+#define STK8312_MODE_ACTIVE		0x01
+#define STK8312_MODE_STANDBY		0x00
+#define STK8312_DREADY_BIT		0x10
+#define STK8312_INT_MODE		0xC0
 #define STK8312_RNG_MASK		0xC0
 #define STK8312_RNG_SHIFT		6
 #define STK8312_READ_RETRIES		16
+#define STK8312_ALL_CHANNEL_MASK	7
+#define STK8312_ALL_CHANNEL_SIZE	3
 
 #define STK8312_DRIVER_NAME		"stk8312"
+#define STK8312_GPIO			"stk8312_gpio"
+#define STK8312_IRQ_NAME		"stk8312_event"
 
 /*
  * The accelerometer has two measurement ranges:
@@ -53,19 +65,27 @@ static const int stk8312_scale_table[][2] = {
 	{0, 461600}, {1, 231100}
 };
 
-#define STK8312_ACCEL_CHANNEL(reg, axis) {			\
+#define STK8312_ACCEL_CHANNEL(index, reg, axis) {		\
 	.type = IIO_ACCEL,					\
 	.address = reg,						\
 	.modified = 1,						\
 	.channel2 = IIO_MOD_##axis,				\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.scan_index = index,					\
+	.scan_type = {						\
+		.sign = 's',					\
+		.realbits = 8,					\
+		.storagebits = 8,				\
+		.endianness = IIO_CPU,				\
+	},							\
 }
 
 static const struct iio_chan_spec stk8312_channels[] = {
-	STK8312_ACCEL_CHANNEL(STK8312_REG_XOUT, X),
-	STK8312_ACCEL_CHANNEL(STK8312_REG_YOUT, Y),
-	STK8312_ACCEL_CHANNEL(STK8312_REG_ZOUT, Z),
+	STK8312_ACCEL_CHANNEL(0, STK8312_REG_XOUT, X),
+	STK8312_ACCEL_CHANNEL(1, STK8312_REG_YOUT, Y),
+	STK8312_ACCEL_CHANNEL(2, STK8312_REG_ZOUT, Z),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
 struct stk8312_data {
@@ -73,6 +93,9 @@ struct stk8312_data {
 	struct mutex lock;
 	int range;
 	u8 mode;
+	struct iio_trigger *dready_trig;
+	bool dready_trigger_on;
+	s8 buffer[16]; /* 3x8-bit channels + 5x8 padding + 64-bit timestamp */
 };
 
 static IIO_CONST_ATTR(in_accel_scale_available, STK8312_SCALE_AVAIL);
@@ -130,31 +153,19 @@ exit_err:
 static int stk8312_set_mode(struct stk8312_data *data, u8 mode)
 {
 	int ret;
-	u8 masked_reg;
 	struct i2c_client *client = data->client;
 
-	if (mode > 1)
-		return -EINVAL;
-	else if (mode == data->mode)
+	if (mode == data->mode)
 		return 0;
 
-	ret = i2c_smbus_read_byte_data(client, STK8312_REG_MODE);
-	if (ret < 0) {
-		dev_err(&client->dev, "failed to change sensor mode\n");
-		return ret;
-	}
-	masked_reg = ret & (~STK8312_MODE_MASK);
-	masked_reg |= mode;
-
-	ret = i2c_smbus_write_byte_data(client,
-			STK8312_REG_MODE, masked_reg);
+	ret = i2c_smbus_write_byte_data(client, STK8312_REG_MODE, mode);
 	if (ret < 0) {
 		dev_err(&client->dev, "failed to change sensor mode\n");
 		return ret;
 	}
 
 	data->mode = mode;
-	if (mode == STK8312_MODE_ACTIVE) {
+	if (mode & STK8312_MODE_ACTIVE) {
 		/* Need to run OTP sequence before entering active mode */
 		usleep_range(1000, 5000);
 		ret = stk8312_otp_init(data);
@@ -163,6 +174,52 @@ static int stk8312_set_mode(struct stk8312_data *data, u8 mode)
 	return ret;
 }
 
+static int stk8312_set_interrupts(struct stk8312_data *data, u8 int_mask)
+{
+	int ret;
+	u8 mode;
+	struct i2c_client *client = data->client;
+
+	mode = data->mode;
+	/* We need to go in standby mode to modify registers */
+	ret = stk8312_set_mode(data, STK8312_MODE_STANDBY);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, STK8312_REG_INTSU, int_mask);
+	if (ret < 0)
+		dev_err(&client->dev, "failed to set interrupts\n");
+
+	return stk8312_set_mode(data, mode);
+}
+
+static int stk8312_data_rdy_trigger_set_state(struct iio_trigger *trig,
+					      bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct stk8312_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (state)
+		ret = stk8312_set_interrupts(data, STK8312_DREADY_BIT);
+	else
+		ret = stk8312_set_interrupts(data, 0x00);
+
+	if (ret < 0) {
+		dev_err(&data->client->dev, "failed to set trigger state\n");
+		return ret;
+	}
+
+	data->dready_trigger_on = state;
+
+	return ret;
+}
+
+static const struct iio_trigger_ops stk8312_trigger_ops = {
+	.set_trigger_state = stk8312_data_rdy_trigger_set_state,
+	.owner = THIS_MODULE,
+};
+
 static int stk8312_set_range(struct stk8312_data *data, u8 range)
 {
 	int ret;
@@ -208,12 +265,10 @@ static int stk8312_read_accel(struct stk8312_data *data, u8 address)
 		return -EINVAL;
 
 	ret = i2c_smbus_read_byte_data(client, address);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(&client->dev, "register read failed\n");
-		return ret;
-	}
 
-	return sign_extend32(ret, 7);
+	return ret;
 }
 
 static int stk8312_read_raw(struct iio_dev *indio_dev,
@@ -221,14 +276,27 @@ static int stk8312_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct stk8312_data *data = iio_priv(indio_dev);
-
-	if (chan->type != IIO_ACCEL)
-		return -EINVAL;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		if (iio_buffer_enabled(indio_dev))
+			return -EBUSY;
 		mutex_lock(&data->lock);
-		*val = stk8312_read_accel(data, chan->address);
+		ret = stk8312_set_mode(data, data->mode | STK8312_MODE_ACTIVE);
+		if (ret < 0) {
+			mutex_unlock(&data->lock);
+			return -EINVAL;
+		}
+		ret = stk8312_read_accel(data, chan->address);
+		if (ret < 0) {
+			stk8312_set_mode(data,
+					 data->mode & (~STK8312_MODE_ACTIVE));
+			mutex_unlock(&data->lock);
+			return -EINVAL;
+		}
+		*val = sign_extend32(ret, 7);
+		stk8312_set_mode(data, data->mode & (~STK8312_MODE_ACTIVE));
 		mutex_unlock(&data->lock);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
@@ -277,6 +345,101 @@ static const struct iio_info stk8312_info = {
 	.attrs			= &stk8312_attribute_group,
 };
 
+static irqreturn_t stk8312_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct stk8312_data *data = iio_priv(indio_dev);
+	int bit, ret, i = 0;
+
+	mutex_lock(&data->lock);
+	/*
+	 * Do a bulk read if all channels are requested,
+	 * from 0x00 (XOUT) to 0x02 (ZOUT)
+	 */
+	if (*(indio_dev->active_scan_mask) == STK8312_ALL_CHANNEL_MASK) {
+		ret = i2c_smbus_read_i2c_block_data(data->client,
+						    STK8312_REG_XOUT,
+						    STK8312_ALL_CHANNEL_SIZE,
+						    data->buffer);
+		if (ret < STK8312_ALL_CHANNEL_SIZE) {
+			dev_err(&data->client->dev, "register read failed\n");
+			goto err;
+		}
+	} else {
+		for_each_set_bit(bit, indio_dev->active_scan_mask,
+			   indio_dev->masklength) {
+			ret = stk8312_read_accel(data, bit);
+			if (ret < 0)
+				goto err;
+			data->buffer[i++] = ret;
+		}
+	}
+	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+					   pf->timestamp);
+err:
+	mutex_unlock(&data->lock);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t stk8312_data_rdy_trig_poll(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct stk8312_data *data = iio_priv(indio_dev);
+
+	if (data->dready_trigger_on)
+		iio_trigger_poll(data->dready_trig);
+
+	return IRQ_HANDLED;
+}
+
+static int stk8312_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct stk8312_data *data = iio_priv(indio_dev);
+
+	return stk8312_set_mode(data, data->mode | STK8312_MODE_ACTIVE);
+}
+
+static int stk8312_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct stk8312_data *data = iio_priv(indio_dev);
+
+	return stk8312_set_mode(data, data->mode & (~STK8312_MODE_ACTIVE));
+}
+
+static const struct iio_buffer_setup_ops stk8312_buffer_setup_ops = {
+	.preenable   = stk8312_buffer_preenable,
+	.postenable  = iio_triggered_buffer_postenable,
+	.predisable  = iio_triggered_buffer_predisable,
+	.postdisable = stk8312_buffer_postdisable,
+};
+
+static int stk8312_gpio_probe(struct i2c_client *client)
+{
+	struct device *dev;
+	struct gpio_desc *gpio;
+	int ret;
+
+	if (!client)
+		return -EINVAL;
+
+	dev = &client->dev;
+
+	/* data ready gpio interrupt pin */
+	gpio = devm_gpiod_get_index(dev, STK8312_GPIO, 0, GPIOD_IN);
+	if (IS_ERR(gpio)) {
+		dev_err(dev, "acpi gpio get index failed\n");
+		return PTR_ERR(gpio);
+	}
+
+	ret = gpiod_to_irq(gpio);
+	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
+
+	return ret;
+}
+
 static int stk8312_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -312,26 +475,86 @@ static int stk8312_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	ret = stk8312_set_mode(data, STK8312_MODE_ACTIVE);
+	ret = stk8312_set_mode(data, STK8312_INT_MODE | STK8312_MODE_ACTIVE);
 	if (ret < 0)
 		return ret;
 
+	if (client->irq < 0)
+		client->irq = stk8312_gpio_probe(client);
+
+	if (client->irq >= 0) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						stk8312_data_rdy_trig_poll,
+						NULL,
+						IRQF_TRIGGER_RISING |
+						IRQF_ONESHOT,
+						STK8312_IRQ_NAME,
+						indio_dev);
+		if (ret < 0) {
+			dev_err(&client->dev, "request irq %d failed\n",
+				client->irq);
+			goto err_power_off;
+		}
+
+		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
+							   "%s-dev%d",
+							   indio_dev->name,
+							   indio_dev->id);
+		if (!data->dready_trig) {
+			ret = -ENOMEM;
+			goto err_power_off;
+		}
+
+		data->dready_trig->dev.parent = &client->dev;
+		data->dready_trig->ops = &stk8312_trigger_ops;
+		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
+		ret = iio_trigger_register(data->dready_trig);
+		if (ret) {
+			dev_err(&client->dev, "iio trigger register failed\n");
+			goto err_power_off;
+		}
+	}
+
+	ret = iio_triggered_buffer_setup(indio_dev,
+					 iio_pollfunc_store_time,
+					 stk8312_trigger_handler,
+					 &stk8312_buffer_setup_ops);
+	if (ret < 0) {
+		dev_err(&client->dev, "iio triggered buffer setup failed\n");
+		goto err_trigger_unregister;
+	}
+
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev, "device_register failed\n");
-		stk8312_set_mode(data, STK8312_MODE_STANDBY);
+		goto err_buffer_cleanup;
 	}
 
 	return ret;
+
+err_buffer_cleanup:
+	iio_triggered_buffer_cleanup(indio_dev);
+err_trigger_unregister:
+	if (data->dready_trig)
+		iio_trigger_unregister(data->dready_trig);
+err_power_off:
+	stk8312_set_mode(data, STK8312_MODE_STANDBY);
+	return ret;
 }
 
 static int stk8312_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct stk8312_data *data = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 
-	return stk8312_set_mode(iio_priv(indio_dev), STK8312_MODE_STANDBY);
+	if (data->dready_trig) {
+		iio_triggered_buffer_cleanup(indio_dev);
+		iio_trigger_unregister(data->dready_trig);
+	}
+
+	return stk8312_set_mode(data, STK8312_MODE_STANDBY);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -341,7 +564,7 @@ static int stk8312_suspend(struct device *dev)
 
 	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
 
-	return stk8312_set_mode(data, STK8312_MODE_STANDBY);
+	return stk8312_set_mode(data, data->mode & (~STK8312_MODE_ACTIVE));
 }
 
 static int stk8312_resume(struct device *dev)
@@ -350,7 +573,7 @@ static int stk8312_resume(struct device *dev)
 
 	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
 
-	return stk8312_set_mode(data, STK8312_MODE_ACTIVE);
+	return stk8312_set_mode(data, data->mode | STK8312_MODE_ACTIVE);
 }
 
 static SIMPLE_DEV_PM_OPS(stk8312_pm_ops, stk8312_suspend, stk8312_resume);
-- 
1.9.1
