Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:12539 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755127AbcDKSxD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 11 Apr 2016 14:53:03 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH v2 5/5] max44000: Initial triggered buffer support
Date: Mon, 11 Apr 2016 21:52:42 +0300
Message-Id: <76708b525e6f495e6cc97307baa9bd1b50ad1f4a.1460400449.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1460400449.git.leonard.crestez@intel.com>
References: <cover.1460400449.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1460400449.git.leonard.crestez@intel.com>
References: <cover.1460400449.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/iio/light/max44000.c | 62 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index 79a8282..48955df 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -19,6 +19,9 @@
 #include <linux/util_macros.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 #include <linux/acpi.h>
 
 #define MAX44000_DRV_NAME		"max44000"
@@ -163,24 +166,41 @@ static const char max44000_scale_avail_str[] =
 	"0.5 "
 	 "4";
 
+#define MAX44000_SCAN_INDEX_ALS 0
+#define MAX44000_SCAN_INDEX_PRX 1
+
 static const struct iio_chan_spec max44000_channels[] = {
 	{
 		.type = IIO_LIGHT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
 					    BIT(IIO_CHAN_INFO_INT_TIME),
+		.scan_index = MAX44000_SCAN_INDEX_ALS,
+		.scan_type = {
+			.sign		= 'u',
+			.realbits	= 14,
+			.storagebits	= 16,
+		}
 	},
 	{
 		.type = IIO_PROXIMITY,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = MAX44000_SCAN_INDEX_PRX,
+		.scan_type = {
+			.sign		= 'u',
+			.realbits	= 8,
+			.storagebits	= 16,
+		}
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 	{
 		.type = IIO_CURRENT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
 		.extend_name = "led",
 		.output = 1,
+		.scan_index = -1,
 	},
 };
 
@@ -480,6 +500,41 @@ static const struct regmap_config max44000_regmap_config = {
 	.num_reg_defaults	= ARRAY_SIZE(max44000_reg_defaults),
 };
 
+static irqreturn_t max44000_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct max44000_data *data = iio_priv(indio_dev);
+	u16 buf[8]; /* 2x u16 + padding + 8 bytes timestamp */
+	int index = 0;
+	unsigned int regval;
+	int ret;
+
+	mutex_lock(&data->lock);
+	if (*indio_dev->active_scan_mask & (1 << MAX44000_SCAN_INDEX_ALS)) {
+		ret = max44000_read_alsval(data);
+		if (ret < 0)
+			goto out_unlock;
+		buf[index++] = ret;
+	}
+	if (*indio_dev->active_scan_mask & (1 << MAX44000_SCAN_INDEX_PRX)) {
+		ret = regmap_read(data->regmap, MAX44000_REG_PRX_DATA, &regval);
+		if (ret < 0)
+			goto out_unlock;
+		buf[index] = regval;
+	}
+	mutex_unlock(&data->lock);
+
+	iio_push_to_buffers_with_timestamp(indio_dev, buf, iio_get_time_ns());
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+
+out_unlock:
+	mutex_unlock(&data->lock);
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static int max44000_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
@@ -545,6 +600,12 @@ static int max44000_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	ret = iio_triggered_buffer_setup(indio_dev, NULL, max44000_trigger_handler, NULL);
+	if (ret < 0) {
+		dev_err(&client->dev, "iio triggered buffer setup failed\n");
+		return ret;
+	}
+
 	return iio_device_register(indio_dev);
 }
 
@@ -553,6 +614,7 @@ static int max44000_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
 	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
 	return 0;
 }
 
-- 
2.5.5

