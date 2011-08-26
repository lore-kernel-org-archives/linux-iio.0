Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 12/12] staging:iio: Differential channel handling - use explicit flag rather than types.
Date: Fri, 26 Aug 2011 11:16:35 +0100
Message-Id: <1314353795-7437-13-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
References: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Straight forward change in the core, but required some drivers to not use
the IIO_CHAN macro as that doesn't allow setting this bit (and is
going away anyway). Hence the churn.

Tested on max1363 with a couple of supported parts.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7192.c        |    8 +-
 drivers/staging/iio/adc/ad7280a.c       |   26 +++--
 drivers/staging/iio/adc/ad7793.c        |  176 ++++++++++++++++++++--------
 drivers/staging/iio/adc/max1363_core.c  |  198 ++++++++++++++-----------------
 drivers/staging/iio/iio.h               |    3 +-
 drivers/staging/iio/industrialio-core.c |  145 ++++++++++++-----------
 drivers/staging/iio/sysfs.h             |    9 +-
 7 files changed, 322 insertions(+), 243 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index c67da6a..5bc1051 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -886,8 +886,7 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 			((1 << (chan->scan_type.realbits)) - 1);
 
 		switch (chan->type) {
-		case IIO_IN:
-		case IIO_IN_DIFF:
+		case IIO_VOLTAGE:
 			if (!unipolar)
 				*val -= (1 << (chan->scan_type.realbits - 1));
 			break;
@@ -986,7 +985,8 @@ static const struct iio_info ad7192_info = {
 };
 
 #define AD7192_CHAN_DIFF(_chan, _chan2, _name, _address, _si)		\
-	{ .type = IIO_IN_DIFF,						\
+	{ .type = IIO_VOLTAGE,						\
+	  .differential = 1,						\
 	  .indexed = 1,							\
 	  .extend_name = _name,						\
 	  .channel = _chan,						\
@@ -997,7 +997,7 @@ static const struct iio_info ad7192_info = {
 	  .scan_type =  IIO_ST('s', 24, 32, 0)}
 
 #define AD7192_CHAN(_chan, _address, _si)				\
-	{ .type = IIO_IN,						\
+	{ .type = IIO_VOLTAGE,						\
 	  .indexed = 1,							\
 	  .channel = _chan,						\
 	  .info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),		\
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index bdc325d..2d8d650 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -495,7 +495,8 @@ static int ad7280_channel_init(struct ad7280_state *st)
 		for (ch = AD7280A_CELL_VOLTAGE_1; ch <= AD7280A_AUX_ADC_6; ch++,
 			cnt++) {
 			if (ch < AD7280A_AUX_ADC_1) {
-				st->channels[cnt].type = IIO_IN_DIFF;
+				st->channels[cnt].type = IIO_VOLTAGE;
+				st->channels[cnt].differential = 1;
 				st->channels[cnt].channel = (dev * 6) + ch;
 				st->channels[cnt].channel2 =
 					st->channels[cnt].channel + 1;
@@ -515,7 +516,8 @@ static int ad7280_channel_init(struct ad7280_state *st)
 			st->channels[cnt].scan_type.shift = 0;
 		}
 
-	st->channels[cnt].type = IIO_IN_DIFF;
+	st->channels[cnt].type = IIO_VOLTAGE;
+	st->channels[cnt].differential = 1;
 	st->channels[cnt].channel = 0;
 	st->channels[cnt].channel2 = dev * 6;
 	st->channels[cnt].address = AD7280A_ALL_CELLS;
@@ -692,18 +694,22 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 			if (((channels[i] >> 11) & 0xFFF) >=
 				st->cell_threshhigh)
 				iio_push_event(dev_info,
-					IIO_UNMOD_EVENT_CODE(IIO_IN_DIFF,
-					0,
-					IIO_EV_TYPE_THRESH,
-					IIO_EV_DIR_RISING),
+					IIO_EVENT_CODE(IIO_VOLTAGE,
+						       1,
+						       0,
+						       IIO_EV_DIR_RISING,
+						       IIO_EV_TYPE_THRESH,
+						       0, 0, 0),
 					iio_get_time_ns());
 			else if (((channels[i] >> 11) & 0xFFF) <=
 				st->cell_threshlow)
 				iio_push_event(dev_info,
-					IIO_UNMOD_EVENT_CODE(IIO_IN_DIFF,
-					0,
-					IIO_EV_TYPE_THRESH,
-					IIO_EV_DIR_FALLING),
+					IIO_EVENT_CODE(IIO_VOLTAGE,
+						       1,
+						       0,
+						       IIO_EV_DIR_FALLING,
+						       IIO_EV_TYPE_THRESH,
+						       0, 0, 0),
 					iio_get_time_ns());
 		} else {
 			if (((channels[i] >> 11) & 0xFFF) >= st->aux_threshhigh)
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 17d18fc..7044ed2 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -767,57 +767,137 @@ static const struct iio_info ad7793_info = {
 
 static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 	[ID_AD7793] = {
-		.channel[0] = IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 0, 0,
-				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				    AD7793_CH_AIN1P_AIN1M,
-				    0, IIO_ST('s', 24, 32, 0), 0),
-		.channel[1] = IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 1, 1,
-				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				    AD7793_CH_AIN2P_AIN2M,
-				    1, IIO_ST('s', 24, 32, 0), 0),
-		.channel[2] = IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 2, 2,
-				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				    AD7793_CH_AIN3P_AIN3M,
-				    2, IIO_ST('s', 24, 32, 0), 0),
-		.channel[3] = IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, "shorted", 0, 0,
-				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				    AD7793_CH_AIN1M_AIN1M,
-				    3, IIO_ST('s', 24, 32, 0), 0),
-		.channel[4] = IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
-				    (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-				    AD7793_CH_TEMP,
-				    4, IIO_ST('s', 24, 32, 0), 0),
-		.channel[5] = IIO_CHAN(IIO_IN, 0, 1, 0, "supply", 4, 0,
-				    (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-				    AD7793_CH_AVDD_MONITOR,
-				    5, IIO_ST('s', 24, 32, 0), 0),
+		.channel[0] = {
+			.type = IIO_VOLTAGE,
+			.differential = 1,
+			.indexed = 1,
+			.channel = 0,
+			.channel2 = 0,
+			.address = AD7793_CH_AIN1P_AIN1M,
+			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+			.scan_index = 0,
+			.scan_type = IIO_ST('s', 24, 32, 0)
+		},
+		.channel[1] = {
+			.type = IIO_VOLTAGE,
+			.differential = 1,
+			.indexed = 1,
+			.channel = 1,
+			.channel2 = 1,
+			.address = AD7793_CH_AIN2P_AIN2M,
+			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+			.scan_index = 1,
+			.scan_type = IIO_ST('s', 24, 32, 0)
+		},
+		.channel[2] = {
+			.type = IIO_VOLTAGE,
+			.differential = 1,
+			.indexed = 1,
+			.channel = 2,
+			.channel2 = 2,
+			.address = AD7793_CH_AIN3P_AIN3M,
+			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+			.scan_index = 2,
+			.scan_type = IIO_ST('s', 24, 32, 0)
+		},
+		.channel[3] = {
+			.type = IIO_VOLTAGE,
+			.differential = 1,
+			.extend_name = "shorted",
+			.indexed = 1,
+			.channel = 2,
+			.channel2 = 2,
+			.address = AD7793_CH_AIN1M_AIN1M,
+			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+			.scan_index = 2,
+			.scan_type = IIO_ST('s', 24, 32, 0)
+		},
+		.channel[4] = {
+			.type = IIO_TEMP,
+			.indexed = 1,
+			.channel = 0,
+			.address = AD7793_CH_TEMP,
+			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+			.scan_index = 4,
+			.scan_type = IIO_ST('s', 24, 32, 0),
+		},
+		.channel[5] = {
+			.type = IIO_VOLTAGE,
+			.extend_name = "supply",
+			.indexed = 1,
+			.channel = 4,
+			.address = AD7793_CH_AVDD_MONITOR,
+			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+			.scan_index = 5,
+			.scan_type = IIO_ST('s', 24, 32, 0),
+		},
 		.channel[6] = IIO_CHAN_SOFT_TIMESTAMP(6),
 	},
 	[ID_AD7792] = {
-		.channel[0] = IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 0, 0,
-				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				    AD7793_CH_AIN1P_AIN1M,
-				    0, IIO_ST('s', 16, 32, 0), 0),
-		.channel[1] = IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 1, 1,
-				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				    AD7793_CH_AIN2P_AIN2M,
-				    1, IIO_ST('s', 16, 32, 0), 0),
-		.channel[2] = IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 2, 2,
-				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				    AD7793_CH_AIN3P_AIN3M,
-				    2, IIO_ST('s', 16, 32, 0), 0),
-		.channel[3] = IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, "shorted", 0, 0,
-				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				    AD7793_CH_AIN1M_AIN1M,
-				    3, IIO_ST('s', 16, 32, 0), 0),
-		.channel[4] = IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
-				    (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-				    AD7793_CH_TEMP,
-				    4, IIO_ST('s', 16, 32, 0), 0),
-		.channel[5] = IIO_CHAN(IIO_IN, 0, 1, 0, "supply", 4, 0,
-				    (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-				    AD7793_CH_AVDD_MONITOR,
-				    5, IIO_ST('s', 16, 32, 0), 0),
+		.channel[0] = {
+			.type = IIO_VOLTAGE,
+			.differential = 1,
+			.indexed = 1,
+			.channel = 0,
+			.channel2 = 0,
+			.address = AD7793_CH_AIN1P_AIN1M,
+			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+			.scan_index = 0,
+			.scan_type = IIO_ST('s', 16, 32, 0)
+		},
+		.channel[1] = {
+			.type = IIO_VOLTAGE,
+			.differential = 1,
+			.indexed = 1,
+			.channel = 1,
+			.channel2 = 1,
+			.address = AD7793_CH_AIN2P_AIN2M,
+			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+			.scan_index = 1,
+			.scan_type = IIO_ST('s', 16, 32, 0)
+		},
+		.channel[2] = {
+			.type = IIO_VOLTAGE,
+			.differential = 1,
+			.indexed = 1,
+			.channel = 2,
+			.channel2 = 2,
+			.address = AD7793_CH_AIN3P_AIN3M,
+			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+			.scan_index = 2,
+			.scan_type = IIO_ST('s', 16, 32, 0)
+		},
+		.channel[3] = {
+			.type = IIO_VOLTAGE,
+			.differential = 1,
+			.extend_name = "shorted",
+			.indexed = 1,
+			.channel = 2,
+			.channel2 = 2,
+			.address = AD7793_CH_AIN1M_AIN1M,
+			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+			.scan_index = 2,
+			.scan_type = IIO_ST('s', 16, 32, 0)
+		},
+		.channel[4] = {
+			.type = IIO_TEMP,
+			.indexed = 1,
+			.channel = 0,
+			.address = AD7793_CH_TEMP,
+			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+			.scan_index = 4,
+			.scan_type = IIO_ST('s', 16, 32, 0),
+		},
+		.channel[5] = {
+			.type = IIO_VOLTAGE,
+			.extend_name = "supply",
+			.indexed = 1,
+			.channel = 4,
+			.address = AD7793_CH_AVDD_MONITOR,
+			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+			.scan_index = 5,
+			.scan_type = IIO_ST('s', 16, 32, 0),
+		},
 		.channel[6] = IIO_CHAN_SOFT_TIMESTAMP(6),
 	},
 };
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 97db51d..8c7efaf 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -288,72 +288,52 @@ static const enum max1363_modes max1363_mode_list[] = {
 	(IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING)	\
 	 | IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING))
 #define MAX1363_INFO_MASK (1 << IIO_CHAN_INFO_SCALE_SHARED)
