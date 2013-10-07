Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-020.synserver.de ([212.40.185.20]:1061 "EHLO
	smtp-out-017.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754969Ab3JGOJv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2013 10:09:51 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 13/20] staging:iio:ad7150: Switch to new event config interface
Date: Mon,  7 Oct 2013 16:11:27 +0200
Message-Id: <1381155094-20166-13-git-send-email-lars@metafoo.de>
In-Reply-To: <1381155094-20166-1-git-send-email-lars@metafoo.de>
References: <1381155094-20166-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Switch the ad7150 driver to the new IIO event config interface as the old one
is going to be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/cdc/ad7150.c | 163 ++++++++++++++++++++++++---------------
 1 file changed, 99 insertions(+), 64 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index f4a0341..14a28c4 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -123,14 +123,14 @@ static int ad7150_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static int ad7150_read_event_config(struct iio_dev *indio_dev, u64 event_code)
+static int ad7150_read_event_config(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir)
 {
 	int ret;
 	u8 threshtype;
 	bool adaptive;
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
-	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
-			IIO_EV_DIR_RISING);
 
 	ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
 	if (ret < 0)
@@ -139,42 +139,47 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev, u64 event_code)
 	threshtype = (ret >> 5) & 0x03;
 	adaptive = !!(ret & 0x80);
 
-	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+	switch (type) {
 	case IIO_EV_TYPE_MAG_ADAPTIVE:
-		if (rising)
+		if (dir == IIO_EV_DIR_RISING)
 			return adaptive && (threshtype == 0x1);
 		else
 			return adaptive && (threshtype == 0x0);
 	case IIO_EV_TYPE_THRESH_ADAPTIVE:
-		if (rising)
+		if (dir == IIO_EV_DIR_RISING)
 			return adaptive && (threshtype == 0x3);
 		else
 			return adaptive && (threshtype == 0x2);
 
 	case IIO_EV_TYPE_THRESH:
-		if (rising)
+		if (dir == IIO_EV_DIR_RISING)
 			return !adaptive && (threshtype == 0x1);
 		else
 			return !adaptive && (threshtype == 0x0);
+	default:
+		break;
 	}
 	return -EINVAL;
 }
 
 /* lock should be held */
-static int ad7150_write_event_params(struct iio_dev *indio_dev, u64 event_code)
+static int ad7150_write_event_params(struct iio_dev *indio_dev,
+	 unsigned int chan, enum iio_event_type type,
+	 enum iio_event_direction dir)
 {
 	int ret;
 	u16 value;
 	u8 sens, timeout;
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
-	int chan = IIO_EVENT_CODE_EXTRACT_CHAN(event_code);
-	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
-			IIO_EV_DIR_RISING);
+	int rising = (dir == IIO_EV_DIR_RISING);
+	u64 event_code;
+
+	event_code = IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE, chan, type, dir);
 
 	if (event_code != chip->current_event)
 		return 0;
 
-	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+	switch (type) {
 		/* Note completely different from the adaptive versions */
 	case IIO_EV_TYPE_THRESH:
 		value = chip->threshold[rising][chan];
@@ -211,18 +216,20 @@ static int ad7150_write_event_params(struct iio_dev *indio_dev, u64 event_code)
 }
 
 static int ad7150_write_event_config(struct iio_dev *indio_dev,
-				     u64 event_code, int state)
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, int state)
 {
 	u8 thresh_type, cfg, adaptive;
 	int ret;
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
-	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
-			IIO_EV_DIR_RISING);
+	int rising = (dir == IIO_EV_DIR_RISING);
+	u64 event_code;
 
 	/* Something must always be turned on */
 	if (state == 0)
 		return -EINVAL;
 
+	event_code = IIO_UNMOD_EVENT_CODE(chan->type, chan->channel, type, dir);
 	if (event_code == chip->current_event)
 		return 0;
 	mutex_lock(&chip->state_lock);
@@ -232,7 +239,7 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
 
 	cfg = ret & ~((0x03 << 5) | (0x1 << 7));
 
