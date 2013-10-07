Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-020.synserver.de ([212.40.185.20]:1162 "EHLO
	smtp-out-017.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753350Ab3JGOJq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2013 10:09:46 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 06/20] iio:tsl2563: Switch to new event config interface
Date: Mon,  7 Oct 2013 16:11:20 +0200
Message-Id: <1381155094-20166-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1381155094-20166-1-git-send-email-lars@metafoo.de>
References: <1381155094-20166-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Switch the tsl2563 driver to the new IIO event config interface as the old one
is going to be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/light/tsl2563.c | 53 +++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index ebb962c..5e5d9de 100644
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
@@ -552,12 +564,13 @@ static const struct iio_chan_spec tsl2563_channels[] = {
 };
 
 static int tsl2563_read_thresh(struct iio_dev *indio_dev,
-			       u64 event_code,
-			       int *val)
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, enum iio_event_info info, int *val,
+	int *val2)
 {
 	struct tsl2563_chip *chip = iio_priv(indio_dev);
 
-	switch (IIO_EVENT_CODE_EXTRACT_DIR(event_code)) {
+	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		*val = chip->high_thres;
 		break;
@@ -568,18 +581,19 @@ static int tsl2563_read_thresh(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-	return 0;
+	return IIO_VAL_INT;
 }
 
 static int tsl2563_write_thresh(struct iio_dev *indio_dev,
-				  u64 event_code,
-				  int val)
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, enum iio_event_info info, int val,
+	int val2)
 {
 	struct tsl2563_chip *chip = iio_priv(indio_dev);
 	int ret;
 	u8 address;
 
-	if (IIO_EVENT_CODE_EXTRACT_DIR(event_code) == IIO_EV_DIR_RISING)
+	if (dir == IIO_EV_DIR_RISING)
 		address = TSL2563_REG_HIGHLOW;
 	else
 		address = TSL2563_REG_LOWLOW;
@@ -591,7 +605,7 @@ static int tsl2563_write_thresh(struct iio_dev *indio_dev,
 	ret = i2c_smbus_write_byte_data(chip->client,
 					TSL2563_CMD | (address + 1),
 					(val >> 8) & 0xFF);
-	if (IIO_EVENT_CODE_EXTRACT_DIR(event_code) == IIO_EV_DIR_RISING)
+	if (dir == IIO_EV_DIR_RISING)
 		chip->high_thres = val;
 	else
 		chip->low_thres = val;
@@ -620,8 +634,8 @@ static irqreturn_t tsl2563_event_handler(int irq, void *private)
 }
 
 static int tsl2563_write_interrupt_config(struct iio_dev *indio_dev,
-					  u64 event_code,
-					  int state)
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, int state)
 {
 	struct tsl2563_chip *chip = iio_priv(indio_dev);
 	int ret = 0;
@@ -662,7 +676,8 @@ out:
 }
 
 static int tsl2563_read_interrupt_config(struct iio_dev *indio_dev,
-					 u64 event_code)
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir)
 {
 	struct tsl2563_chip *chip = iio_priv(indio_dev);
 	int ret;
@@ -687,10 +702,10 @@ static const struct iio_info tsl2563_info = {
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

