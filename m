Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/18] iio:max1363: Switch to new event config interface
Date: Thu, 26 Sep 2013 14:58:21 +0200
Message-Id: <1380200317-19355-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1380200317-19355-1-git-send-email-lars@metafoo.de>
References: <1380200317-19355-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Switch the max1363 driver to the new IIO event config interface as the old one
is going to be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/max1363.c | 196 +++++++++++++++++++++++++---------------------
 1 file changed, 107 insertions(+), 89 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index b4bc166..44343dc 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -424,11 +424,21 @@ static const enum max1363_modes max1363_mode_list[] = {
 	d0m1to2m3, d1m0to3m2,
 };
 
-#define MAX1363_EV_M						\
-	(IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING)	\
-	 | IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING))
+static const struct iio_event_spec max1363_events[] = {
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
 
-#define MAX1363_CHAN_U(num, addr, si, bits, evmask)			\
+#define MAX1363_CHAN_U(num, addr, si, bits, ev_spec, num_ev_spec)	\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.indexed = 1,						\
@@ -444,11 +454,12 @@ static const enum max1363_modes max1363_mode_list[] = {
 			.endianness = IIO_BE,				\
 		},							\
 		.scan_index = si,					\
-		.event_mask = evmask,					\
+		.event_spec = ev_spec,					\
+		.num_event_specs = num_ev_spec,				\
 	}
 
 /* bipolar channel */
-#define MAX1363_CHAN_B(num, num2, addr, si, bits, evmask)		\
+#define MAX1363_CHAN_B(num, num2, addr, si, bits, ev_spec, num_ev_spec)	\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.differential = 1,					\
@@ -466,28 +477,32 @@ static const enum max1363_modes max1363_mode_list[] = {
 			.endianness = IIO_BE,				\
 		},							\
 		.scan_index = si,					\
-		.event_mask = evmask,					\
+		.event_spec = ev_spec,					\
+		.num_event_specs = num_ev_spec,				\
 	}
 