+#define MAX1363_CHAN_U(num, addr, si, bits, evmask)			\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.channel = num,						\
+		.address = addr,					\
+		.info_mask = MAX1363_INFO_MASK,				\
+		.scan_type = IIO_ST('u', bits, (bits > 8) ? 16 : 8, 0), \
+		.scan_index = si,					\
+		.event_mask = evmask,					\
+	}
 
-static struct iio_chan_spec max1363_channels[] = {
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0, MAX1363_INFO_MASK,
-		 _s0, 0, IIO_ST('u', 12, 16, 0), MAX1363_EV_M),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0, MAX1363_INFO_MASK,
-		 _s1, 1, IIO_ST('u', 12, 16, 0), MAX1363_EV_M),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0, MAX1363_INFO_MASK,
-		 _s2, 2, IIO_ST('u', 12, 16, 0), MAX1363_EV_M),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0, MAX1363_INFO_MASK,
-		 _s3, 3, IIO_ST('u', 12, 16, 0), MAX1363_EV_M),
-	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 0, 1, MAX1363_INFO_MASK,
-		 d0m1, 4, IIO_ST('s', 12, 16, 0), MAX1363_EV_M),
-	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 2, 3, MAX1363_INFO_MASK,
-		 d2m3, 5, IIO_ST('s', 12, 16, 0), MAX1363_EV_M),
-	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 1, 0, MAX1363_INFO_MASK,
-		 d1m0, 6, IIO_ST('s', 12, 16, 0), MAX1363_EV_M),
-	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 3, 2, MAX1363_INFO_MASK,
-		 d3m2, 7, IIO_ST('s', 12, 16, 0), MAX1363_EV_M),
-	IIO_CHAN_SOFT_TIMESTAMP(8)
-};
-
-static struct iio_chan_spec max1361_channels[] = {
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0, MAX1363_INFO_MASK,
-		 _s0, 0, IIO_ST('u', 10, 16, 0), MAX1363_EV_M),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0, MAX1363_INFO_MASK,
-		 _s1, 1, IIO_ST('u', 10, 16, 0), MAX1363_EV_M),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0, MAX1363_INFO_MASK,
-		 _s2, 2, IIO_ST('u', 10, 16, 0), MAX1363_EV_M),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0, MAX1363_INFO_MASK,
-		 _s3, 3, IIO_ST('u', 10, 16, 0), MAX1363_EV_M),
-	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 0, 1, MAX1363_INFO_MASK,
-		 d0m1, 4, IIO_ST('s', 10, 16, 0), MAX1363_EV_M),
-	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 2, 3, MAX1363_INFO_MASK,
-		 d2m3, 5, IIO_ST('s', 10, 16, 0), MAX1363_EV_M),
-	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 1, 0, MAX1363_INFO_MASK,
-		 d1m0, 6, IIO_ST('s', 10, 16, 0), MAX1363_EV_M),
-	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, 3, 2, MAX1363_INFO_MASK,
-		 d3m2, 7, IIO_ST('s', 10, 16, 0), MAX1363_EV_M),
-	IIO_CHAN_SOFT_TIMESTAMP(8)
-};
-
-#define MAX1363_CHAN_U(num, address, scan_index, bits)		\
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, num, 0, MAX1363_INFO_MASK,	\
-		 address, scan_index, IIO_ST('u', bits,		\
-					     (bits == 8) ? 8 : 16, 0), 0)
 /* bipolar channel */
