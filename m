Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-020.synserver.de ([212.40.185.20]:1067 "EHLO
	smtp-out-017.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754969Ab3JGOJt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2013 10:09:49 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 12/20] staging:iio:ad799x: Switch to new event config interface
Date: Mon,  7 Oct 2013 16:11:26 +0200
Message-Id: <1381155094-20166-12-git-send-email-lars@metafoo.de>
In-Reply-To: <1381155094-20166-1-git-send-email-lars@metafoo.de>
References: <1381155094-20166-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Switch the ad799x driver to the new IIO event config interface as the old one
is going to be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad799x_core.c | 145 ++++++++++++++++++++--------------
 1 file changed, 85 insertions(+), 60 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index eb6a690..57bc540 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -252,7 +252,9 @@ error_ret_mutex:
 }
 
 static int ad799x_read_event_config(struct iio_dev *indio_dev,
-				    u64 event_code)
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir)
 {
 	return 1;
 }
@@ -265,14 +267,16 @@ static const u8 ad799x_threshold_addresses[][2] = {
 };
 
 static int ad799x_write_event_value(struct iio_dev *indio_dev,
-				    u64 event_code,
-				    int val)
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int val, int val2)
 {
 	int ret;
 	struct ad799x_state *st = iio_priv(indio_dev);
-	int direction = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
-			   IIO_EV_DIR_FALLING);
-	int number = IIO_EVENT_CODE_EXTRACT_CHAN(event_code);
+	int direction = dir == IIO_EV_DIR_FALLING;
+	int number = chan->channel;
 
 	mutex_lock(&indio_dev->mlock);
 	ret = ad799x_i2c_write16(st,
@@ -284,14 +288,16 @@ static int ad799x_write_event_value(struct iio_dev *indio_dev,
 }
 
 static int ad799x_read_event_value(struct iio_dev *indio_dev,
-				    u64 event_code,
-				    int *val)
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int *val, int *val2)
 {
 	int ret;
 	struct ad799x_state *st = iio_priv(indio_dev);
-	int direction = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
-			   IIO_EV_DIR_FALLING);
-	int number = IIO_EVENT_CODE_EXTRACT_CHAN(event_code);
+	int direction = dir == IIO_EV_DIR_FALLING;
+	int number = chan->channel;
 	u16 valin;
 
 	mutex_lock(&indio_dev->mlock);
@@ -303,7 +309,7 @@ static int ad799x_read_event_value(struct iio_dev *indio_dev,
 		return ret;
 	*val = valin;
 
-	return 0;
+	return IIO_VAL_INT;
 }
 
 static ssize_t ad799x_read_channel_config(struct device *dev,
@@ -446,26 +452,37 @@ static const struct iio_info ad7991_info = {
 static const struct iio_info ad7992_info = {
 	.read_raw = &ad799x_read_raw,
 	.event_attrs = &ad7992_event_attrs_group,
-	.read_event_config = &ad799x_read_event_config,
-	.read_event_value = &ad799x_read_event_value,
-	.write_event_value = &ad799x_write_event_value,
+	.read_event_config_new = &ad799x_read_event_config,
+	.read_event_value_new = &ad799x_read_event_value,
+	.write_event_value_new = &ad799x_write_event_value,
 	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info ad7993_4_7_8_info = {
 	.read_raw = &ad799x_read_raw,
 	.event_attrs = &ad7993_4_7_8_event_attrs_group,
-	.read_event_config = &ad799x_read_event_config,
-	.read_event_value = &ad799x_read_event_value,
-	.write_event_value = &ad799x_write_event_value,
+	.read_event_config_new = &ad799x_read_event_config,
+	.read_event_value_new = &ad799x_read_event_value,
+	.write_event_value_new = &ad799x_write_event_value,
 	.driver_module = THIS_MODULE,
 	.update_scan_mode = ad7997_8_update_scan_mode,
 };
 
-#define AD799X_EV_MASK (IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) | \
-			IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING))
+static const struct iio_event_spec ad799x_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+			BIT(IIO_EV_INFO_ENABLE),
+	},
+};
 
