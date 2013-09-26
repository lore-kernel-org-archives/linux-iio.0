Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/18] iio:ad5421: Switch to new event config interface
Date: Thu, 26 Sep 2013 14:58:22 +0200
Message-Id: <1380200317-19355-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1380200317-19355-1-git-send-email-lars@metafoo.de>
References: <1380200317-19355-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Switch the ad5421 driver to the new IIO event config interface as the old one
is going to be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5421.c | 59 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
index 1f78b14..eefc708 100644
--- a/drivers/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -80,6 +80,29 @@ struct ad5421_state {
 	} data[2] ____cacheline_aligned;
 };
 
+static const struct iio_event_spec ad5421_current_event[] = {
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
+};
+
+static const struct iio_event_spec ad5421_temp_event[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
 static const struct iio_chan_spec ad5421_channels[] = {
 	{
 		.type = IIO_CURRENT,
@@ -92,13 +115,14 @@ static const struct iio_chan_spec ad5421_channels[] = {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
 			BIT(IIO_CHAN_INFO_OFFSET),
 		.scan_type = IIO_ST('u', 16, 16, 0),
-		.event_mask = IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |
-			IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
+		.event_spec = ad5421_current_event,
+		.num_event_specs = ARRAY_SIZE(ad5421_current_event),
 	},
 	{
 		.type = IIO_TEMP,
 		.channel = -1,
-		.event_mask = IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
+		.event_spec = ad5421_temp_event,
+		.num_event_specs = ARRAY_SIZE(ad5421_temp_event),
 	},
 };
 
@@ -359,15 +383,15 @@ static int ad5421_write_raw(struct iio_dev *indio_dev,
 }
 
 static int ad5421_write_event_config(struct iio_dev *indio_dev,
-	u64 event_code, int state)
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, int state)
 {
 	struct ad5421_state *st = iio_priv(indio_dev);
 	unsigned int mask;
 
-	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
+	switch (chan->type) {
 	case IIO_CURRENT:
-		if (IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
-			IIO_EV_DIR_RISING)
+		if (dir == IIO_EV_DIR_RISING)
 			mask = AD5421_FAULT_OVER_CURRENT;
 		else
 			mask = AD5421_FAULT_UNDER_CURRENT;
@@ -390,15 +414,15 @@ static int ad5421_write_event_config(struct iio_dev *indio_dev,
 }
 
 static int ad5421_read_event_config(struct iio_dev *indio_dev,
-	u64 event_code)
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir)
 {
 	struct ad5421_state *st = iio_priv(indio_dev);
 	unsigned int mask;
 
-	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
+	switch (chan->type) {
 	case IIO_CURRENT:
-		if (IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
-			IIO_EV_DIR_RISING)
+		if (dir == IIO_EV_DIR_RISING)
 			mask = AD5421_FAULT_OVER_CURRENT;
 		else
 			mask = AD5421_FAULT_UNDER_CURRENT;
@@ -413,12 +437,13 @@ static int ad5421_read_event_config(struct iio_dev *indio_dev,
 	return (bool)(st->fault_mask & mask);
 }
 
-static int ad5421_read_event_value(struct iio_dev *indio_dev, u64 event_code,
-	int *val)
+static int ad5421_read_event_value(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, enum iio_event_info info, int *val)
 {
 	int ret;
 
-	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
+	switch (chan->type) {
 	case IIO_CURRENT:
 		ret = ad5421_read(indio_dev, AD5421_REG_DAC_DATA);
 		if (ret < 0)
@@ -438,9 +463,9 @@ static int ad5421_read_event_value(struct iio_dev *indio_dev, u64 event_code,
 static const struct iio_info ad5421_info = {
 	.read_raw =		ad5421_read_raw,
 	.write_raw =		ad5421_write_raw,
-	.read_event_config =	ad5421_read_event_config,
-	.write_event_config =	ad5421_write_event_config,
-	.read_event_value =	ad5421_read_event_value,
+	.read_event_config_new = ad5421_read_event_config,
+	.write_event_config_new = ad5421_write_event_config,
+	.read_event_value_new =	ad5421_read_event_value,
 	.driver_module =	THIS_MODULE,
 };
 
-- 
1.8.0
