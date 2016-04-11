Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25576 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932280AbcDKOZE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 11 Apr 2016 10:25:04 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH v3 2/2] ti-adc081c: Initial triggered buffer support
Date: Mon, 11 Apr 2016 17:24:27 +0300
Message-Id: <0031e3eb1f3a5bb4a29a201698cc6a6ba75dc7ec.1460384543.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1460384543.git.leonard.crestez@intel.com>
References: <cover.1460384543.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1460384543.git.leonard.crestez@intel.com>
References: <cover.1460384543.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Using this requires software triggers like CONFIG_IIO_HRTIMER_TRIGGER.

The device can be configured to do internal periodic sampling but does not
offer some sort of interrupt on data ready. Interrupts can only trigger when
values get out of a specific range.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/iio/adc/ti-adc081c.c | 77 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index b977340..9fd032d 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -24,6 +24,9 @@
 #include <linux/of.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 #include <linux/regulator/consumer.h>
 
 struct adc081c {
@@ -69,21 +72,42 @@ static int adc081c_read_raw(struct iio_dev *iio,
 	return -EINVAL;
 }
 
-static const struct iio_chan_spec adc081c_channel = {
-	.type = IIO_VOLTAGE,
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-};
+#define ADCxx1C_CHAN(_bits) {					\
+	.type = IIO_VOLTAGE,					\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = (_bits),				\
+		.storagebits = 16,				\
+		.shift = 12 - (_bits),				\
+		.endianness = IIO_CPU,				\
+	},							\
+}
+
+#define DEFINE_ADCxx1C_CHANNELS(_name, _bits)				\
+	static const struct iio_chan_spec _name ## _channels[] = {	\
+		ADCxx1C_CHAN((_bits)),					\
+		IIO_CHAN_SOFT_TIMESTAMP(1),				\
+	};								\
+
+#define ADC081C_NUM_CHANNELS 2
 
 struct adcxx1c_model {
+	const struct iio_chan_spec* channels;
 	int bits;
 };
 
-#define ADCxx1C_MODEL(_bits)						\
+#define ADCxx1C_MODEL(_name, _bits)					\
 	{								\
+		.channels = _name ## _channels,				\
 		.bits = (_bits),					\
 	}
 
+DEFINE_ADCxx1C_CHANNELS(adc081c,  8);
+DEFINE_ADCxx1C_CHANNELS(adc101c, 10);
+DEFINE_ADCxx1C_CHANNELS(adc121c, 12);
+
 /* Model ids are indexes in _models array */
 enum adcxx1c_model_id {
 	ADC081C = 0,
@@ -92,9 +116,9 @@ enum adcxx1c_model_id {
 };
 
 static struct adcxx1c_model adcxx1c_models[] = {
-	ADCxx1C_MODEL( 8),
-	ADCxx1C_MODEL(10),
-	ADCxx1C_MODEL(12),
+	ADCxx1C_MODEL(adc081c,  8),
+	ADCxx1C_MODEL(adc101c, 10),
+	ADCxx1C_MODEL(adc121c, 12),
 };
 
 static const struct iio_info adc081c_info = {
@@ -102,6 +126,24 @@ static const struct iio_info adc081c_info = {
 	.driver_module = THIS_MODULE,
 };
 
+static irqreturn_t adc081c_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adc081c *data = iio_priv(indio_dev);
+	u16 buf[8]; /* 2 bytes data + 6 bytes padding + 8 bytes timestamp */
+	int ret;
+
+	ret = i2c_smbus_read_word_swapped(data->i2c, REG_CONV_RES);
+	if (ret < 0)
+		goto out;
+	buf[0] = ret;
+	iio_push_to_buffers_with_timestamp(indio_dev, buf, iio_get_time_ns());
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static int adc081c_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -134,18 +176,26 @@ static int adc081c_probe(struct i2c_client *client,
 	iio->modes = INDIO_DIRECT_MODE;
 	iio->info = &adc081c_info;
 
-	iio->channels = &adc081c_channel;
-	iio->num_channels = 1;
+	iio->channels = model->channels;
+	iio->num_channels = ADC081C_NUM_CHANNELS;
+
+	err = iio_triggered_buffer_setup(iio, NULL, adc081c_trigger_handler, NULL);
+	if (err < 0) {
+		dev_err(&client->dev, "iio triggered buffer setup failed\n");
+		goto err_regulator_disable;
+	}
 
 	err = iio_device_register(iio);
 	if (err < 0)
-		goto regulator_disable;
+		goto err_buffer_cleanup;
 
 	i2c_set_clientdata(client, iio);
 
 	return 0;
 
-regulator_disable:
+err_buffer_cleanup:
+	iio_triggered_buffer_cleanup(iio);
+err_regulator_disable:
 	regulator_disable(adc->ref);
 
 	return err;
@@ -157,6 +207,7 @@ static int adc081c_remove(struct i2c_client *client)
 	struct adc081c *adc = iio_priv(iio);
 
 	iio_device_unregister(iio);
+	iio_triggered_buffer_cleanup(iio);
 	regulator_disable(adc->ref);
 
 	return 0;
-- 
2.5.5

