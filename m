Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: [PATCH 06/18] iio:apds9300: Use new event config interface
Date: Thu, 26 Sep 2013 14:58:25 +0200
Message-Id: <1380200317-19355-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1380200317-19355-1-git-send-email-lars@metafoo.de>
References: <1380200317-19355-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Switch the apds9300 driver to the new IIO event config interface as the old one
is going to be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
---
 drivers/iio/light/apds9300.c | 48 ++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
index 66a58bd..3f395f5 100644
--- a/drivers/iio/light/apds9300.c
+++ b/drivers/iio/light/apds9300.c
@@ -273,12 +273,14 @@ static int apds9300_read_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int apds9300_read_thresh(struct iio_dev *indio_dev, u64 event_code,
+static int apds9300_read_thresh(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan, enum iio_event_type type,
+		enum iio_event_direction dir, enum iio_event_info info,
 		int *val)
 {
 	struct apds9300_data *data = iio_priv(indio_dev);
 
-	switch (IIO_EVENT_CODE_EXTRACT_DIR(event_code)) {
+	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		*val = data->thresh_hi;
 		break;
@@ -292,14 +294,15 @@ static int apds9300_read_thresh(struct iio_dev *indio_dev, u64 event_code,
 	return 0;
 }
 
-static int apds9300_write_thresh(struct iio_dev *indio_dev, u64 event_code,
-		int val)
+static int apds9300_write_thresh(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan, enum iio_event_type type,
+		enum iio_event_direction dir, enum iio_event_info info, int val)
 {
 	struct apds9300_data *data = iio_priv(indio_dev);
 	int ret;
 
 	mutex_lock(&data->mutex);
-	if (IIO_EVENT_CODE_EXTRACT_DIR(event_code) == IIO_EV_DIR_RISING)
+	if (dir == IIO_EV_DIR_RISING)
 		ret = apds9300_set_thresh_hi(data, val);
 	else
 		ret = apds9300_set_thresh_low(data, val);
@@ -309,7 +312,9 @@ static int apds9300_write_thresh(struct iio_dev *indio_dev, u64 event_code,
 }
 
 static int apds9300_read_interrupt_config(struct iio_dev *indio_dev,
-		u64 event_code)
+		const struct iio_chan_spec *chan,
+		enum iio_event_type type,
+		enum iio_event_direction dir)
 {
 	struct apds9300_data *data = iio_priv(indio_dev);
 
@@ -317,7 +322,8 @@ static int apds9300_read_interrupt_config(struct iio_dev *indio_dev,
 }
 
 static int apds9300_write_interrupt_config(struct iio_dev *indio_dev,
-		u64 event_code, int state)
+		const struct iio_chan_spec *chan, enum iio_event_type type,
+		enum iio_event_direction dir, int state)
 {
 	struct apds9300_data *data = iio_priv(indio_dev);
 	int ret;
@@ -337,10 +343,24 @@ static const struct iio_info apds9300_info_no_irq = {
 static const struct iio_info apds9300_info = {
 	.driver_module		= THIS_MODULE,
 	.read_raw		= apds9300_read_raw,
-	.read_event_value	= apds9300_read_thresh,
-	.write_event_value	= apds9300_write_thresh,
-	.read_event_config	= apds9300_read_interrupt_config,
-	.write_event_config	= apds9300_write_interrupt_config,
+	.read_event_value_new	= apds9300_read_thresh,
+	.write_event_value_new	= apds9300_write_thresh,
+	.read_event_config_new	= apds9300_read_interrupt_config,
+	.write_event_config_new	= apds9300_write_interrupt_config,
+};
+
+static const struct iio_event_spec apds9300_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	},
 };
 
 static const struct iio_chan_spec apds9300_channels[] = {
@@ -355,10 +375,8 @@ static const struct iio_chan_spec apds9300_channels[] = {
 		.channel2 = IIO_MOD_LIGHT_BOTH,
 		.indexed = true,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.event_mask = (IIO_EV_BIT(IIO_EV_TYPE_THRESH,
-					  IIO_EV_DIR_RISING) |
-			       IIO_EV_BIT(IIO_EV_TYPE_THRESH,
-					  IIO_EV_DIR_FALLING)),
+		.event_spec = apds9300_event_spec,
+		.num_event_specs = ARRAY_SIZE(apds9300_event_spec),
 	}, {
 		.type = IIO_INTENSITY,
 		.channel = 1,
-- 
1.8.0
