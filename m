Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-020.synserver.de ([212.40.185.20]:1093 "EHLO
	smtp-out-017.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754969Ab3JGOJw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2013 10:09:52 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Jon Brenner <jbrenner@taosinc.com>
Subject: [PATCH v2 15/20] staging:iio:tsl2x7x: Switch to new event config interface
Date: Mon,  7 Oct 2013 16:11:29 +0200
Message-Id: <1381155094-20166-15-git-send-email-lars@metafoo.de>
In-Reply-To: <1381155094-20166-1-git-send-email-lars@metafoo.de>
References: <1381155094-20166-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Switch the tsl2x7x driver to the new IIO event config interface as the old one
is going to be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jon Brenner <jbrenner@taosinc.com>
---
 drivers/staging/iio/light/tsl2x7x_core.c | 120 +++++++++++++++++++------------
 1 file changed, 73 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index 9c43dcf..1880502 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -124,11 +124,6 @@
 #define TSL2X7X_mA13                   0xD0
 #define TSL2X7X_MAX_TIMER_CNT          (0xFF)
 
-/*Common device IIO EventMask */
-#define TSL2X7X_EVENT_MASK \
-		(IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) | \
-		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING)),
-
 #define TSL2X7X_MIN_ITIME 3
 
 /* TAOS txx2x7x Device family members */
@@ -1222,12 +1217,14 @@ static ssize_t tsl2x7x_do_prox_calibrate(struct device *dev,
 }
 
 static int tsl2x7x_read_interrupt_config(struct iio_dev *indio_dev,
-					 u64 event_code)
+					 const struct iio_chan_spec *chan,
+					 enum iio_event_type type,
+					 enum iio_event_direction dir)
 {
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 	int ret;
 
-	if (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code) == IIO_INTENSITY)
+	if (chan->type == IIO_INTENSITY)
 		ret = !!(chip->tsl2x7x_settings.interrupts_en & 0x10);
 	else
 		ret = !!(chip->tsl2x7x_settings.interrupts_en & 0x20);