-	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+	switch (type) {
 	case IIO_EV_TYPE_MAG_ADAPTIVE:
 		adaptive = 1;
 		if (rising)
@@ -268,7 +275,7 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
 	chip->current_event = event_code;
 
 	/* update control attributes */
-	ret = ad7150_write_event_params(indio_dev, event_code);
+	ret = ad7150_write_event_params(indio_dev, chan->channel, type, dir);
 error_ret:
 	mutex_unlock(&chip->state_lock);
 
@@ -276,53 +283,52 @@ error_ret:
 }
 
 static int ad7150_read_event_value(struct iio_dev *indio_dev,
-				   u64 event_code,
-				   int *val)
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info,
+				   int *val, int *val2)
 {
-	int chan = IIO_EVENT_CODE_EXTRACT_CHAN(event_code);
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
-	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
-			IIO_EV_DIR_RISING);
+	int rising = (dir == IIO_EV_DIR_RISING);
 
 	/* Complex register sharing going on here */
-	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+	switch (type) {
 	case IIO_EV_TYPE_MAG_ADAPTIVE:
-		*val = chip->mag_sensitivity[rising][chan];
-		return 0;
-
+		*val = chip->mag_sensitivity[rising][chan->channel];
+		return IIO_VAL_INT;
 	case IIO_EV_TYPE_THRESH_ADAPTIVE:
-		*val = chip->thresh_sensitivity[rising][chan];
-		return 0;
-
+		*val = chip->thresh_sensitivity[rising][chan->channel];
+		return IIO_VAL_INT;
 	case IIO_EV_TYPE_THRESH:
-		*val = chip->threshold[rising][chan];
-		return 0;
-
+		*val = chip->threshold[rising][chan->channel];
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	};
 }
 
 static int ad7150_write_event_value(struct iio_dev *indio_dev,
-				   u64 event_code,
-				   int val)
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info,
+				   int val, int val2)
 {
 	int ret;
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
-	int chan = IIO_EVENT_CODE_EXTRACT_CHAN(event_code);
-	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
-			IIO_EV_DIR_RISING);
+	int rising = (dir == IIO_EV_DIR_RISING);
 
 	mutex_lock(&chip->state_lock);
