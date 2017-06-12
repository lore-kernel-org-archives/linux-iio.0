Return-Path: <SRS0=facI=5R=gmail.com=akinobu.mita@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/2] iio: light: tcs3472: support out-of-threshold events
Date: Tue, 13 Jun 2017 00:05:09 +0900
Message-Id: <1497279909-11197-3-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1497279909-11197-1-git-send-email-akinobu.mita@gmail.com>
References: <1497279909-11197-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The TCS3472 device provides interrupt signal for out-of-threshold events
with persistence filter.

This change adds interrupt support for the threshold events and enables
to configure the period of time by persistence filter.

Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/light/tcs3472.c | 269 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 261 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index a9e153b..905e777 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -11,7 +11,9 @@
  * 7-bit I2C slave address 0x39 (TCS34721, TCS34723) or 0x29 (TCS34725,
  * TCS34727)
  *
- * TODO: interrupt support, thresholds, wait time
+ * Datasheet: http://ams.com/eng/content/download/319364/1117183/file/TCS3472_Datasheet_EN_v2.pdf
+ *
+ * TODO: wait time
  */
 
 #include <linux/module.h>
@@ -21,6 +23,7 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/triggered_buffer.h>
@@ -29,12 +32,15 @@
 
 #define TCS3472_COMMAND BIT(7)
 #define TCS3472_AUTO_INCR BIT(5)
+#define TCS3472_SPECIAL_FUNC (BIT(5) | BIT(6))
+
+#define TCS3472_INTR_CLEAR (TCS3472_COMMAND | TCS3472_SPECIAL_FUNC | 0x6)
 
 #define TCS3472_ENABLE (TCS3472_COMMAND | 0x00)
 #define TCS3472_ATIME (TCS3472_COMMAND | 0x01)
 #define TCS3472_WTIME (TCS3472_COMMAND | 0x03)
-#define TCS3472_AILT (TCS3472_COMMAND | 0x04)
-#define TCS3472_AIHT (TCS3472_COMMAND | 0x06)
+#define TCS3472_AILT (TCS3472_COMMAND | TCS3472_AUTO_INCR | 0x04)
+#define TCS3472_AIHT (TCS3472_COMMAND | TCS3472_AUTO_INCR | 0x06)
 #define TCS3472_PERS (TCS3472_COMMAND | 0x0c)
 #define TCS3472_CONFIG (TCS3472_COMMAND | 0x0d)
 #define TCS3472_CONTROL (TCS3472_COMMAND | 0x0f)
@@ -45,19 +51,42 @@
 #define TCS3472_GDATA (TCS3472_COMMAND | TCS3472_AUTO_INCR | 0x18)
 #define TCS3472_BDATA (TCS3472_COMMAND | TCS3472_AUTO_INCR | 0x1a)
 
+#define TCS3472_STATUS_AINT BIT(4)
 #define TCS3472_STATUS_AVALID BIT(0)
+#define TCS3472_ENABLE_AIEN BIT(4)
 #define TCS3472_ENABLE_AEN BIT(1)
 #define TCS3472_ENABLE_PON BIT(0)
 #define TCS3472_CONTROL_AGAIN_MASK (BIT(0) | BIT(1))
 
 struct tcs3472_data {
 	struct i2c_client *client;
+	struct mutex lock;
+	u16 low_thresh;
+	u16 high_thresh;
 	u8 enable;
 	u8 control;
 	u8 atime;
+	u8 apers;
 	u16 buffer[8]; /* 4 16-bit channels + 64-bit timestamp */
 };
 
+static const struct iio_event_spec tcs3472_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				 BIT(IIO_EV_INFO_PERIOD),
+	},
+};
+
 #define TCS3472_CHANNEL(_color, _si, _addr) { \
 	.type = IIO_INTENSITY, \
 	.modified = 1, \
@@ -73,6 +102,8 @@ struct tcs3472_data {
 		.storagebits = 16, \
 		.endianness = IIO_CPU, \
 	}, \
+	.event_spec = _si ? NULL : tcs3472_events, \
+	.num_event_specs = _si ? 0 : ARRAY_SIZE(tcs3472_events), \
 }
 
 static const int tcs3472_agains[] = { 1, 4, 16, 60 };