-#define MAX1363_CHAN_B(num, num2, address, scan_index, bits)		\
-	IIO_CHAN(IIO_IN_DIFF, 0, 1, 0, NULL, num, num2, MAX1363_INFO_MASK,\
-		 address, scan_index, IIO_ST('s', bits,		\
-					     (bits == 8) ? 8 : 16, 0), 0)
-
-#define MAX1363_4X_CHANS(bits) {		\
-	MAX1363_CHAN_U(0, _s0, 0, bits),	\
-	MAX1363_CHAN_U(1, _s1, 1, bits),	\
-	MAX1363_CHAN_U(2, _s2, 2, bits),	\
-	MAX1363_CHAN_U(3, _s3, 3, bits),	\
-	MAX1363_CHAN_B(0, 1, d0m1, 4, bits),	\
-	MAX1363_CHAN_B(2, 3, d2m3, 5, bits),	\
-	MAX1363_CHAN_B(1, 0, d1m0, 6, bits),	\
-	MAX1363_CHAN_B(3, 2, d3m2, 7, bits),	\
-	IIO_CHAN_SOFT_TIMESTAMP(8)		\
+#define MAX1363_CHAN_B(num, num2, addr, si, bits, evmask)		\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.differential = 1,					\
+		.indexed = 1,						\
+		.channel = num,						\
+		.channel2 = num2,					\
+		.address = addr,					\
+		.info_mask = MAX1363_INFO_MASK,				\
+		.scan_type = IIO_ST('u', bits, (bits > 8) ? 16 : 8, 0), \
+		.scan_index = si,					\
+		.event_mask = evmask,					\
 	}
 