-#define AD799X_CHANNEL(_index, _realbits, _evmask) { \
+#define _AD799X_CHANNEL(_index, _realbits, _ev_spec, _num_ev_spec) { \
 	.type = IIO_VOLTAGE, \
 	.indexed = 1, \
 	.channel = (_index), \
@@ -473,16 +490,24 @@ static const struct iio_info ad7993_4_7_8_info = {
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
 	.scan_index = (_index), \
 	.scan_type = IIO_ST('u', _realbits, 16, 12 - (_realbits)), \
-	.event_mask = (_evmask), \
+	.event_spec = _ev_spec, \
+	.num_event_specs = _num_ev_spec, \
 }
 
+#define AD799X_CHANNEL(_index, _realbits) \
+	_AD799X_CHANNEL(_index, _realbits, NULL, 0)
+
+#define AD799X_CHANNEL_WITH_EVENTS(_index, _realbits) \
+	_AD799X_CHANNEL(_index, _realbits, ad799x_events, \
+		ARRAY_SIZE(ad799x_events))
+
 static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	[ad7991] = {
 		.channel = {
-			AD799X_CHANNEL(0, 12, 0),
-			AD799X_CHANNEL(1, 12, 0),
-			AD799X_CHANNEL(2, 12, 0),
-			AD799X_CHANNEL(3, 12, 0),
+			AD799X_CHANNEL(0, 12),
+			AD799X_CHANNEL(1, 12),
+			AD799X_CHANNEL(2, 12),
+			AD799X_CHANNEL(3, 12),
 			IIO_CHAN_SOFT_TIMESTAMP(4),
 		},
 		.num_channels = 5,
@@ -490,10 +515,10 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 	[ad7995] = {
 		.channel = {
-			AD799X_CHANNEL(0, 10, 0),
-			AD799X_CHANNEL(1, 10, 0),
-			AD799X_CHANNEL(2, 10, 0),
-			AD799X_CHANNEL(3, 10, 0),
+			AD799X_CHANNEL(0, 10),
+			AD799X_CHANNEL(1, 10),
+			AD799X_CHANNEL(2, 10),
+			AD799X_CHANNEL(3, 10),
 			IIO_CHAN_SOFT_TIMESTAMP(4),
 		},
 		.num_channels = 5,
@@ -501,10 +526,10 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 	[ad7999] = {
 		.channel = {
-			AD799X_CHANNEL(0, 8, 0),
-			AD799X_CHANNEL(1, 8, 0),
-			AD799X_CHANNEL(2, 8, 0),
-			AD799X_CHANNEL(3, 8, 0),
+			AD799X_CHANNEL(0, 8),
+			AD799X_CHANNEL(1, 8),
+			AD799X_CHANNEL(2, 8),
+			AD799X_CHANNEL(3, 8),
 			IIO_CHAN_SOFT_TIMESTAMP(4),
 		},
 		.num_channels = 5,
@@ -512,8 +537,8 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 	[ad7992] = {
 		.channel = {
-			AD799X_CHANNEL(0, 12, AD799X_EV_MASK),
-			AD799X_CHANNEL(1, 12, AD799X_EV_MASK),
+			AD799X_CHANNEL_WITH_EVENTS(0, 12),
+			AD799X_CHANNEL_WITH_EVENTS(1, 12),
 			IIO_CHAN_SOFT_TIMESTAMP(3),
 		},
 		.num_channels = 3,
@@ -522,10 +547,10 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 	[ad7993] = {
 		.channel = {
-			AD799X_CHANNEL(0, 10, AD799X_EV_MASK),
-			AD799X_CHANNEL(1, 10, AD799X_EV_MASK),
-			AD799X_CHANNEL(2, 10, AD799X_EV_MASK),
-			AD799X_CHANNEL(3, 10, AD799X_EV_MASK),
+			AD799X_CHANNEL_WITH_EVENTS(0, 10),
+			AD799X_CHANNEL_WITH_EVENTS(1, 10),
+			AD799X_CHANNEL_WITH_EVENTS(2, 10),
+			AD799X_CHANNEL_WITH_EVENTS(3, 10),
 			IIO_CHAN_SOFT_TIMESTAMP(4),
 		},
 		.num_channels = 5,
@@ -534,10 +559,10 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 	[ad7994] = {
 		.channel = {
-			AD799X_CHANNEL(0, 12, AD799X_EV_MASK),
-			AD799X_CHANNEL(1, 12, AD799X_EV_MASK),
-			AD799X_CHANNEL(2, 12, AD799X_EV_MASK),
-			AD799X_CHANNEL(3, 12, AD799X_EV_MASK),
+			AD799X_CHANNEL_WITH_EVENTS(0, 12),
+			AD799X_CHANNEL_WITH_EVENTS(1, 12),
+			AD799X_CHANNEL_WITH_EVENTS(2, 12),
+			AD799X_CHANNEL_WITH_EVENTS(3, 12),
 			IIO_CHAN_SOFT_TIMESTAMP(4),
 		},
 		.num_channels = 5,
@@ -546,14 +571,14 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 	[ad7997] = {
 		.channel = {
-			AD799X_CHANNEL(0, 10, AD799X_EV_MASK),
-			AD799X_CHANNEL(1, 10, AD799X_EV_MASK),
-			AD799X_CHANNEL(2, 10, AD799X_EV_MASK),
-			AD799X_CHANNEL(3, 10, AD799X_EV_MASK),
-			AD799X_CHANNEL(4, 10, 0),
-			AD799X_CHANNEL(5, 10, 0),
-			AD799X_CHANNEL(6, 10, 0),
-			AD799X_CHANNEL(7, 10, 0),
+			AD799X_CHANNEL_WITH_EVENTS(0, 10),
+			AD799X_CHANNEL_WITH_EVENTS(1, 10),
+			AD799X_CHANNEL_WITH_EVENTS(2, 10),
+			AD799X_CHANNEL_WITH_EVENTS(3, 10),
+			AD799X_CHANNEL(4, 10),
+			AD799X_CHANNEL(5, 10),
+			AD799X_CHANNEL(6, 10),
+			AD799X_CHANNEL(7, 10),
 			IIO_CHAN_SOFT_TIMESTAMP(8),
 		},
 		.num_channels = 9,
@@ -562,14 +587,14 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 	[ad7998] = {
 		.channel = {
-			AD799X_CHANNEL(0, 12, AD799X_EV_MASK),
-			AD799X_CHANNEL(1, 12, AD799X_EV_MASK),
-			AD799X_CHANNEL(2, 12, AD799X_EV_MASK),
-			AD799X_CHANNEL(3, 12, AD799X_EV_MASK),
-			AD799X_CHANNEL(4, 12, 0),
-			AD799X_CHANNEL(5, 12, 0),
-			AD799X_CHANNEL(6, 12, 0),
-			AD799X_CHANNEL(7, 12, 0),
+			AD799X_CHANNEL_WITH_EVENTS(0, 12),
+			AD799X_CHANNEL_WITH_EVENTS(1, 12),
+			AD799X_CHANNEL_WITH_EVENTS(2, 12),
+			AD799X_CHANNEL_WITH_EVENTS(3, 12),
+			AD799X_CHANNEL(4, 12),
+			AD799X_CHANNEL(5, 12),
+			AD799X_CHANNEL(6, 12),
+			AD799X_CHANNEL(7, 12),
 			IIO_CHAN_SOFT_TIMESTAMP(8),
 		},
 		.num_channels = 9,
-- 
1.8.0