-	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+	switch (type) {
 	case IIO_EV_TYPE_MAG_ADAPTIVE:
-		chip->mag_sensitivity[rising][chan] = val;
+		chip->mag_sensitivity[rising][chan->channel] = val;
 		break;
 	case IIO_EV_TYPE_THRESH_ADAPTIVE:
-		chip->thresh_sensitivity[rising][chan] = val;
+		chip->thresh_sensitivity[rising][chan->channel] = val;
 		break;
 	case IIO_EV_TYPE_THRESH:
-		chip->threshold[rising][chan] = val;
+		chip->threshold[rising][chan->channel] = val;
 		break;
 	default:
 		ret = -EINVAL;
@@ -330,7 +336,7 @@ static int ad7150_write_event_value(struct iio_dev *indio_dev,
 	}
 
 	/* write back if active */
-	ret = ad7150_write_event_params(indio_dev, event_code);
+	ret = ad7150_write_event_params(indio_dev, chan->channel, type, dir);
 
 error_ret:
 	mutex_unlock(&chip->state_lock);
@@ -374,17 +380,22 @@ static ssize_t ad7150_store_timeout(struct device *dev,
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int chan = IIO_EVENT_CODE_EXTRACT_CHAN(this_attr->address);
-	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(this_attr->address) ==
-			IIO_EV_DIR_RISING);
+	enum iio_event_direction dir;
+	enum iio_event_type type;
+	int rising;
 	u8 data;
 	int ret;
 
+	type = IIO_EVENT_CODE_EXTRACT_TYPE(this_attr->address);
+	dir = IIO_EVENT_CODE_EXTRACT_DIR(this_attr->address);
+	rising = (dir == IIO_EV_DIR_RISING);
+
 	ret = kstrtou8(buf, 10, &data);
 	if (ret < 0)
 		return ret;
 
 	mutex_lock(&chip->state_lock);
-	switch (IIO_EVENT_CODE_EXTRACT_TYPE(this_attr->address)) {
+	switch (type) {
 	case IIO_EV_TYPE_MAG_ADAPTIVE:
 		chip->mag_timeout[rising][chan] = data;
 		break;
@@ -396,7 +407,7 @@ static ssize_t ad7150_store_timeout(struct device *dev,
 		goto error_ret;
 	}
 
-	ret = ad7150_write_event_params(indio_dev, this_attr->address);
+	ret = ad7150_write_event_params(indio_dev, chan, type, dir);
 error_ret:
 	mutex_unlock(&chip->state_lock);
 
@@ -424,6 +435,40 @@ static AD7150_TIMEOUT(0, thresh_adaptive, falling, THRESH_ADAPTIVE, FALLING);
 static AD7150_TIMEOUT(1, thresh_adaptive, rising, THRESH_ADAPTIVE, RISING);
 static AD7150_TIMEOUT(1, thresh_adaptive, falling, THRESH_ADAPTIVE, FALLING);
 
+static const struct iio_event_spec ad7150_events[] = {
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
+	}, {
+		.type = IIO_EV_TYPE_THRESH_ADAPTIVE,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH_ADAPTIVE,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	}, {
+		.type = IIO_EV_TYPE_MAG_ADAPTIVE,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	}, {
+		.type = IIO_EV_TYPE_MAG_ADAPTIVE,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
 static const struct iio_chan_spec ad7150_channels[] = {
 	{
 		.type = IIO_CAPACITANCE,
@@ -431,26 +476,16 @@ static const struct iio_chan_spec ad7150_channels[] = {
 		.channel = 0,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_AVERAGE_RAW),
-		.event_mask =
-		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |
-		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING) |
-		IIO_EV_BIT(IIO_EV_TYPE_THRESH_ADAPTIVE, IIO_EV_DIR_RISING) |
-		IIO_EV_BIT(IIO_EV_TYPE_THRESH_ADAPTIVE, IIO_EV_DIR_FALLING) |
-		IIO_EV_BIT(IIO_EV_TYPE_MAG_ADAPTIVE, IIO_EV_DIR_RISING) |
-		IIO_EV_BIT(IIO_EV_TYPE_MAG_ADAPTIVE, IIO_EV_DIR_FALLING)
+		.event_spec = ad7150_events,
+		.num_event_specs = ARRAY_SIZE(ad7150_events),
 	}, {
 		.type = IIO_CAPACITANCE,
 		.indexed = 1,
 		.channel = 1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_AVERAGE_RAW),
-		.event_mask =
-		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |
-		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING) |
-		IIO_EV_BIT(IIO_EV_TYPE_THRESH_ADAPTIVE, IIO_EV_DIR_RISING) |
-		IIO_EV_BIT(IIO_EV_TYPE_THRESH_ADAPTIVE, IIO_EV_DIR_FALLING) |
-		IIO_EV_BIT(IIO_EV_TYPE_MAG_ADAPTIVE, IIO_EV_DIR_RISING) |
-		IIO_EV_BIT(IIO_EV_TYPE_MAG_ADAPTIVE, IIO_EV_DIR_FALLING)
+		.event_spec = ad7150_events,
+		.num_event_specs = ARRAY_SIZE(ad7150_events),
 	},
 };
 
@@ -541,10 +576,10 @@ static const struct iio_info ad7150_info = {
 	.event_attrs = &ad7150_event_attribute_group,
 	.driver_module = THIS_MODULE,
 	.read_raw = &ad7150_read_raw,
-	.read_event_config = &ad7150_read_event_config,
-	.write_event_config = &ad7150_write_event_config,
-	.read_event_value = &ad7150_read_event_value,
-	.write_event_value = &ad7150_write_event_value,
+	.read_event_config_new = &ad7150_read_event_config,
+	.write_event_config_new = &ad7150_write_event_config,
+	.read_event_value_new = &ad7150_read_event_value,
+	.write_event_value_new = &ad7150_write_event_value,
 };
 
 /*
-- 
1.8.0