@@ -1236,12 +1233,14 @@ static int tsl2x7x_read_interrupt_config(struct iio_dev *indio_dev,
 }
 
 static int tsl2x7x_write_interrupt_config(struct iio_dev *indio_dev,
-					  u64 event_code,
+					  const struct iio_chan_spec *chan,
+					  enum iio_event_type type,
+					  enum iio_event_direction dir,
 					  int val)
 {
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 
-	if (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code) == IIO_INTENSITY) {
+	if (chan->type == IIO_INTENSITY) {
 		if (val)
 			chip->tsl2x7x_settings.interrupts_en |= 0x10;
 		else
@@ -1259,13 +1258,16 @@ static int tsl2x7x_write_interrupt_config(struct iio_dev *indio_dev,
 }
 
 static int tsl2x7x_write_thresh(struct iio_dev *indio_dev,
-				  u64 event_code,
-				  int val)
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int val, int val2)
 {
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 
-	if (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code) == IIO_INTENSITY) {
-		switch (IIO_EVENT_CODE_EXTRACT_DIR(event_code)) {
+	if (chan->type == IIO_INTENSITY) {
+		switch (dir) {
 		case IIO_EV_DIR_RISING:
 			chip->tsl2x7x_settings.als_thresh_high = val;
 			break;
@@ -1276,7 +1278,7 @@ static int tsl2x7x_write_thresh(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	} else {
-		switch (IIO_EVENT_CODE_EXTRACT_DIR(event_code)) {
+		switch (dir) {
 		case IIO_EV_DIR_RISING:
 			chip->tsl2x7x_settings.prox_thres_high = val;
 			break;
@@ -1294,13 +1296,16 @@ static int tsl2x7x_write_thresh(struct iio_dev *indio_dev,
 }
 
 static int tsl2x7x_read_thresh(struct iio_dev *indio_dev,
-			       u64 event_code,
-			       int *val)
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+				   enum iio_event_info info,
+			       int *val, int *val2)
 {
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 
-	if (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code) == IIO_INTENSITY) {
-		switch (IIO_EVENT_CODE_EXTRACT_DIR(event_code)) {
+	if (chan->type == IIO_INTENSITY) {
+		switch (dir) {
 		case IIO_EV_DIR_RISING:
 			*val = chip->tsl2x7x_settings.als_thresh_high;
 			break;
@@ -1311,7 +1316,7 @@ static int tsl2x7x_read_thresh(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	} else {
-		switch (IIO_EVENT_CODE_EXTRACT_DIR(event_code)) {
+		switch (dir) {
 		case IIO_EV_DIR_RISING:
 			*val = chip->tsl2x7x_settings.prox_thres_high;
 			break;
@@ -1323,7 +1328,7 @@ static int tsl2x7x_read_thresh(struct iio_dev *indio_dev,
 		}
 	}
 
-	return 0;
+	return IIO_VAL_INT;
 }
 
 static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
@@ -1667,10 +1672,10 @@ static const struct iio_info tsl2X7X_device_info[] = {
 		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
-		.read_event_value = &tsl2x7x_read_thresh,
-		.write_event_value = &tsl2x7x_write_thresh,
-		.read_event_config = &tsl2x7x_read_interrupt_config,
-		.write_event_config = &tsl2x7x_write_interrupt_config,
+		.read_event_value_new = &tsl2x7x_read_thresh,
+		.write_event_value_new = &tsl2x7x_write_thresh,
+		.read_event_config_new = &tsl2x7x_read_interrupt_config,
+		.write_event_config_new = &tsl2x7x_write_interrupt_config,
 	},
 	[PRX] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[PRX],
@@ -1678,10 +1683,10 @@ static const struct iio_info tsl2X7X_device_info[] = {
 		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
-		.read_event_value = &tsl2x7x_read_thresh,
-		.write_event_value = &tsl2x7x_write_thresh,
-		.read_event_config = &tsl2x7x_read_interrupt_config,
-		.write_event_config = &tsl2x7x_write_interrupt_config,
+		.read_event_value_new = &tsl2x7x_read_thresh,
+		.write_event_value_new = &tsl2x7x_write_thresh,
+		.read_event_config_new = &tsl2x7x_read_interrupt_config,
+		.write_event_config_new = &tsl2x7x_write_interrupt_config,
 	},
 	[ALSPRX] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[ALSPRX],
@@ -1689,10 +1694,10 @@ static const struct iio_info tsl2X7X_device_info[] = {
 		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
-		.read_event_value = &tsl2x7x_read_thresh,
-		.write_event_value = &tsl2x7x_write_thresh,
-		.read_event_config = &tsl2x7x_read_interrupt_config,
-		.write_event_config = &tsl2x7x_write_interrupt_config,
+		.read_event_value_new = &tsl2x7x_read_thresh,
+		.write_event_value_new = &tsl2x7x_write_thresh,
+		.read_event_config_new = &tsl2x7x_read_interrupt_config,
+		.write_event_config_new = &tsl2x7x_write_interrupt_config,
 	},
 	[PRX2] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[PRX2],
@@ -1700,10 +1705,10 @@ static const struct iio_info tsl2X7X_device_info[] = {
 		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
-		.read_event_value = &tsl2x7x_read_thresh,
-		.write_event_value = &tsl2x7x_write_thresh,
-		.read_event_config = &tsl2x7x_read_interrupt_config,
-		.write_event_config = &tsl2x7x_write_interrupt_config,
+		.read_event_value_new = &tsl2x7x_read_thresh,
+		.write_event_value_new = &tsl2x7x_write_thresh,
+		.read_event_config_new = &tsl2x7x_read_interrupt_config,
+		.write_event_config_new = &tsl2x7x_write_interrupt_config,
 	},
 	[ALSPRX2] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[ALSPRX2],
@@ -1711,10 +1716,24 @@ static const struct iio_info tsl2X7X_device_info[] = {
 		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
-		.read_event_value = &tsl2x7x_read_thresh,
-		.write_event_value = &tsl2x7x_write_thresh,
-		.read_event_config = &tsl2x7x_read_interrupt_config,
-		.write_event_config = &tsl2x7x_write_interrupt_config,
+		.read_event_value_new = &tsl2x7x_read_thresh,
+		.write_event_value_new = &tsl2x7x_write_thresh,
+		.read_event_config_new = &tsl2x7x_read_interrupt_config,
+		.write_event_config_new = &tsl2x7x_write_interrupt_config,
+	},
+};
+
+static const struct iio_event_spec tsl2x7x_events[] = {
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
 	},
 };
 
@@ -1733,7 +1752,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				BIT(IIO_CHAN_INFO_CALIBSCALE) |
 				BIT(IIO_CHAN_INFO_CALIBBIAS),
-			.event_mask = TSL2X7X_EVENT_MASK
+			.event_spec = tsl2x7x_events,
+			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
@@ -1750,7 +1770,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.indexed = 1,
 			.channel = 0,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-			.event_mask = TSL2X7X_EVENT_MASK
+			.event_spec = tsl2x7x_events,
+			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
 			},
 		},
 	.chan_table_elements = 1,
@@ -1770,7 +1791,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				BIT(IIO_CHAN_INFO_CALIBSCALE) |
 				BIT(IIO_CHAN_INFO_CALIBBIAS),
-			.event_mask = TSL2X7X_EVENT_MASK
+			.event_spec = tsl2x7x_events,
+			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
@@ -1781,7 +1803,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.indexed = 1,
 			.channel = 0,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-			.event_mask = TSL2X7X_EVENT_MASK
+			.event_spec = tsl2x7x_events,
+			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
 			},
 		},
 	.chan_table_elements = 4,
@@ -1795,7 +1818,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.channel = 0,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				BIT(IIO_CHAN_INFO_CALIBSCALE),
-			.event_mask = TSL2X7X_EVENT_MASK
+			.event_spec = tsl2x7x_events,
+			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
 			},
 		},
 	.chan_table_elements = 1,
@@ -1815,7 +1839,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				BIT(IIO_CHAN_INFO_CALIBSCALE) |
 				BIT(IIO_CHAN_INFO_CALIBBIAS),
-			.event_mask = TSL2X7X_EVENT_MASK
+			.event_spec = tsl2x7x_events,
+			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
@@ -1827,7 +1852,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.channel = 0,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				BIT(IIO_CHAN_INFO_CALIBSCALE),
-			.event_mask = TSL2X7X_EVENT_MASK
+			.event_spec = tsl2x7x_events,
+			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
 			},
 		},
 	.chan_table_elements = 4,
-- 
1.8.0

