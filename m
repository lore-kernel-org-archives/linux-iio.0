Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:61161 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbdHNJAv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Aug 2017 05:00:51 -0400
Date: Mon, 14 Aug 2017 11:00:55 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Cc: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] iio: srf08: add triggered buffer support
Message-ID: <20170814090055.GA9897@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add support for triggered buffers.

Data format is quite simple:
  distance     16 Bit
  alignment    48 Bit
  timestamp    64 Bit

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/srf08.c | 59 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index 3f19536f215f..8018bb90b7b2 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -18,6 +18,9 @@
 #include <linux/bitops.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 /* registers of SRF08 device */
 #define SRF08_WRITE_COMMAND	0x00	/* Command Register */
@@ -35,9 +38,22 @@
 
 struct srf08_data {
 	struct i2c_client	*client;
-	int			sensitivity;		/* Gain */
-	int			range_mm;		/* max. Range in mm */
+
+	/*
+	 * Gain in the datasheet is called sensitivity here to distinct it
+	 * from the gain used with amplifiers of adc's
+	 */
+	int			sensitivity;
+
+	/* max. Range in mm */
+	int			range_mm;
 	struct mutex		lock;
+
+	/*
+	 * triggered buffer
+	 * 1x16-bit channel + 3x16 padding + 4x16 timestamp
+	 */
+	s16			buffer[8];
 };
 
 /*
@@ -110,6 +126,28 @@ static int srf08_read_ranging(struct srf08_data *data)
 	return ret;
 }
 
+static irqreturn_t srf08_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct srf08_data *data = iio_priv(indio_dev);
+	s16 sensor_data;
+
+	sensor_data = srf08_read_ranging(data);
+	if (sensor_data < 0)
+		goto err;
+
+	mutex_lock(&data->lock);
+	data->buffer[0] = sensor_data;
+	mutex_unlock(&data->lock);
+
+	iio_push_to_buffers_with_timestamp(indio_dev,
+						data->buffer, pf->timestamp);
+err:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static int srf08_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *channel, int *val,
 			    int *val2, long mask)
@@ -323,7 +361,15 @@ static const struct iio_chan_spec srf08_channels[] = {
 		.info_mask_separate =
 				BIT(IIO_CHAN_INFO_RAW) |
 				BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(1),
 };
 
 static const struct iio_info srf08_info = {
@@ -362,6 +408,13 @@ static int srf08_probe(struct i2c_client *client,
 
 	mutex_init(&data->lock);
 
+	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
+			iio_pollfunc_store_time, srf08_trigger_handler, NULL);
+	if (ret < 0) {
+		dev_err(&client->dev, "setup of iio triggered buffer failed\n");
+		return ret;
+	}
+
 	/*
 	 * set default values of device here
 	 * these register values cannot be read from the hardware
@@ -402,5 +455,5 @@ static struct i2c_driver srf08_driver = {
 module_i2c_driver(srf08_driver);
 
 MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
-MODULE_DESCRIPTION("Devantech SRF08 ultrasonic ranger driver");
+MODULE_DESCRIPTION("Devantech SRF08/SRF10 ultrasonic ranger driver");
 MODULE_LICENSE("GPL");
-- 
2.1.4


-- 
