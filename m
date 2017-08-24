Return-Path: <SRS0=Yn0x=72=gmail.com=narcisaanamaria12@kernel.org>
From: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	daniel.baluta@gmail.com,
	amsfield22@gmail.com
Cc: linux-iio@vger.kernel.org,
	Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Subject: [PATCH v2] iio: chemical: ccs811: Add support for data ready trigger
Date: Thu, 24 Aug 2017 19:14:42 +0300
Message-Id: <1503591282-22321-1-git-send-email-narcisaanamaria12@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add data ready trigger for hardware interrupts that signal
new, available measurement samples.

Cc: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Alison Schofield <amsfield22@gmail.com>
Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
---
Changes in v2:
    - Define top half handler for interrupts which calls iio_trigger_poll
    - Remove bottom half interrupt handler
    - Add bool variable to store the state of the data ready trigger
    - Remove threshold related macros and checks, as driver doesn't support
      threshold interrupts yet
    - Protect direct/buffered modes, by claiming direct mode in raw readings.
      Reading the data from ALG_RESULT_DATA will clear the data ready bit and
      will stop the nINT signal from being driven low. Therefore, disallow
      raw readings while hardware interrupts are active.
    - Rephrase commit message
Note:
    It may not be necessary to protect direct mode when performing raw readings,
    in that the data read may not be corrupted, but raw readings may "clear" the
    interrupt(clear the data-ready bit and nINT signal) before the handler deals
    with the interrupt, which doesn't seem like expected/acceptable behaviour.
    Thoughts on this?

 drivers/iio/chemical/ccs811.c | 87 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index b59994d..c8ca1b9 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -23,6 +23,7 @@
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/module.h>
@@ -60,8 +61,12 @@
 #define CCS811_MODE_IAQ_60SEC	0x30
 #define CCS811_MODE_RAW_DATA	0x40

+#define CCS811_MEAS_MODE_INTERRUPT	BIT(3)
+
 #define CCS811_VOLTAGE_MASK	0x3FF

+#define CCS811_IRQ_NAME "ccs811_irq"
+
 struct ccs811_reading {
 	__be16 co2;
 	__be16 voc;
@@ -74,6 +79,8 @@ struct ccs811_data {
 	struct i2c_client *client;
 	struct mutex lock; /* Protect readings */
 	struct ccs811_reading buffer;
+	struct iio_trigger *drdy_trig;
+	bool drdy_trig_on;
 };

 static const struct iio_chan_spec ccs811_channels[] = {
@@ -194,10 +201,14 @@ static int ccs811_read_raw(struct iio_dev *indio_dev,

 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
 		mutex_lock(&data->lock);
 		ret = ccs811_get_measurement(data);
 		if (ret < 0) {
 			mutex_unlock(&data->lock);
+			iio_device_release_direct_mode(indio_dev);
 			return ret;
 		}

@@ -229,6 +240,7 @@ static int ccs811_read_raw(struct iio_dev *indio_dev,
 			ret = -EINVAL;
 		}
 		mutex_unlock(&data->lock);
+		iio_device_release_direct_mode(indio_dev);

 		return ret;

@@ -274,6 +286,32 @@ static int ccs811_read_raw(struct iio_dev *indio_dev,
 	.driver_module = THIS_MODULE,
 };

+static int ccs811_set_trigger_state(struct iio_trigger *trig,
+				    bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct ccs811_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, CCS811_MEAS_MODE);
+	if (ret < 0)
+		return ret;
+
+	if (state)
+		ret |= CCS811_MEAS_MODE_INTERRUPT;
+	else
+		ret &= ~CCS811_MEAS_MODE_INTERRUPT;
+
+	data->drdy_trig_on = state;
+
+	return i2c_smbus_write_byte_data(data->client, CCS811_MEAS_MODE, ret);
+}
+
+static const struct iio_trigger_ops ccs811_trigger_ops = {
+	.set_trigger_state = ccs811_set_trigger_state,
+	.owner = THIS_MODULE,
+};
+
 static irqreturn_t ccs811_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -299,6 +337,17 @@ static irqreturn_t ccs811_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }

+static irqreturn_t ccs811_data_rdy_trigger_poll(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct ccs811_data *data = iio_priv(indio_dev);
+
+	if (data->drdy_trig_on)
+		iio_trigger_poll(data->drdy_trig);
+
+	return IRQ_HANDLED;
+}
+
 static int ccs811_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -347,16 +396,48 @@ static int ccs811_probe(struct i2c_client *client,
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->name = id->name;
 	indio_dev->info = &ccs811_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;

 	indio_dev->channels = ccs811_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ccs811_channels);

+	if (client->irq > 0) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						ccs811_data_rdy_trigger_poll,
+						NULL,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						CCS811_IRQ_NAME, indio_dev);
+		if (ret) {
+			dev_err(&client->dev, "irq request error %d\n", -ret);
+			goto err_poweroff;
+		}
+
+		data->drdy_trig = devm_iio_trigger_alloc(&client->dev,
+							 "%s-dev%d",
+							 indio_dev->name,
+							 indio_dev->id);
+		if (!data->drdy_trig) {
+			ret = -ENOMEM;
+			goto err_poweroff;
+		}
+
+		data->drdy_trig->dev.parent = &client->dev;
+		data->drdy_trig->ops = &ccs811_trigger_ops;
+		iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
+		indio_dev->trig = data->drdy_trig;
+		iio_trigger_get(indio_dev->trig);
+		ret = iio_trigger_register(data->drdy_trig);
+		if (ret)
+			goto err_poweroff;
+	}
+
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 					 ccs811_trigger_handler, NULL);

 	if (ret < 0) {
 		dev_err(&client->dev, "triggered buffer setup failed\n");
-		goto err_poweroff;
+		goto err_trigger_unregister;
 	}

 	ret = iio_device_register(indio_dev);
@@ -368,6 +449,8 @@ static int ccs811_probe(struct i2c_client *client,

 err_buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
+err_trigger_unregister:
+	iio_trigger_unregister(data->drdy_trig);
 err_poweroff:
 	i2c_smbus_write_byte_data(client, CCS811_MEAS_MODE, CCS811_MODE_IDLE);

@@ -377,9 +460,11 @@ static int ccs811_probe(struct i2c_client *client,
 static int ccs811_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ccs811_data *data = iio_priv(indio_dev);

 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
+	iio_trigger_unregister(data->drdy_trig);

 	return i2c_smbus_write_byte_data(client, CCS811_MEAS_MODE,
 					 CCS811_MODE_IDLE);
--
1.9.1