-static struct iio_chan_spec max1036_channels[] = MAX1363_4X_CHANS(8);
-static struct iio_chan_spec max1136_channels[] = MAX1363_4X_CHANS(10);
-static struct iio_chan_spec max1236_channels[] = MAX1363_4X_CHANS(12);
+#define MAX1363_4X_CHANS(bits, em) {			\
+	MAX1363_CHAN_U(0, _s0, 0, bits, em),		\
+	MAX1363_CHAN_U(1, _s1, 1, bits, em),		\
+	MAX1363_CHAN_U(2, _s2, 2, bits, em),		\
+	MAX1363_CHAN_U(3, _s3, 3, bits, em),		\
+	MAX1363_CHAN_B(0, 1, d0m1, 4, bits, em),	\
+	MAX1363_CHAN_B(2, 3, d2m3, 5, bits, em),	\
+	MAX1363_CHAN_B(1, 0, d1m0, 6, bits, em),	\
+	MAX1363_CHAN_B(3, 2, d3m2, 7, bits, em),	\
+	IIO_CHAN_SOFT_TIMESTAMP(8)			\
+	}
+
+static struct iio_chan_spec max1036_channels[] = MAX1363_4X_CHANS(8, 0);
+static struct iio_chan_spec max1136_channels[] = MAX1363_4X_CHANS(10, 0);
+static struct iio_chan_spec max1236_channels[] = MAX1363_4X_CHANS(12, 0);
+static struct iio_chan_spec max1361_channels[] =
+	MAX1363_4X_CHANS(10, MAX1363_EV_M);
+static struct iio_chan_spec max1363_channels[] =
+	MAX1363_4X_CHANS(12, MAX1363_EV_M);
 
 /* Appies to max1236, max1237 */
 static const enum max1363_modes max1236_mode_list[] = {
@@ -378,30 +358,30 @@ static const enum max1363_modes max1238_mode_list[] = {
 };
 
 #define MAX1363_12X_CHANS(bits) {			\
-	MAX1363_CHAN_U(0, _s0, 0, bits),		\
-	MAX1363_CHAN_U(1, _s1, 1, bits),		\
-	MAX1363_CHAN_U(2, _s2, 2, bits),		\
-	MAX1363_CHAN_U(3, _s3, 3, bits),		\
-	MAX1363_CHAN_U(4, _s4, 4, bits),		\
-	MAX1363_CHAN_U(5, _s5, 5, bits),		\
-	MAX1363_CHAN_U(6, _s6, 6, bits),		\
-	MAX1363_CHAN_U(7, _s7, 7, bits),		\
-	MAX1363_CHAN_U(8, _s8, 8, bits),		\
-	MAX1363_CHAN_U(9, _s9, 9, bits),		\
-	MAX1363_CHAN_U(10, _s10, 10, bits),		\
-	MAX1363_CHAN_U(11, _s11, 11, bits),		\
-	MAX1363_CHAN_B(0, 1, d0m1, 12, bits),		\
-	MAX1363_CHAN_B(2, 3, d2m3, 13, bits),		\
-	MAX1363_CHAN_B(4, 5, d4m5, 14, bits),		\
-	MAX1363_CHAN_B(6, 7, d6m7, 15, bits),		\
-	MAX1363_CHAN_B(8, 9, d8m9, 16, bits),		\
-	MAX1363_CHAN_B(10, 11, d10m11, 17, bits),	\
-	MAX1363_CHAN_B(1, 0, d1m0, 18, bits),		\
-	MAX1363_CHAN_B(3, 2, d3m2, 19, bits),		\
-	MAX1363_CHAN_B(5, 4, d5m4, 20, bits),		\
-	MAX1363_CHAN_B(7, 6, d7m6, 21, bits),		\
-	MAX1363_CHAN_B(9, 8, d9m8, 22, bits),		\
-	MAX1363_CHAN_B(11, 10, d11m10, 23, bits),	\
+	MAX1363_CHAN_U(0, _s0, 0, bits, 0),		\
+	MAX1363_CHAN_U(1, _s1, 1, bits, 0),		\
+	MAX1363_CHAN_U(2, _s2, 2, bits, 0),		\
+	MAX1363_CHAN_U(3, _s3, 3, bits, 0),		\
+	MAX1363_CHAN_U(4, _s4, 4, bits, 0),		\
+	MAX1363_CHAN_U(5, _s5, 5, bits, 0),		\
+	MAX1363_CHAN_U(6, _s6, 6, bits, 0),		\
+	MAX1363_CHAN_U(7, _s7, 7, bits, 0),		\
+	MAX1363_CHAN_U(8, _s8, 8, bits, 0),		\
+	MAX1363_CHAN_U(9, _s9, 9, bits, 0),		\
+	MAX1363_CHAN_U(10, _s10, 10, bits, 0),		\
+	MAX1363_CHAN_U(11, _s11, 11, bits, 0),		\
+	MAX1363_CHAN_B(0, 1, d0m1, 12, bits, 0),	\
+	MAX1363_CHAN_B(2, 3, d2m3, 13, bits, 0),	\
+	MAX1363_CHAN_B(4, 5, d4m5, 14, bits, 0),	\
+	MAX1363_CHAN_B(6, 7, d6m7, 15, bits, 0),	\
+	MAX1363_CHAN_B(8, 9, d8m9, 16, bits, 0),	\
+	MAX1363_CHAN_B(10, 11, d10m11, 17, bits, 0),	\
+	MAX1363_CHAN_B(1, 0, d1m0, 18, bits, 0),	\
+	MAX1363_CHAN_B(3, 2, d3m2, 19, bits, 0),	\
+	MAX1363_CHAN_B(5, 4, d5m4, 20, bits, 0),	\
+	MAX1363_CHAN_B(7, 6, d7m6, 21, bits, 0),	\
+	MAX1363_CHAN_B(9, 8, d9m8, 22, bits, 0),	\
+	MAX1363_CHAN_B(11, 10, d11m10, 23, bits, 0),	\
 	IIO_CHAN_SOFT_TIMESTAMP(24)			\
 	}
 static struct iio_chan_spec max1038_channels[] = MAX1363_12X_CHANS(8);
