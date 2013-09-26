Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-234.synserver.de ([212.40.185.234]:1490 "EHLO
	smtp-out-232.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756554Ab3IZM5K (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2013 08:57:10 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/18] staging:iio:ad7291: Switch to new event config interface
Date: Thu, 26 Sep 2013 14:58:28 +0200
Message-Id: <1380200317-19355-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1380200317-19355-1-git-send-email-lars@metafoo.de>
References: <1380200317-19355-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Switch the ad7291 driver to the new IIO event config interface as the old one
is going to be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7291.c | 88 +++++++++++++++++++++++++---------------
 1 file changed, 55 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 1dae1ef..fa60764 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -248,13 +248,14 @@ static struct attribute *ad7291_event_attributes[] = {
 	NULL,
 };
 
-static unsigned int ad7291_threshold_reg(u64 event_code)
+static unsigned int ad7291_threshold_reg(const struct iio_chan_spec *chan,
+	enum iio_event_direction dir)
 {
 	unsigned int offset;
 
-	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
+	switch (chan->type) {
 	case IIO_VOLTAGE:
-		offset = IIO_EVENT_CODE_EXTRACT_CHAN(event_code);
+		offset = chan->channel;
 		break;
 	case IIO_TEMP:
 		offset = 8;
@@ -263,25 +264,28 @@ static unsigned int ad7291_threshold_reg(u64 event_code)
 	    return 0;
 	}
 
-	if (IIO_EVENT_CODE_EXTRACT_DIR(event_code) == IIO_EV_DIR_FALLING)
+	if (dir == IIO_EV_DIR_FALLING)
 		return AD7291_DATA_LOW(offset);
 	else
 		return AD7291_DATA_HIGH(offset);
 }
 
 static int ad7291_read_event_value(struct iio_dev *indio_dev,
-				   u64 event_code,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info,
 				   int *val)
 {
 	struct ad7291_chip_info *chip = iio_priv(indio_dev);
 	int ret;
 	u16 uval;
 
-	ret = ad7291_i2c_read(chip, ad7291_threshold_reg(event_code), &uval);
+	ret = ad7291_i2c_read(chip, ad7291_threshold_reg(chan, dir), &uval);
 	if (ret < 0)
 		return ret;
 
-	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
+	switch (chan->type) {
 	case IIO_VOLTAGE:
 		*val = uval & AD7291_VALUE_MASK;
 		return 0;
@@ -294,12 +298,15 @@ static int ad7291_read_event_value(struct iio_dev *indio_dev,
 }
 
 static int ad7291_write_event_value(struct iio_dev *indio_dev,
-				    u64 event_code,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
 				    int val)
 {
 	struct ad7291_chip_info *chip = iio_priv(indio_dev);
 
-	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
+	switch (chan->type) {
 	case IIO_VOLTAGE:
 		if (val > AD7291_VALUE_MASK || val < 0)
 			return -EINVAL;
@@ -312,20 +319,21 @@ static int ad7291_write_event_value(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-	return ad7291_i2c_write(chip, ad7291_threshold_reg(event_code), val);
+	return ad7291_i2c_write(chip, ad7291_threshold_reg(chan, dir), val);
 }
 
 static int ad7291_read_event_config(struct iio_dev *indio_dev,
-				    u64 event_code)
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir)
 {
 	struct ad7291_chip_info *chip = iio_priv(indio_dev);
 	/* To be enabled the channel must simply be on. If any are enabled
 	   we are in continuous sampling mode */
 
-	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
+	switch (chan->type) {
 	case IIO_VOLTAGE:
-		if (chip->c_mask &
-		    (1 << (15 - IIO_EVENT_CODE_EXTRACT_CHAN(event_code))))
+		if (chip->c_mask & (1 << (15 - chan->channel)))
 			return 1;
 		else
 			return 0;
@@ -339,11 +347,14 @@ static int ad7291_read_event_config(struct iio_dev *indio_dev,
 }
 
 static int ad7291_write_event_config(struct iio_dev *indio_dev,
-				     u64 event_code,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
 				     int state)
 {
 	int ret = 0;
 	struct ad7291_chip_info *chip = iio_priv(indio_dev);
+	unsigned int mask;
 	u16 regval;
 
 	mutex_lock(&chip->state_lock);
@@ -354,16 +365,14 @@ static int ad7291_write_event_config(struct iio_dev *indio_dev,
 	 * Possible to disable temp as well but that makes single read tricky.
 	 */
 
-	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+	mask = BIT(15 - chan->channel);
+
+	switch (chan->type) {
 	case IIO_VOLTAGE:
-		if ((!state) && (chip->c_mask & (1 << (15 -
-				IIO_EVENT_CODE_EXTRACT_CHAN(event_code)))))
-			chip->c_mask &= ~(1 << (15 - IIO_EVENT_CODE_EXTRACT_CHAN
-							(event_code)));
-		else if (state && (!(chip->c_mask & (1 << (15 -
-				IIO_EVENT_CODE_EXTRACT_CHAN(event_code))))))
-			chip->c_mask |= (1 << (15 - IIO_EVENT_CODE_EXTRACT_CHAN
-							(event_code)));
+		if ((!state) && (chip->c_mask & mask))
+			chip->c_mask &= ~mask;
+		else if (state && (!(chip->c_mask & mask)))
+			chip->c_mask |= mask;
 		else
 			break;
 
@@ -473,6 +482,20 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static const struct iio_event_spec ad7291_events[] = {
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
 #define AD7291_VOLTAGE_CHAN(_chan)					\
 {									\
 	.type = IIO_VOLTAGE,						\
@@ -480,8 +503,8 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
 	.indexed = 1,							\
 	.channel = _chan,						\
-	.event_mask = IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING)|\
-	IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING)		\
+	.event_spec = ad7291_events,					\
+	.num_event_specs = ARRAY_SIZE(ad7291_events),			\
 }
 
 static const struct iio_chan_spec ad7291_channels[] = {
@@ -500,9 +523,8 @@ static const struct iio_chan_spec ad7291_channels[] = {
 				BIT(IIO_CHAN_INFO_SCALE),
 		.indexed = 1,
 		.channel = 0,
-		.event_mask =
-		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING)|
-		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING)
+		.event_spec = ad7291_events,
+		.num_event_specs = ARRAY_SIZE(ad7291_events),
 	}
 };
 
@@ -512,10 +534,10 @@ static struct attribute_group ad7291_event_attribute_group = {
 
 static const struct iio_info ad7291_info = {
 	.read_raw = &ad7291_read_raw,
-	.read_event_config = &ad7291_read_event_config,
-	.write_event_config = &ad7291_write_event_config,
-	.read_event_value = &ad7291_read_event_value,
-	.write_event_value = &ad7291_write_event_value,
+	.read_event_config_new = &ad7291_read_event_config,
+	.write_event_config_new = &ad7291_write_event_config,
+	.read_event_value_new = &ad7291_read_event_value,
+	.write_event_value_new = &ad7291_write_event_value,
 	.event_attrs = &ad7291_event_attribute_group,
 	.driver_module = THIS_MODULE,
 };
-- 
1.8.0