@@ -180,6 +211,166 @@ static int tcs3472_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+/*
+ * Translation from APERS field value to the number of consecutive out-of-range
+ * Clear occurrences before an interrupt is generated
+ */
+static const int tcs3472_intr_pers[] = {
+	0, 1, 2, 3, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60
+};
+
+static int tcs3472_read_event(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, enum iio_event_info info, int *val,
+	int *val2)
+{
+	struct tcs3472_data *data = iio_priv(indio_dev);
+	int ret;
+	unsigned int period;
+
+	mutex_lock(&data->lock);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		*val = (dir == IIO_EV_DIR_RISING) ?
+			data->high_thresh : data->low_thresh;
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_EV_INFO_PERIOD:
+		period = (256 - data->atime) * 2400 *
+			tcs3472_intr_pers[data->apers];
+		*val = period / USEC_PER_SEC;
+		*val2 = period % USEC_PER_SEC;
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int tcs3472_write_event(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, enum iio_event_info info, int val,
+	int val2)
+{
+	struct tcs3472_data *data = iio_priv(indio_dev);
+	int ret;
+	u8 command;
+	unsigned int period;
+	int i;
+
+	mutex_lock(&data->lock);
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			command = TCS3472_AIHT;
+			break;
+		case IIO_EV_DIR_FALLING:
+			command = TCS3472_AILT;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+		ret = i2c_smbus_write_word_data(data->client, command, val);
+		if (ret)
+			goto error;
+
+		if (dir == IIO_EV_DIR_RISING)
+			data->high_thresh = val;
+		else
+			data->low_thresh = val;
+		break;
+	case IIO_EV_INFO_PERIOD:
+		period = val * USEC_PER_SEC + val2;
+		for (i = 1; i < ARRAY_SIZE(tcs3472_intr_pers) - 1; i++) {
+			if (period <= (256 - data->atime) * 2400 *
+					tcs3472_intr_pers[i])
+				break;
+		}
+		ret = i2c_smbus_write_byte_data(data->client, TCS3472_PERS, i);
+		if (ret)
+			goto error;
+
+		data->apers = i;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+error:
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int tcs3472_read_event_config(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir)
+{
+	struct tcs3472_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = !!(data->enable & TCS3472_ENABLE_AIEN);
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int tcs3472_write_event_config(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, int state)
+{
+	struct tcs3472_data *data = iio_priv(indio_dev);
+	int ret = 0;
+	u8 enable_old;
+
+	mutex_lock(&data->lock);
+
+	enable_old = data->enable;
+
+	if (state)
+		data->enable |= TCS3472_ENABLE_AIEN;
+	else
+		data->enable &= ~TCS3472_ENABLE_AIEN;
+
+	if (enable_old != data->enable) {
+		ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
+						data->enable);
+		if (ret)
+			data->enable = enable_old;
+	}
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static irqreturn_t tcs3472_event_handler(int irq, void *priv)
+{
+	struct iio_dev *indio_dev = priv;
+	struct tcs3472_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, TCS3472_STATUS);
+	if (ret >= 0 && (ret & TCS3472_STATUS_AINT)) {
+		iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, 0,
+						IIO_EV_TYPE_THRESH,
+						IIO_EV_DIR_EITHER),
+				iio_get_time_ns(indio_dev));
+
+		i2c_smbus_read_byte_data(data->client, TCS3472_INTR_CLEAR);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t tcs3472_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -243,6 +434,10 @@ static const struct attribute_group tcs3472_attribute_group = {
 static const struct iio_info tcs3472_info = {
 	.read_raw = tcs3472_read_raw,
 	.write_raw = tcs3472_write_raw,
+	.read_event_value = tcs3472_read_event,
+	.write_event_value = tcs3472_write_event,
+	.read_event_config = tcs3472_read_event_config,
+	.write_event_config = tcs3472_write_event_config,
 	.attrs = &tcs3472_attribute_group,
 	.driver_module = THIS_MODULE,
 };
@@ -261,6 +456,7 @@ static int tcs3472_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
+	mutex_init(&data->lock);
 
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &tcs3472_info;
@@ -290,12 +486,29 @@ static int tcs3472_probe(struct i2c_client *client,
 		return ret;
 	data->atime = ret;
 
+	ret = i2c_smbus_read_word_data(data->client, TCS3472_AILT);
+	if (ret < 0)
+		return ret;
+	data->low_thresh = ret;
+
+	ret = i2c_smbus_read_word_data(data->client, TCS3472_AIHT);
+	if (ret < 0)
+		return ret;
+	data->high_thresh = ret;
+
+	data->apers = 1;
+	ret = i2c_smbus_write_byte_data(data->client, TCS3472_PERS,
+					data->apers);
+	if (ret < 0)
+		return ret;
+
 	ret = i2c_smbus_read_byte_data(data->client, TCS3472_ENABLE);
 	if (ret < 0)
 		return ret;
 
 	/* enable device */
 	data->enable = ret | TCS3472_ENABLE_PON | TCS3472_ENABLE_AEN;
+	data->enable &= ~TCS3472_ENABLE_AIEN;
 	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
 		data->enable);
 	if (ret < 0)
@@ -306,12 +519,29 @@ static int tcs3472_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
+	if (client->irq) {
+		ret = i2c_smbus_write_byte_data(data->client, TCS3472_PERS,
+						data->apers);
+		if (ret)
+			goto buffer_cleanup;
+
+		ret = request_threaded_irq(client->irq, NULL,
+					   tcs3472_event_handler,
+					   IRQF_TRIGGER_FALLING | IRQF_SHARED |
+					   IRQF_ONESHOT,
+					   client->name, indio_dev);
+		if (ret)
+			goto buffer_cleanup;
+	}
+
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
-		goto buffer_cleanup;
+		goto free_irq;
 
 	return 0;
 
+free_irq:
+	free_irq(client->irq, indio_dev);
 buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
 	return ret;
@@ -319,14 +549,26 @@ static int tcs3472_probe(struct i2c_client *client,
 
 static int tcs3472_powerdown(struct tcs3472_data *data)
 {
-	return i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
-		data->enable & ~(TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON));
+	int ret;
+	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
+
+	mutex_lock(&data->lock);
+
+	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
+		data->enable & ~enable_mask);
+	if (!ret)
+		data->enable &= ~enable_mask;
+
+	mutex_unlock(&data->lock);
+
+	return ret;
 }
 
 static int tcs3472_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
+	free_irq(client->irq, indio_dev);
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 	tcs3472_powerdown(iio_priv(indio_dev));
@@ -346,8 +588,19 @@ static int tcs3472_resume(struct device *dev)
 {
 	struct tcs3472_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
-	return i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
-		data->enable | (TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON));
+	int ret;
+	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
+
+	mutex_lock(&data->lock);
+
+	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
+		data->enable | enable_mask);
+	if (!ret)
+		data->enable |= enable_mask;
+
+	mutex_unlock(&data->lock);
+
+	return ret;
 }
 #endif
 
-- 
2.7.4
