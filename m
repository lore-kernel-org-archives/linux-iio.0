Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:33719 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755786Ab1HRMVv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Aug 2011 08:21:51 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: michael.hennerich@analog.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio: Differential channel handling - use explicit flag rather than types.
Date: Thu, 18 Aug 2011 13:29:42 +0100
Message-Id: <1313670582-31970-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <4E4D00ED.4080106@analog.com>
References: <4E4D00ED.4080106@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Straight forward change in the core, but required some drivers to not use
the IIO_CHAN macro as that doesn't allow setting this bit (and is
going away anyway). Hence the churn.

Tested on max1363 with a couple of supported parts.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7152.c        |    8 +-
 drivers/staging/iio/adc/ad7192.c        |    8 +-
 drivers/staging/iio/adc/ad7793.c        |  176 ++++++++++++++++++++--------
 drivers/staging/iio/adc/max1363_core.c  |  198 ++++++++++++++-----------------
 drivers/staging/iio/iio.h               |    4 +-
 drivers/staging/iio/industrialio-core.c |   40 ++++---
 drivers/staging/iio/sysfs.h             |    8 +-
 7 files changed, 253 insertions(+), 189 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/adc/ad7152.c
index 0809bb1..debcea5 100644
--- a/drivers/staging/iio/adc/ad7152.c
+++ b/drivers/staging/iio/adc/ad7152.c
@@ -241,7 +241,7 @@ static int ad7152_read_raw(struct iio_dev *dev_info,
 	switch (mask) {
 	case 0:
 		/* First set whether in differential mode */
-		if (chan->type == IIO_CAPACITANCE_DIFF)
+		if (chan->differential)
 			regval = (1 << 5);
 
 		/* Make sure the channel is enabled */
@@ -319,7 +319,8 @@ static const struct iio_chan_spec ad7152_channels[] = {
 		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
 		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
 	}, {
-		.type = IIO_CAPACITANCE_DIFF,
+		.type = IIO_CAPACITANCE,
+		.differential = 1,
 		.indexed = 1,
 		.channel = 0,
 		.channel2 = 2,
@@ -327,7 +328,8 @@ static const struct iio_chan_spec ad7152_channels[] = {
 		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
 		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
 	}, {
-		.type = IIO_CAPACITANCE_DIFF,
+		.type = IIO_CAPACITANCE,
+		.differential = 1,
 		.indexed = 1,
 		.channel = 1,
 		.channel2 = 3,
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
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index b42a7ac..b5e1cc7 100644
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
index aacc49b..399d27f 100644
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
index 53315c1..6902745 100644
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
@@ -43,7 +42,6 @@ enum iio_chan_type {
 	IIO_ANGL,
 	IIO_TIMESTAMP,
 	IIO_CAPACITANCE,
-	IIO_CAPACITANCE_DIFF,
 };
 
 /* Nasty hack to avoid massive churn */
@@ -125,6 +123,7 @@ enum iio_endian {
  *			the value in channel will be suppressed for attribute
  *			but not for event codes. Typically set it to 0 when
  *			the index is false.
+ * @differential:	Channel is differential.
  */
 struct iio_chan_spec {
 	enum iio_chan_type	type;
@@ -146,6 +145,7 @@ struct iio_chan_spec {
 	unsigned		modified:1;
 	unsigned		indexed:1;
 	unsigned		output:1;
+	unsigned		differential:1;
 };
 
 #define IIO_ST(si, rb, sb, sh)						\
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 07a5066..d4d13f4 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -54,7 +54,6 @@ static const char * const iio_chan_type_name_spec_shared[] = {
 	[IIO_CURRENT] = "current",
 	[IIO_POWER] = "power",
 	[IIO_ACCEL] = "accel",
-	[IIO_VOLTAGE_DIFF] = "voltage-voltage",
 	[IIO_GYRO] = "gyro",
 	[IIO_MAGN] = "magn",
 	[IIO_LIGHT] = "illuminance",
@@ -66,12 +65,6 @@ static const char * const iio_chan_type_name_spec_shared[] = {
 	[IIO_ANGL] = "angl",
 	[IIO_TIMESTAMP] = "timestamp",
 	[IIO_CAPACITANCE] = "capacitance",
-	[IIO_CAPACITANCE_DIFF] = "capacitance-capacitance",
-};
-
-static const char * const iio_chan_type_name_spec_complex[] = {
-	[IIO_VOLTAGE_DIFF] = "voltage%d-voltage%d",
-	[IIO_CAPACITANCE_DIFF] = "capacitance%d-capacitance%d",
 };
 
 static const char * const iio_modifier_names[] = {
@@ -449,13 +442,21 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 		goto error_ret;
 
 	/* Special case for types that uses both channel numbers in naming */
-	if (((chan->type == IIO_VOLTAGE_DIFF) ||
-	     (chan->type == IIO_CAPACITANCE_DIFF)) &&
-	    !generic)
+	if (chan->differential && !generic)
 		name_format
-			= kasprintf(GFP_KERNEL, "%s_%s_%s",
+			= kasprintf(GFP_KERNEL, "%s_%s%d-%s%d_%s",
 				    iio_direction[chan->output],
-				    iio_chan_type_name_spec_complex[chan->type],
+				    iio_chan_type_name_spec_shared[chan->type],
+				    chan->channel,
+				    iio_chan_type_name_spec_shared[chan->type],
+				    chan->channel2,
+				    full_postfix);
+	else if (chan->differential && generic)
+		name_format
+			= kasprintf(GFP_KERNEL, "%s_%s-%s_%s",
+				    iio_direction[chan->output],
+				    iio_chan_type_name_spec_shared[chan->type],
+				    iio_chan_type_name_spec_shared[chan->type],
 				    full_postfix);
 	else if (generic || !chan->indexed)
 		name_format
@@ -797,13 +798,14 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 			mask = IIO_MOD_EVENT_CODE(chan->type, 0, chan->channel,
 						  i/IIO_EV_DIR_MAX,
 						  i%IIO_EV_DIR_MAX);
-		else if ((chan->type == IIO_VOLTAGE_DIFF) ||
-			 (chan->type == IIO_CAPACITANCE_DIFF))
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
index 3388b8c..0c04d93 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -128,9 +128,9 @@ enum iio_event_direction {
 	IIO_EV_DIR_FALLING,
 };
 
-#define IIO_EVENT_CODE(chan_type, modifier, direction,			\
+#define IIO_EVENT_CODE(chan_type, diff, modifier, direction,	\
 		       type, chan, chan1, chan2)			\
-	(((u64)type << 56) | ((u64)direction << 48) | ((u64)modifier << 40) | \
+	(((u64)type << 56) | ((u64)diff << 48) | ((u64)direction << 47) | ((u64)modifier << 40) | \
 	 ((u64)chan_type << 32) | (chan2 << 16) | chan1 | chan)
 
 #define IIO_EV_DIR_MAX 4
@@ -139,10 +139,10 @@ enum iio_event_direction {
 
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