@@ -426,25 +406,25 @@ static const enum max1363_modes max11608_mode_list[] = {
 	d1m0to3m2, d1m0to5m4, d1m0to7m6,
 };
 
-#define MAX1363_8X_CHANS(bits) {				\
-		MAX1363_CHAN_U(0, _s0, 0, bits),		\
-			MAX1363_CHAN_U(1, _s1, 1, bits),	\
-			MAX1363_CHAN_U(2, _s2, 2, bits),	\
-			MAX1363_CHAN_U(3, _s3, 3, bits),	\
-			MAX1363_CHAN_U(4, _s4, 4, bits),	\
-			MAX1363_CHAN_U(5, _s5, 5, bits),	\
-			MAX1363_CHAN_U(6, _s6, 6, bits),	\
-			MAX1363_CHAN_U(7, _s7, 7, bits),	\
-			MAX1363_CHAN_B(0, 1, d0m1, 8, bits),	\
-			MAX1363_CHAN_B(2, 3, d2m3, 9, bits),	\
-			MAX1363_CHAN_B(4, 5, d4m5, 10, bits),	\
-			MAX1363_CHAN_B(6, 7, d6m7, 11, bits),	\
-			MAX1363_CHAN_B(1, 0, d1m0, 12, bits),	\
-			MAX1363_CHAN_B(3, 2, d3m2, 13, bits),	\
-			MAX1363_CHAN_B(5, 4, d5m4, 14, bits),	\
-			MAX1363_CHAN_B(7, 6, d7m6, 15, bits),	\
-			IIO_CHAN_SOFT_TIMESTAMP(16)		\
-		}
+#define MAX1363_8X_CHANS(bits) {			\
+	MAX1363_CHAN_U(0, _s0, 0, bits, 0),		\
+	MAX1363_CHAN_U(1, _s1, 1, bits, 0),		\
+	MAX1363_CHAN_U(2, _s2, 2, bits, 0),		\
+	MAX1363_CHAN_U(3, _s3, 3, bits, 0),		\
+	MAX1363_CHAN_U(4, _s4, 4, bits, 0),		\
+	MAX1363_CHAN_U(5, _s5, 5, bits, 0),		\
+	MAX1363_CHAN_U(6, _s6, 6, bits, 0),		\
+	MAX1363_CHAN_U(7, _s7, 7, bits, 0),		\
+	MAX1363_CHAN_B(0, 1, d0m1, 8, bits, 0),	\
+	MAX1363_CHAN_B(2, 3, d2m3, 9, bits, 0),	\
+	MAX1363_CHAN_B(4, 5, d4m5, 10, bits, 0),	\
+	MAX1363_CHAN_B(6, 7, d6m7, 11, bits, 0),	\
+	MAX1363_CHAN_B(1, 0, d1m0, 12, bits, 0),	\
+	MAX1363_CHAN_B(3, 2, d3m2, 13, bits, 0),	\
+	MAX1363_CHAN_B(5, 4, d5m4, 14, bits, 0),	\
+	MAX1363_CHAN_B(7, 6, d7m6, 15, bits, 0),	\
+	IIO_CHAN_SOFT_TIMESTAMP(16)			\
+}
 static struct iio_chan_spec max11602_channels[] = MAX1363_8X_CHANS(8);
 static struct iio_chan_spec max11608_channels[] = MAX1363_8X_CHANS(10);
 static struct iio_chan_spec max11614_channels[] = MAX1363_8X_CHANS(12);
