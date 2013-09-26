Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/18] iio:tsl2563: Switch to new event config interface
Date: Thu, 26 Sep 2013 14:58:24 +0200
Message-Id: <1380200317-19355-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1380200317-19355-1-git-send-email-lars@metafoo.de>
References: <1380200317-19355-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Switch the tsl2563 driver to the new IIO event config interface as the old one
is going to be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/light/tsl2563.c | 49 ++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index ebb962c..28c9953 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -526,6 +526,20 @@ error_ret:
 	return ret;
 }
 
+static const struct iio_event_spec tsl2563_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				BIT(IIO_EV_INFO_ENABLE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
 static const struct iio_chan_spec tsl2563_channels[] = {
 	{
 		.type = IIO_LIGHT,
@@ -538,10 +552,8 @@ static const struct iio_chan_spec tsl2563_channels[] = {
 		.channel2 = IIO_MOD_LIGHT_BOTH,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_CALIBSCALE),
-		.event_mask = (IIO_EV_BIT(IIO_EV_TYPE_THRESH,
-					  IIO_EV_DIR_RISING) |
-			       IIO_EV_BIT(IIO_EV_TYPE_THRESH,
-					  IIO_EV_DIR_FALLING)),
+		.event_spec = tsl2563_events,
+		.num_event_specs = ARRAY_SIZE(tsl2563_events),
 	}, {
 		.type = IIO_INTENSITY,
 		.modified = 1,
@@ -552,12 +564,12 @@ static const struct iio_chan_spec tsl2563_channels[] = {
 };
 
 static int tsl2563_read_thresh(struct iio_dev *indio_dev,
-			       u64 event_code,
-			       int *val)
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, enum iio_event_info info, int *val)
 {
 	struct tsl2563_chip *chip = iio_priv(indio_dev);
 
-	switch (IIO_EVENT_CODE_EXTRACT_DIR(event_code)) {
+	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		*val = chip->high_thres;
 		break;
@@ -572,14 +584,14 @@ static int tsl2563_read_thresh(struct iio_dev *indio_dev,
 }
 
 static int tsl2563_write_thresh(struct iio_dev *indio_dev,
-				  u64 event_code,
-				  int val)
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, enum iio_event_info info, int val)
 {
 	struct tsl2563_chip *chip = iio_priv(indio_dev);
 	int ret;
 	u8 address;
 
-	if (IIO_EVENT_CODE_EXTRACT_DIR(event_code) == IIO_EV_DIR_RISING)
+	if (dir == IIO_EV_DIR_RISING)
 		address = TSL2563_REG_HIGHLOW;
 	else
 		address = TSL2563_REG_LOWLOW;
@@ -591,7 +603,7 @@ static int tsl2563_write_thresh(struct iio_dev *indio_dev,
 	ret = i2c_smbus_write_byte_data(chip->client,
 					TSL2563_CMD | (address + 1),
 					(val >> 8) & 0xFF);
-	if (IIO_EVENT_CODE_EXTRACT_DIR(event_code) == IIO_EV_DIR_RISING)
+	if (dir == IIO_EV_DIR_RISING)
 		chip->high_thres = val;
 	else
 		chip->low_thres = val;
@@ -620,8 +632,8 @@ static irqreturn_t tsl2563_event_handler(int irq, void *private)
 }
 
 static int tsl2563_write_interrupt_config(struct iio_dev *indio_dev,
-					  u64 event_code,
-					  int state)
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, int state)
 {
 	struct tsl2563_chip *chip = iio_priv(indio_dev);
 	int ret = 0;
@@ -662,7 +674,8 @@ out:
 }
 
 static int tsl2563_read_interrupt_config(struct iio_dev *indio_dev,
-					 u64 event_code)
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir)
 {
 	struct tsl2563_chip *chip = iio_priv(indio_dev);
 	int ret;
@@ -687,10 +700,10 @@ static const struct iio_info tsl2563_info = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &tsl2563_read_raw,
 	.write_raw = &tsl2563_write_raw,
-	.read_event_value = &tsl2563_read_thresh,
-	.write_event_value = &tsl2563_write_thresh,
-	.read_event_config = &tsl2563_read_interrupt_config,
-	.write_event_config = &tsl2563_write_interrupt_config,
+	.read_event_value_new = &tsl2563_read_thresh,
+	.write_event_value_new = &tsl2563_write_thresh,
+	.read_event_config_new = &tsl2563_read_interrupt_config,
+	.write_event_config_new = &tsl2563_write_interrupt_config,
 };
 
 static int tsl2563_probe(struct i2c_client *client,
-- 
1.8.0