-#define MAX1363_4X_CHANS(bits, em) {			\
-	MAX1363_CHAN_U(0, _s0, 0, bits, em),		\
-	MAX1363_CHAN_U(1, _s1, 1, bits, em),		\
-	MAX1363_CHAN_U(2, _s2, 2, bits, em),		\
-	MAX1363_CHAN_U(3, _s3, 3, bits, em),		\
-	MAX1363_CHAN_B(0, 1, d0m1, 4, bits, em),	\
-	MAX1363_CHAN_B(2, 3, d2m3, 5, bits, em),	\
-	MAX1363_CHAN_B(1, 0, d1m0, 6, bits, em),	\
-	MAX1363_CHAN_B(3, 2, d3m2, 7, bits, em),	\
-	IIO_CHAN_SOFT_TIMESTAMP(8)			\
+#define MAX1363_4X_CHANS(bits, ev_spec, num_ev_spec) {			\
+	MAX1363_CHAN_U(0, _s0, 0, bits, ev_spec, num_ev_spec),		\
+	MAX1363_CHAN_U(1, _s1, 1, bits, ev_spec, num_ev_spec),		\
+	MAX1363_CHAN_U(2, _s2, 2, bits, ev_spec, num_ev_spec),		\
+	MAX1363_CHAN_U(3, _s3, 3, bits, ev_spec, num_ev_spec),		\
+	MAX1363_CHAN_B(0, 1, d0m1, 4, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(2, 3, d2m3, 5, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(1, 0, d1m0, 6, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(3, 2, d3m2, 7, bits, ev_spec, num_ev_spec),	\
+	IIO_CHAN_SOFT_TIMESTAMP(8)					\
 	}
 
-static const struct iio_chan_spec max1036_channels[] = MAX1363_4X_CHANS(8, 0);
-static const struct iio_chan_spec max1136_channels[] = MAX1363_4X_CHANS(10, 0);
-static const struct iio_chan_spec max1236_channels[] = MAX1363_4X_CHANS(12, 0);
+static const struct iio_chan_spec max1036_channels[] =
+	MAX1363_4X_CHANS(8, NULL, 0);
+static const struct iio_chan_spec max1136_channels[] =
+	MAX1363_4X_CHANS(10, NULL, 0);
+static const struct iio_chan_spec max1236_channels[] =
+	MAX1363_4X_CHANS(12, NULL, 0);
 static const struct iio_chan_spec max1361_channels[] =
-	MAX1363_4X_CHANS(10, MAX1363_EV_M);
+	MAX1363_4X_CHANS(10, max1363_events, ARRAY_SIZE(max1363_events));
 static const struct iio_chan_spec max1363_channels[] =
-	MAX1363_4X_CHANS(12, MAX1363_EV_M);
+	MAX1363_4X_CHANS(12, max1363_events, ARRAY_SIZE(max1363_events));
 
 /* Applies to max1236, max1237 */
 static const enum max1363_modes max1236_mode_list[] = {
@@ -511,32 +526,32 @@ static const enum max1363_modes max1238_mode_list[] = {
 	d6m7to8m9, d6m7to10m11, d7m6to9m8, d7m6to11m10,
 };
 
-#define MAX1363_12X_CHANS(bits) {			\
-	MAX1363_CHAN_U(0, _s0, 0, bits, 0),		\
-	MAX1363_CHAN_U(1, _s1, 1, bits, 0),		\
-	MAX1363_CHAN_U(2, _s2, 2, bits, 0),		\
-	MAX1363_CHAN_U(3, _s3, 3, bits, 0),		\
-	MAX1363_CHAN_U(4, _s4, 4, bits, 0),		\
-	MAX1363_CHAN_U(5, _s5, 5, bits, 0),		\
-	MAX1363_CHAN_U(6, _s6, 6, bits, 0),		\
-	MAX1363_CHAN_U(7, _s7, 7, bits, 0),		\
-	MAX1363_CHAN_U(8, _s8, 8, bits, 0),		\
-	MAX1363_CHAN_U(9, _s9, 9, bits, 0),		\
-	MAX1363_CHAN_U(10, _s10, 10, bits, 0),		\
-	MAX1363_CHAN_U(11, _s11, 11, bits, 0),		\
-	MAX1363_CHAN_B(0, 1, d0m1, 12, bits, 0),	\
-	MAX1363_CHAN_B(2, 3, d2m3, 13, bits, 0),	\
-	MAX1363_CHAN_B(4, 5, d4m5, 14, bits, 0),	\
-	MAX1363_CHAN_B(6, 7, d6m7, 15, bits, 0),	\
-	MAX1363_CHAN_B(8, 9, d8m9, 16, bits, 0),	\
-	MAX1363_CHAN_B(10, 11, d10m11, 17, bits, 0),	\
-	MAX1363_CHAN_B(1, 0, d1m0, 18, bits, 0),	\
-	MAX1363_CHAN_B(3, 2, d3m2, 19, bits, 0),	\
-	MAX1363_CHAN_B(5, 4, d5m4, 20, bits, 0),	\
-	MAX1363_CHAN_B(7, 6, d7m6, 21, bits, 0),	\
-	MAX1363_CHAN_B(9, 8, d9m8, 22, bits, 0),	\
-	MAX1363_CHAN_B(11, 10, d11m10, 23, bits, 0),	\
-	IIO_CHAN_SOFT_TIMESTAMP(24)			\
+#define MAX1363_12X_CHANS(bits) {				\
+	MAX1363_CHAN_U(0, _s0, 0, bits, NULL, 0),		\
+	MAX1363_CHAN_U(1, _s1, 1, bits, NULL, 0),		\
+	MAX1363_CHAN_U(2, _s2, 2, bits, NULL, 0),		\
+	MAX1363_CHAN_U(3, _s3, 3, bits, NULL, 0),		\
+	MAX1363_CHAN_U(4, _s4, 4, bits, NULL, 0),		\
+	MAX1363_CHAN_U(5, _s5, 5, bits, NULL, 0),		\
+	MAX1363_CHAN_U(6, _s6, 6, bits, NULL, 0),		\
+	MAX1363_CHAN_U(7, _s7, 7, bits, NULL, 0),		\
+	MAX1363_CHAN_U(8, _s8, 8, bits, NULL, 0),		\
+	MAX1363_CHAN_U(9, _s9, 9, bits, NULL, 0),		\
+	MAX1363_CHAN_U(10, _s10, 10, bits, NULL, 0),		\
+	MAX1363_CHAN_U(11, _s11, 11, bits, NULL, 0),		\
+	MAX1363_CHAN_B(0, 1, d0m1, 12, bits, NULL, 0),		\
+	MAX1363_CHAN_B(2, 3, d2m3, 13, bits, NULL, 0),		\
+	MAX1363_CHAN_B(4, 5, d4m5, 14, bits, NULL, 0),		\
+	MAX1363_CHAN_B(6, 7, d6m7, 15, bits, NULL, 0),		\
+	MAX1363_CHAN_B(8, 9, d8m9, 16, bits, NULL, 0),		\
+	MAX1363_CHAN_B(10, 11, d10m11, 17, bits, NULL, 0),	\
+	MAX1363_CHAN_B(1, 0, d1m0, 18, bits, NULL, 0),		\
+	MAX1363_CHAN_B(3, 2, d3m2, 19, bits, NULL, 0),		\
+	MAX1363_CHAN_B(5, 4, d5m4, 20, bits, NULL, 0),		\
+	MAX1363_CHAN_B(7, 6, d7m6, 21, bits, NULL, 0),		\
+	MAX1363_CHAN_B(9, 8, d9m8, 22, bits, NULL, 0),		\
+	MAX1363_CHAN_B(11, 10, d11m10, 23, bits, NULL, 0),	\
+	IIO_CHAN_SOFT_TIMESTAMP(24)				\
 	}
 static const struct iio_chan_spec max1038_channels[] = MAX1363_12X_CHANS(8);
 static const struct iio_chan_spec max1138_channels[] = MAX1363_12X_CHANS(10);
@@ -561,22 +576,22 @@ static const enum max1363_modes max11608_mode_list[] = {
 };
 
 #define MAX1363_8X_CHANS(bits) {			\
-	MAX1363_CHAN_U(0, _s0, 0, bits, 0),		\
-	MAX1363_CHAN_U(1, _s1, 1, bits, 0),		\
-	MAX1363_CHAN_U(2, _s2, 2, bits, 0),		\
-	MAX1363_CHAN_U(3, _s3, 3, bits, 0),		\
-	MAX1363_CHAN_U(4, _s4, 4, bits, 0),		\
-	MAX1363_CHAN_U(5, _s5, 5, bits, 0),		\
-	MAX1363_CHAN_U(6, _s6, 6, bits, 0),		\
-	MAX1363_CHAN_U(7, _s7, 7, bits, 0),		\
-	MAX1363_CHAN_B(0, 1, d0m1, 8, bits, 0),	\
-	MAX1363_CHAN_B(2, 3, d2m3, 9, bits, 0),	\
-	MAX1363_CHAN_B(4, 5, d4m5, 10, bits, 0),	\
-	MAX1363_CHAN_B(6, 7, d6m7, 11, bits, 0),	\
-	MAX1363_CHAN_B(1, 0, d1m0, 12, bits, 0),	\
-	MAX1363_CHAN_B(3, 2, d3m2, 13, bits, 0),	\
-	MAX1363_CHAN_B(5, 4, d5m4, 14, bits, 0),	\
-	MAX1363_CHAN_B(7, 6, d7m6, 15, bits, 0),	\
+	MAX1363_CHAN_U(0, _s0, 0, bits, NULL, 0),	\
+	MAX1363_CHAN_U(1, _s1, 1, bits, NULL, 0),	\
+	MAX1363_CHAN_U(2, _s2, 2, bits, NULL, 0),	\
+	MAX1363_CHAN_U(3, _s3, 3, bits, NULL, 0),	\
+	MAX1363_CHAN_U(4, _s4, 4, bits, NULL, 0),	\
+	MAX1363_CHAN_U(5, _s5, 5, bits, NULL, 0),	\
+	MAX1363_CHAN_U(6, _s6, 6, bits, NULL, 0),	\
+	MAX1363_CHAN_U(7, _s7, 7, bits, NULL, 0),	\
+	MAX1363_CHAN_B(0, 1, d0m1, 8, bits, NULL, 0),	\
+	MAX1363_CHAN_B(2, 3, d2m3, 9, bits, NULL, 0),	\
+	MAX1363_CHAN_B(4, 5, d4m5, 10, bits, NULL, 0),	\
+	MAX1363_CHAN_B(6, 7, d6m7, 11, bits, NULL, 0),	\
+	MAX1363_CHAN_B(1, 0, d1m0, 12, bits, NULL, 0),	\
+	MAX1363_CHAN_B(3, 2, d3m2, 13, bits, NULL, 0),	\
+	MAX1363_CHAN_B(5, 4, d5m4, 14, bits, NULL, 0),	\
+	MAX1363_CHAN_B(7, 6, d7m6, 15, bits, NULL, 0),	\
 	IIO_CHAN_SOFT_TIMESTAMP(16)			\
 }
 static const struct iio_chan_spec max11602_channels[] = MAX1363_8X_CHANS(8);
@@ -588,10 +603,10 @@ static const enum max1363_modes max11644_mode_list[] = {
 };
 
 #define MAX1363_2X_CHANS(bits) {			\
-	MAX1363_CHAN_U(0, _s0, 0, bits, 0),		\
-	MAX1363_CHAN_U(1, _s1, 1, bits, 0),		\
-	MAX1363_CHAN_B(0, 1, d0m1, 2, bits, 0),	\
-	MAX1363_CHAN_B(1, 0, d1m0, 3, bits, 0),	\
+	MAX1363_CHAN_U(0, _s0, 0, bits, NULL, 0),	\
+	MAX1363_CHAN_U(1, _s1, 1, bits, NULL, 0),	\
+	MAX1363_CHAN_B(0, 1, d0m1, 2, bits, NULL, 0),	\
+	MAX1363_CHAN_B(1, 0, d1m0, 3, bits, NULL, 0),	\
 	IIO_CHAN_SOFT_TIMESTAMP(4)			\
 	}
 