@@ -454,10 +434,10 @@ static const enum max1363_modes max11644_mode_list[] = {
 };
 
 #define MAX1363_2X_CHANS(bits) {			\
-	MAX1363_CHAN_U(0, _s0, 0, bits),		\
-	MAX1363_CHAN_U(1, _s1, 1, bits),		\
-	MAX1363_CHAN_B(0, 1, d0m1, 2, bits),		\
-	MAX1363_CHAN_B(1, 0, d1m0, 3, bits),		\
+	MAX1363_CHAN_U(0, _s0, 0, bits, 0),		\
+	MAX1363_CHAN_U(1, _s1, 1, bits, 0),		\
+	MAX1363_CHAN_B(0, 1, d0m1, 2, bits, 0),	\
+	MAX1363_CHAN_B(1, 0, d1m0, 3, bits, 0),	\
 	IIO_CHAN_SOFT_TIMESTAMP(4)			\
 	}
 
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 742f6c6..8ef04f8 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -31,7 +31,6 @@ enum iio_chan_type {
 	IIO_CURRENT,
 	IIO_POWER,
 	IIO_ACCEL,
-	IIO_VOLTAGE_DIFF,
 	IIO_GYRO,
 	IIO_MAGN,
 	IIO_LIGHT,
@@ -124,6 +123,7 @@ enum iio_endian {
  *			the value in channel will be suppressed for attribute
  *			but not for event codes. Typically set it to 0 when
  *			the index is false.
+ * @differential:	Channel is differential.
  */
 struct iio_chan_spec {
 	enum iio_chan_type	type;
@@ -145,6 +145,7 @@ struct iio_chan_spec {
 	unsigned		modified:1;
 	unsigned		indexed:1;
 	unsigned		output:1;
+	unsigned		differential:1;
 };
 
 #define IIO_ST(si, rb, sb, sh)						\
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 83e55b1..fd4aada 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -49,12 +49,11 @@ static const char * const iio_direction[] = {
 	[1] = "out",
 };
 
-static const char * const iio_chan_type_name_spec_shared[] = {
+static const char * const iio_chan_type_name_spec[] = {
 	[IIO_VOLTAGE] = "voltage",
 	[IIO_CURRENT] = "current",
 	[IIO_POWER] = "power",
 	[IIO_ACCEL] = "accel",
-	[IIO_VOLTAGE_DIFF] = "voltage-voltage",
 	[IIO_GYRO] = "gyro",
 	[IIO_MAGN] = "magn",
 	[IIO_LIGHT] = "illuminance",
@@ -68,10 +67,6 @@ static const char * const iio_chan_type_name_spec_shared[] = {
 	[IIO_CAPACITANCE] = "capacitance",
 };
 
-static const char * const iio_chan_type_name_spec_complex[] = {
-	[IIO_VOLTAGE_DIFF] = "voltage%d-voltage%d",
-};
-
 static const char * const iio_modifier_names[] = {
 	[IIO_MOD_X] = "x",
 	[IIO_MOD_Y] = "y",
@@ -158,7 +153,6 @@ error_ret:
 }
 EXPORT_SYMBOL(iio_push_event);
 
-
 /* This turns up an awful lot */
 ssize_t iio_read_const_attr(struct device *dev,
 			    struct device_attribute *attr,
@@ -168,7 +162,6 @@ ssize_t iio_read_const_attr(struct device *dev,
 }
 EXPORT_SYMBOL(iio_read_const_attr);
 
-
 static ssize_t iio_event_chrdev_read(struct file *filep,
 				     char __user *buf,
 				     size_t count,
@@ -397,36 +390,6 @@ static ssize_t iio_write_channel_info(struct device *dev,
 	return len;
 }
 
-static int __iio_build_postfix(struct iio_chan_spec const *chan,
-			       bool generic,
-			       const char *postfix,
-			       char **result)
-{
-	char *all_post;
-	/* 3 options - generic, extend_name, modified - if generic, extend_name
-	* and modified cannot apply.*/
-
-	if (generic || (!chan->modified && !chan->extend_name)) {
-		all_post = kasprintf(GFP_KERNEL, "%s", postfix);
-	} else if (chan->modified) {
-		if (chan->extend_name)
-			all_post = kasprintf(GFP_KERNEL, "%s_%s_%s",
-					     iio_modifier_names[chan->channel2],
-					     chan->extend_name,
-					     postfix);
-		else
-			all_post = kasprintf(GFP_KERNEL, "%s_%s",
-					     iio_modifier_names[chan->channel2],
-					     postfix);
-	} else
-		all_post = kasprintf(GFP_KERNEL, "%s_%s", chan->extend_name,
-				     postfix);
-	if (all_post == NULL)
-		return -ENOMEM;
-	*result = all_post;
-	return 0;
-}
-
 static
 int __iio_device_attr_init(struct device_attribute *dev_attr,
 			   const char *postfix,
@@ -443,31 +406,77 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 	int ret;
 	char *name_format, *full_postfix;
 	sysfs_attr_init(&dev_attr->attr);
-	ret = __iio_build_postfix(chan, generic, postfix, &full_postfix);
-	if (ret)
-		goto error_ret;
 
-	/* Special case for types that uses both channel numbers in naming */
-	if (chan->type == IIO_VOLTAGE_DIFF && !generic)
-		name_format
-			= kasprintf(GFP_KERNEL, "%s_%s_%s",
-				    iio_direction[chan->output],
-				    iio_chan_type_name_spec_complex[chan->type],
-				    full_postfix);
-	else if (generic || !chan->indexed)
-		name_format
-			= kasprintf(GFP_KERNEL, "%s_%s_%s",
-				    iio_direction[chan->output],
-				    iio_chan_type_name_spec_shared[chan->type],
-				    full_postfix);
-	else
-		name_format
-			= kasprintf(GFP_KERNEL, "%s_%s%d_%s",
-				    iio_direction[chan->output],
-				    iio_chan_type_name_spec_shared[chan->type],
-				    chan->channel,
-				    full_postfix);
+	/* Build up postfix of <extend_name>_<modifier>_postfix */
+	if (chan->modified) {
+		if (chan->extend_name)
+			full_postfix = kasprintf(GFP_KERNEL, "%s_%s_%s",
+						 iio_modifier_names[chan
+								    ->channel2],
+						 chan->extend_name,
+						 postfix);
+		else
+			full_postfix = kasprintf(GFP_KERNEL, "%s_%s",
+						 iio_modifier_names[chan
+								    ->channel2],
+						 postfix);
+	} else {
+		if (chan->extend_name == NULL)
+			full_postfix = kstrdup(postfix, GFP_KERNEL);
+		else
+			full_postfix = kasprintf(GFP_KERNEL,
+						 "%s_%s",
+						 chan->extend_name,
+						 postfix);
+	}
+	if (full_postfix == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
 
+	if (chan->differential) { /* Differential  can not have modifier */
+		if (generic)
+			name_format
+				= kasprintf(GFP_KERNEL, "%s_%s-%s_%s",
+					    iio_direction[chan->output],
+					    iio_chan_type_name_spec[chan->type],
+					    iio_chan_type_name_spec[chan->type],
+					    full_postfix);
+		else if (chan->indexed)
+			name_format
+				= kasprintf(GFP_KERNEL, "%s_%s%d-%s%d_%s",
+					    iio_direction[chan->output],
+					    iio_chan_type_name_spec[chan->type],
+					    chan->channel,
+					    iio_chan_type_name_spec[chan->type],
+					    chan->channel2,
+					    full_postfix);
+		else {
+			WARN_ON("Differential channels must be indexed\n");
+			ret = -EINVAL;
+			goto error_free_full_postfix;
+		}
+	} else { /* Single ended */
+		if (generic)
+			name_format
+				= kasprintf(GFP_KERNEL, "%s_%s_%s",
+					    iio_direction[chan->output],
+					    iio_chan_type_name_spec[chan->type],
+					    full_postfix);
+		else if (chan->indexed)
+			name_format
+				= kasprintf(GFP_KERNEL, "%s_%s%d_%s",
+					    iio_direction[chan->output],
+					    iio_chan_type_name_spec[chan->type],
+					    chan->channel,
+					    full_postfix);
+		else
+			name_format
+				= kasprintf(GFP_KERNEL, "%s_%s_%s",
+					    iio_direction[chan->output],
+					    iio_chan_type_name_spec[chan->type],
+					    full_postfix);
+	}
 	if (name_format == NULL) {
 		ret = -ENOMEM;
 		goto error_free_full_postfix;
@@ -805,12 +814,14 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 			mask = IIO_MOD_EVENT_CODE(chan->type, 0, chan->channel,
 						  i/IIO_EV_DIR_MAX,
 						  i%IIO_EV_DIR_MAX);
-		else if (chan->type == IIO_VOLTAGE_DIFF)
-			mask = IIO_MOD_EVENT_CODE(chan->type,
-						  chan->channel,
-						  chan->channel2,
-						  i/IIO_EV_DIR_MAX,
-						  i%IIO_EV_DIR_MAX);
+		else if (chan->differential)
+			mask = IIO_EVENT_CODE(chan->type,
+					      0, 0,
+					      i%IIO_EV_DIR_MAX,
+					      i/IIO_EV_DIR_MAX,
+					      0,
+					      chan->channel,
+					      chan->channel2);
 		else
 			mask = IIO_UNMOD_EVENT_CODE(chan->type,
 						    chan->channel,
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 3388b8c..aad1f4b 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -128,9 +128,10 @@ enum iio_event_direction {
 	IIO_EV_DIR_FALLING,
 };
 
-#define IIO_EVENT_CODE(chan_type, modifier, direction,			\
+#define IIO_EVENT_CODE(chan_type, diff, modifier, direction,		\
 		       type, chan, chan1, chan2)			\
-	(((u64)type << 56) | ((u64)direction << 48) | ((u64)modifier << 40) | \
+	(((u64)type << 56) | ((u64)diff << 48) |			\
+	 ((u64)direction << 47) | ((u64)modifier << 40) |		\
 	 ((u64)chan_type << 32) | (chan2 << 16) | chan1 | chan)
 
 #define IIO_EV_DIR_MAX 4
@@ -139,10 +140,10 @@ enum iio_event_direction {
 
 #define IIO_MOD_EVENT_CODE(channelclass, number, modifier,		\
 			   type, direction)				\
-	IIO_EVENT_CODE(channelclass, modifier, direction, type, number, 0, 0)
+	IIO_EVENT_CODE(channelclass, 0, modifier, direction, type, number, 0, 0)
 
 #define IIO_UNMOD_EVENT_CODE(channelclass, number, type, direction)	\
-	IIO_EVENT_CODE(channelclass, 0, direction, type, number, 0, 0)
+	IIO_EVENT_CODE(channelclass, 0, 0, direction, type, number, 0, 0)
 
 #define IIO_EVENT_CODE_EXTRACT_TYPE(mask) ((mask >> 56) & 0xFF)
 #define IIO_EVENT_CODE_EXTRACT_DIR(mask) ((mask >> 48) & 0xFF)
-- 
1.7.3.4