@@ -686,20 +701,20 @@ static IIO_CONST_ATTR(sampling_frequency_available,
 		"133000 665000 33300 16600 8300 4200 2000 1000");
 
 static int max1363_read_thresh(struct iio_dev *indio_dev,
-			       u64 event_code,
-			       int *val)
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, enum iio_event_info info, int *val)
 {
 	struct max1363_state *st = iio_priv(indio_dev);
-	if (IIO_EVENT_CODE_EXTRACT_DIR(event_code) == IIO_EV_DIR_FALLING)
-		*val = st->thresh_low[IIO_EVENT_CODE_EXTRACT_CHAN(event_code)];
+	if (dir == IIO_EV_DIR_FALLING)
+		*val = st->thresh_low[chan->channel];
 	else
-		*val = st->thresh_high[IIO_EVENT_CODE_EXTRACT_CHAN(event_code)];
+		*val = st->thresh_high[chan->channel];
 	return 0;
 }
 
 static int max1363_write_thresh(struct iio_dev *indio_dev,
-				u64 event_code,
-				int val)
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, enum iio_event_info info, int val)
 {
 	struct max1363_state *st = iio_priv(indio_dev);
 	/* make it handle signed correctly as well */
@@ -714,13 +729,15 @@ static int max1363_write_thresh(struct iio_dev *indio_dev,
 		break;
 	}
 
-	switch (IIO_EVENT_CODE_EXTRACT_DIR(event_code)) {
+	switch (dir) {
 	case IIO_EV_DIR_FALLING:
-		st->thresh_low[IIO_EVENT_CODE_EXTRACT_CHAN(event_code)] = val;
+		st->thresh_low[chan->channel] = val;
 		break;
 	case IIO_EV_DIR_RISING:
-		st->thresh_high[IIO_EVENT_CODE_EXTRACT_CHAN(event_code)] = val;
+		st->thresh_high[chan->channel] = val;
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	return 0;
@@ -765,14 +782,15 @@ static irqreturn_t max1363_event_handler(int irq, void *private)
 }
 
 static int max1363_read_event_config(struct iio_dev *indio_dev,
-				     u64 event_code)
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir)
 {
 	struct max1363_state *st = iio_priv(indio_dev);
 	int val;
-	int number = IIO_EVENT_CODE_EXTRACT_CHAN(event_code);
+	int number = chan->channel;
 
 	mutex_lock(&indio_dev->mlock);
-	if (IIO_EVENT_CODE_EXTRACT_DIR(event_code) == IIO_EV_DIR_FALLING)
+	if (dir == IIO_EV_DIR_FALLING)
 		val = (1 << number) & st->mask_low;
 	else
 		val = (1 << number) & st->mask_high;
@@ -917,17 +935,17 @@ error_ret:
 }
 
 static int max1363_write_event_config(struct iio_dev *indio_dev,
-				      u64 event_code,
-				      int state)
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, int state)
 {
 	int ret = 0;
 	struct max1363_state *st = iio_priv(indio_dev);
 	u16 unifiedmask;
-	int number = IIO_EVENT_CODE_EXTRACT_CHAN(event_code);
+	int number = chan->channel;
 
 	mutex_lock(&indio_dev->mlock);
 	unifiedmask = st->mask_low | st->mask_high;
-	if (IIO_EVENT_CODE_EXTRACT_DIR(event_code) == IIO_EV_DIR_FALLING) {
+	if (dir == IIO_EV_DIR_FALLING) {
 
 		if (state == 0)
 			st->mask_low &= ~(1 << number);
@@ -995,10 +1013,10 @@ static const struct iio_info max1238_info = {
 };
 
 static const struct iio_info max1363_info = {
-	.read_event_value = &max1363_read_thresh,
-	.write_event_value = &max1363_write_thresh,
-	.read_event_config = &max1363_read_event_config,
-	.write_event_config = &max1363_write_event_config,
+	.read_event_value_new = &max1363_read_thresh,
+	.write_event_value_new = &max1363_write_thresh,
+	.read_event_config_new = &max1363_read_event_config,
+	.write_event_config_new = &max1363_write_event_config,
 	.read_raw = &max1363_read_raw,
 	.update_scan_mode = &max1363_update_scan_mode,
 	.driver_module = THIS_MODULE,
-- 
1.8.0
